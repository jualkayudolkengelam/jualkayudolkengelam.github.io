# TODO-1533: Component-Level Schema Implementation

**Status:** Discussion/Pending Decision
**Priority:** Medium
**Created:** 2025-11-16
**Dependencies:** TODO-1532 Phase 1-3 (core migration must complete first)
**Objective:** Implement component-owned schemas untuk better modularity, accuracy, and separation of concerns

---

## Context

### **Current Architecture Problem:**

Saat ini, layouts memiliki schema untuk content yang di-render oleh components:

```
Layout (_layouts/post-with-products.html):
├── Schema: Article + ItemList (ALL 6 products) ← Layout tahu tentang products!
└── HTML:
    ├── Blog content
    └── {% include related-products.html %} ← Component shows ONLY 3 products

❌ Problem:
- Schema says: 6 products
- Visual shows: 3 products
- MISMATCH!
```

**Issues:**
1. **Tight Coupling:** Layout harus tahu tentang component content
2. **Schema/Visual Mismatch:** Schema tidak akurat dengan apa yang ditampilkan
3. **Not Portable:** Component tidak bisa dipakai di layout lain tanpa modify schema
4. **Maintainability:** Edit component ≠ edit schema (terpisah di layout)
5. **Complexity:** Layout handle multiple concerns (main content + supplementary content)

---

## Foundation: Google's Multiple Structured Data Blocks

### 🎯 **Official Guideline:**

> **"You can add multiple structured data blocks to a single page. Each block can describe a different entity."**
>
> — [Google Search Central - Structured Data Guidelines](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data#multiple-items)

### **What This Enables:**

✅ **Multiple `<script type="application/ld+json">` tags per page are VALID**

**Each block:**
- Describes a different entity (Article, ItemList, Product, etc.)
- Validated independently by Google
- Can be placed anywhere in HTML (head or body)
- Doesn't need to be combined with @graph

**Example:**
```html
<html>
<head>
  <!-- Block 1: Article (from layout) -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Article",
    "headline": "Blog Post Title"
  }
  </script>
</head>
<body>
  <article>Blog content here</article>

  <!-- Block 2: ItemList (from component) -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "ItemList",
    "name": "Related Products",
    "numberOfItems": 3
  }
  </script>

  <section>
    <!-- 3 product cards here -->
  </section>
</body>
</html>
```

**Google validation result:**
```
✅ Detected 2 structured data types:
   1. Article
   2. ItemList (3 items)
```

---

## Proposed Architecture: Component-Owned Schemas

### **New Philosophy:**

**"Component = Schema + Markup + Logic"**

Each component owns its complete functionality:
```
Component:
├── Schema Block (what it contains)
├── Logic (how to get data)
└── Markup (how to display)
```

### **Benefits:**

#### 1. ✅ **Modularity**
- Component is self-contained
- Include component = get everything (schema + HTML)
- No need to modify layout when adding component

#### 2. ✅ **Accuracy**
- Schema describes exactly what's displayed
- 3 products in schema = 3 products shown
- No mismatch between data and visual

#### 3. ✅ **Portability**
- Use component in any layout
- Schema travels with component
- Consistent behavior across pages

#### 4. ✅ **Separation of Concerns**
- Layout: Main content schema (Article, Product, etc.)
- Component: Supplementary schema (ItemList, etc.)
- Clear responsibility boundaries

#### 5. ✅ **Maintainability**
- Edit component = edit both schema & markup in one place
- Single source of truth
- Easier debugging (find schema where component is)

#### 6. ✅ **Flexibility**
- Different components can have different schemas
- Easy to add/remove components
- No layout modification needed

---

## Current State Analysis

### **Components Under Review:**

| Component | Current State | Shows | Schema Location | Schema Content | Mismatch? |
|-----------|---------------|-------|-----------------|----------------|-----------|
| `related-products-by-last-modified.html` | ❌ No schema | 3 products (newest) | Layout has ItemList | ALL 6 products | ✅ YES |
| `related-products-by-node-id.html` | ❌ No schema | 3 products (rotated) | Layout has ItemList | ALL 6 products | ✅ YES |
| `related-articles.html` | ❌ No schema | 6 articles (latest + older) | None | N/A | ⚠️ Could add |
| `related-content-by-node-id.html` | ❌ No schema | 3 articles (proximity) | None | N/A | ⚠️ Could add |

### **Layouts Affected:**

| Layout | Current Schema | Component Used | Issue |
|--------|----------------|----------------|-------|
| `_layouts/post-with-products.html` | Article + ItemList (@graph) | `related-products-by-last-modified.html` | Layout knows about products (tight coupling) |
| `_layouts/post.html` | BlogPosting (to be added) | `related-products-by-last-modified.html` | Will need schema coordination |
| `_layouts/product.html` | Product + ItemList (@graph) | `related-products-by-node-id.html` | Layout knows about related products |

---

## Detailed Component Analysis

### **Component 1: related-products-by-last-modified.html**

**Current File Location:** `_includes/related-products-by-last-modified.html`

**What It Does:**
- Sorts products by `last_modified_at` (descending)
- Shows top 3 most recently updated products
- Displays badges: "Updated Today", "Recent" based on last update
- Shows product cards with image, title, price, rating, CTA buttons

**Current Schema Situation:**

**In Layout (`post-with-products.html`):**
```liquid
{
  "@graph": [
    { "@type": "Article", ... },
    {
      "@type": "ItemList",
      "numberOfItems": {{ site.products.size }},  ← ALL products (6)
      "itemListElement": [
        {% assign sorted_products = site.products | sort: "price" %}
        {% for product in sorted_products %}  ← Loop ALL
        ...
        {% endfor %}
      ]
    }
  ]
}
```

**In Component:**
```liquid
{% assign final_products = sorted_products | slice: 0, 3 %}  ← Show 3 only

<section>
  {% for product in final_products %}
    <!-- Show 3 products -->
  {% endfor %}
</section>
```

**❌ Mismatch:**
- Schema says: 6 products, sorted by price
- Visual shows: 3 products, sorted by last_modified_at
- **COMPLETELY DIFFERENT!**

---

**Proposed Solution:**

**In Layout (`post-with-products.html`):**
```liquid
<!-- Schema: Article ONLY -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "{{ page.title }}",
  ...
}
</script>
```

**In Component (`related-products-by-last-modified.html`):**
```liquid
{% comment %} Sort by last_modified_at {% endcomment %}
{% assign sorted_products = site.products | sort: "last_modified_at" | reverse %}
{% assign final_products = sorted_products | slice: 0, 3 %}

<!-- Schema: ItemList for ACTUAL displayed products -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "name": "Produk Kayu Dolken Terbaru",
  "description": "Produk yang baru diperbarui",
  "numberOfItems": {{ final_products.size }},  ← Accurate: 3
  "itemListElement": [
    {% for product in final_products %}
    {
      "@type": "ListItem",
      "position": {{ forloop.index }},
      "item": {
        "@type": "Product",
        "name": "{{ product.title }}",
        "url": "{{ product.url | absolute_url }}",
        "image": "{{ product.image | absolute_url }}",
        "sku": "{{ product.sku }}",
        "offers": {
          "@type": "Offer",
          "price": "{{ product.price }}",
          "priceCurrency": "IDR",
          "availability": "https://schema.org/InStock",
          "url": "{{ product.url | absolute_url }}"
        }{% if product.rating %},
        "aggregateRating": {
          "@type": "AggregateRating",
          "ratingValue": "{{ product.rating }}",
          "reviewCount": "{{ product.review_count | default: 45 }}"
        }{% endif %}
      }
    }{% unless forloop.last %},{% endunless %}
    {% endfor %}
  ]
}
</script>

<!-- Visual display -->
<section class="related-products-section">
  ...
</section>
```

**✅ Result:**
- Schema says: 3 products, sorted by last_modified_at
- Visual shows: 3 products, sorted by last_modified_at
- **PERFECT MATCH!**

---

### **Component 2: related-products-by-node-id.html**

**Current File Location:** `_includes/related-products-by-node-id.html`

**What It Does:**
- Node-based rotation system
- Each article shows different 3 products
- Article at position N shows products starting from `(N % total_products)`
- Ensures equal exposure for all products
- Skips current product if on product page

**Current Schema Situation:**

**In Layout (`product.html`):**
```liquid
{
  "@graph": [
    { "@type": "Product", ... },  ← Current product
    {
      "@type": "ItemList",
      "name": "Produk Lainnya",
      "itemListElement": [
        {% comment %} Node-based rotation logic {% endcomment %}
        {% for product in schema_products %}  ← 3 rotated products
        ...
        {% endfor %}
      ]
    }
  ]
}
```

**Issue:**
- Layout has duplicate logic for rotation (once for visual, once for schema)
- If component logic changes, schema must change too
- Tight coupling between layout and component

---

**Proposed Solution:**

**In Layout (`product.html`):**
```liquid
<!-- Schema: Product ONLY -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "{{ page.title }}",
  "description": "{{ page.description }}",
  ...
}
</script>
```

**In Component (`related-products-by-node-id.html`):**
```liquid
{% comment %} Node-based rotation logic {% endcomment %}
{% assign current_index = ... %}
{% assign selected_products = ... %}  ← 3 rotated products

<!-- Schema: ItemList for rotated products -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "name": "Produk Kayu Dolken Terkait",
  "description": "Pilihan ukuran untuk kebutuhan proyek Anda",
  "numberOfItems": {{ selected_products.size }},
  "itemListElement": [
    {% for product in selected_products %}
    {
      "@type": "ListItem",
      "position": {{ forloop.index }},
      "item": {
        "@type": "Product",
        "name": "{{ product.title }}",
        "url": "{{ product.url | absolute_url }}",
        ...
      }
    }{% unless forloop.last %},{% endunless %}
    {% endfor %}
  ]
}
</script>

<!-- Visual display -->
<section class="related-products-section">
  ...
</section>
```

**✅ Benefits:**
- Single source of truth (component has both logic and schema)
- No duplication between visual and schema
- Component fully self-contained

---

### **Component 3: related-articles.html**

**Current File Location:** `_includes/related-articles.html`

**What It Does:**
- Shows 3 latest posts + 3 older posts (relative to current post)
- Total: up to 6 articles
- Combines `site.posts` + `site.post_with_product` collections
- Displays with image, excerpt, engagement stats

**Current Schema Situation:**
- ❌ **No schema at all**
- Articles displayed but not structured for search engines
- Missing opportunity for rich results

**Question:** Should we add ItemList schema?

---

**Proposed Solution (if YES to schema):**

**In Component (`related-articles.html`):**
```liquid
{% comment %} Get related articles (existing logic) {% endcomment %}
{% assign all_related = latest_posts | concat: older_posts %}

<!-- Schema: ItemList for related articles -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "name": "Artikel Terkait",
  "description": "Artikel blog terkait dengan topik ini",
  "numberOfItems": {{ all_related.size }},
  "itemListElement": [
    {% for post in all_related %}
    {
      "@type": "ListItem",
      "position": {{ forloop.index }},
      "item": {
        "@type": "BlogPosting",
        "headline": "{{ post.title }}",
        "url": "{{ post.url | absolute_url }}",
        "image": "{% if post.image %}{{ post.image | absolute_url }}{% endif %}",
        "datePublished": "{{ post.date | date_to_xmlschema }}",
        "author": {
          "@type": "Person",
          "name": "{{ post.author | default: 'Admin' }}"
        }
      }
    }{% unless forloop.last %},{% endunless %}
    {% endfor %}
  ]
}
</script>

<!-- Visual display -->
<div class="related-content-section">
  ...
</div>
```

**Pros:**
- ✅ Rich results for article lists
- ✅ Better SEO for internal linking
- ✅ Consistent with product components

**Cons:**
- ⚠️ Each article already has its own BlogPosting schema on its page
- ⚠️ Is ItemList necessary for articles? (discussion needed)

---

### **Component 4: related-content-by-node-id.html**

**Current File Location:** `_includes/related-content-by-node-id.html`

**What It Does:**
- Shows 3 articles near current article's position
- Proximity-based recommendations
- Circular wrapping (if at start, wraps to end)

**Current Schema Situation:**
- ❌ **No schema**

**Analysis:** Same considerations as Component 3

---

## Decision Framework

### **Questions to Answer:**

#### 1. **Which components should have schemas?**

| Component | Add Schema? | Reasoning |
|-----------|-------------|-----------|
| `related-products-by-last-modified.html` | ✅ **YES** | Products benefit from structured data, enables rich results |
| `related-products-by-node-id.html` | ✅ **YES** | Same as above, consistency |
| `related-articles.html` | ❓ **DISCUSS** | Articles already have individual schemas, is list schema needed? |
| `related-content-by-node-id.html` | ❓ **DISCUSS** | Same consideration as above |

**Decision for Articles:** ________________ (Date: ________)

Options:
- [ ] A: Yes, add ItemList schema (consistency with products, better SEO)
- [ ] B: No, individual BlogPosting schemas sufficient
- [ ] C: Conditional - only if list >3 articles

---

#### 2. **When to implement?**

| Timing | Pros | Cons |
|--------|------|------|
| **Now (after TODO-1532 Phase 3)** | Momentum, fresh context, complete solution | More work upfront, delay core migration completion |
| **Separate phase (1-2 weeks later)** | Focus on core first, time to test, gather feedback | May lose context, additional coordination needed |
| **Defer (3+ months)** | Lower priority, focus on other features | May never get done, technical debt accumulates |

**Decision:** ________________ (Date: ________)

---

#### 3. **Scope of implementation?**

| Scope | What to Implement | Estimated Time |
|-------|-------------------|----------------|
| **Minimal** | Only `related-products-by-last-modified.html` | 1 hour |
| **Medium** | Both product components | 2 hours |
| **Full** | All 4 components (products + articles) | 3-4 hours |

**Decision:** ________________ (Date: ________)

---

#### 4. **Handle product.html layout?**

Current: `_layouts/product.html` has Product + ItemList via @graph

Options:
- [ ] **A:** Keep as-is (Product + ItemList in layout is logical grouping)
- [ ] **B:** Move ItemList to component (full consistency)
- [ ] **C:** Keep @graph but make ItemList data come from component

**Reasoning for each:**

**Option A (Keep as-is):**
- @graph shows relationship (this Product has these related Products)
- Semantically correct
- Less work

**Option B (Move to component):**
- Full consistency with post-with-products approach
- Component fully self-contained
- More refactoring needed

**Option C (Hybrid):**
- Keep semantic relationship in @graph
- But data comes from component
- Complex, may not add value

**Decision:** ________________ (Date: ________)

---

## Implementation Plan

### **Phase 1: Prepare Layouts** (Remove ItemList from layouts)

#### Task 1.1: Simplify post-with-products.html Layout

**File:** `_layouts/post-with-products.html`
**Lines:** 138-283

**Current:**
```liquid
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Article",
      "headline": "{{ page.title }}",
      ...
    }{% if page.show_products %},
    {
      "@type": "ItemList",
      "name": "Daftar Produk Kayu Dolken Gelam",
      "numberOfItems": {{ site.products.size }},
      "itemListElement": [
        {% assign sorted_products = site.products | sort: "price" %}
        {% for product in sorted_products %}
        {
          "@type": "Product",
          ...
        }{% unless forloop.last %},{% endunless %}
        {% endfor %}
      ]
    }{% endif %}
  ]
}
</script>
```

**After:**
```liquid
<!-- Schema.org Article (Blog Post Only) -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "{{ page.title }}",
  "description": "{{ page.description | strip_html | strip_newlines | escape }}",
  "url": "{{ page.url | absolute_url }}",
  "image": [
    {% if page.images %}
      {% for image in page.images %}
      "{{ image | absolute_url }}"{% unless forloop.last %},{% endunless %}
      {% endfor %}
    {% elsif page.image %}
      "{{ page.image | absolute_url }}"
    {% endif %}
  ],
  "datePublished": "{{ page.date | date_to_xmlschema }}",
  "dateModified": "{% if page.last_modified_at %}{{ page.last_modified_at | date_to_xmlschema }}{% else %}{{ page.date | date_to_xmlschema }}{% endif %}",
  "author": {
    "@type": "Person",
    "name": "{% if page.author %}{{ page.author }}{% else %}Admin{% endif %}"{% if page.author_url %},
    "url": "{{ page.author_url }}"{% endif %}
  },
  "publisher": {
    "@type": "Organization",
    "name": "{{ site.business.name }}",
    "logo": {
      "@type": "ImageObject",
      "url": "{{ '/assets/images/jual-kayu-dolken-gelam-lokalbisnis-001.jpeg' | absolute_url }}"
    }
  },
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "{{ page.url | absolute_url }}"
  }{% if page.like_count or page.comment_count or page.share_count %},
  "interactionStatistic": [
    {% if page.like_count %}
    {
      "@type": "InteractionCounter",
      "interactionType": "https://schema.org/LikeAction",
      "userInteractionCount": {{ page.like_count }}
    }{% if page.comment_count or page.share_count %},{% endif %}
    {% endif %}
    {% if page.comment_count %}
    {
      "@type": "InteractionCounter",
      "interactionType": "https://schema.org/CommentAction",
      "userInteractionCount": {{ page.comment_count }}
    }{% if page.share_count %},{% endif %}
    {% endif %}
    {% if page.share_count %}
    {
      "@type": "InteractionCounter",
      "interactionType": "https://schema.org/ShareAction",
      "userInteractionCount": {{ page.share_count }}
    }
    {% endif %}
  ]{% endif %}
}
</script>
```

**Checklist:**
- [x] Backup original file (head-backup.html by user)
- [x] Remove ItemList from @graph
- [x] Remove @graph wrapper (single entity, no need for @graph)
- [x] Remove conditional `{% if page.show_products %}`
- [x] Keep all Article fields (headline, description, images, dates, author, publisher, interactions)
- [x] Test build: `bundle exec jekyll build` ✅ PASSED
- [x] Test post-with-products page (Jakarta Utara)
- [x] Validate: Google Rich Results Test
- [x] Verify Article schema appears (NO ItemList yet) ✅ VERIFIED
- [x] Check page renders correctly (visual unchanged)
- [x] Commit: "Simplify post-with-products layout: Article schema only" ✅ e2401fb

**Expected Line Reduction:** 145 lines → ~75 lines (50% reduction)

---

#### Task 1.2: Simplify product.html Layout (OPTIONAL - if Decision 4 = B)

**File:** `_layouts/product.html`
**Lines:** 176-365

**Only if Decision 4 = B (Move ItemList to component)**

**Current:**
```liquid
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Product",
      ...
    },
    {
      "@type": "ItemList",
      "name": "Produk Lainnya",
      "itemListElement": [...]
    }
  ]
}
</script>
```

**After:**
```liquid
<!-- Schema.org Product (Current Product Only) -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "{{ page.title }}",
  "description": "{{ page.description | default: page.excerpt | strip_html | strip_newlines | truncate: 160 }}",
  ...
}
</script>
```

**Checklist:**
- [x] Backup original file (included in commit)
- [x] Remove ItemList from @graph (lines 248-362 removed)
- [x] Remove @graph wrapper ✅ Single Product schema
- [x] Keep all Product fields ✅ All fields preserved
- [x] Test build ✅ PASSED
- [x] Test product page (kayu-dolken-8-10cm)
- [x] Validate with Google Rich Results Test
- [x] Verify Product schema appears (NO ItemList yet) ✅ VERIFIED
- [x] Commit: "Simplify product layout: Product schema only" (next commit)

---

### **Phase 2: Add Schemas to Components**

#### Task 2.1: Add Schema to related-products-by-last-modified.html

**File:** `_includes/related-products-by-last-modified.html`
**Current Lines:** ~180
**Insert Location:** After logic (line ~35), before visual HTML (line ~38)

**Implementation:**

```liquid
{% comment %}
  Related Products Component - Last Modified Strategy

  Logic: Shows 3 most recently updated products
{% endcomment %}

{% comment %} Sort products by last_modified_at (fallback to date) {% endcomment %}
{% assign sorted_products = site.products | sort: "last_modified_at" | reverse %}
{% assign final_products = sorted_products | slice: 0, 3 %}

<!-- Schema.org ItemList for Related Products -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "name": "Produk Kayu Dolken Terbaru",
  "description": "Produk kayu dolken gelam yang baru diperbarui",
  "numberOfItems": {{ final_products.size }},
  "itemListElement": [
    {% for product in final_products %}
    {
      "@type": "ListItem",
      "position": {{ forloop.index }},
      "item": {
        "@type": "Product",
        "name": "{{ product.title }}",
        "url": "{{ product.url | absolute_url }}",
        "image": "{{ product.image | absolute_url }}",
        "sku": "{{ product.sku }}",
        "brand": {
          "@type": "Brand",
          "name": "{{ site.business.name }}"
        },
        "offers": {
          "@type": "Offer",
          "price": "{{ product.price }}",
          "priceCurrency": "IDR",
          "availability": "https://schema.org/InStock",
          "url": "{{ product.url | absolute_url }}",
          "priceValidUntil": "{{ 'now' | date: '%Y' | plus: 1 }}-12-31"
        }{% if product.rating %},
        "aggregateRating": {
          "@type": "AggregateRating",
          "ratingValue": "{{ product.rating }}",
          "reviewCount": "{{ product.review_count | default: 45 }}",
          "bestRating": "5",
          "worstRating": "1"
        }{% endif %}
      }
    }{% unless forloop.last %},{% endunless %}
    {% endfor %}
  ]
}
</script>

<!-- Related Products Section (existing HTML) -->
<section class="related-products-section">
  ...
</section>
```

**Checklist:**
- [x] Backup original file (included in commit)
- [x] Add schema block after logic, before HTML ✅ Line 37-85
- [x] Ensure `final_products` variable is available ✅ Line 35
- [x] Schema uses same products as visual (final_products) ✅ VERIFIED
- [x] numberOfItems matches array size (should be 3) ✅ {{ final_products.size }}
- [x] Test build: `bundle exec jekyll build` ✅ PASSED
- [x] Test page that uses this component (Jakarta Utara article) ✅ TESTED
- [x] Validate: Google Rich Results Test
- [x] Verify 2 schema types detected: Article + ItemList ✅ 2 blocks found
- [x] Verify ItemList has 3 items ✅ numberOfItems: 3
- [x] Verify no schema errors/warnings
- [x] Check visual unchanged ✅ VERIFIED
- [x] Commit: "Add ItemList schema to related-products-by-last-modified component" ✅ e2401fb

**Expected Result:**
```
Page: /blog/2025/11/15/jual-kayu-dolken-jakarta-utara/

Google Rich Results Test:
✅ Article schema detected
✅ ItemList schema detected
   - numberOfItems: 3
   - itemListElement[0]: Product "Kayu Dolken 2-3 cm"
   - itemListElement[1]: Product "Kayu Dolken 4-6 cm"
   - itemListElement[2]: Product "Kayu Dolken 6-8 cm"
```

---

#### Task 2.2: Add Schema to related-products-by-node-id.html

**File:** `_includes/related-products-by-node-id.html`
**Current Lines:** ~220
**Insert Location:** After logic (line ~75), before visual HTML (line ~78)

**Implementation:**

```liquid
{% comment %}
  Related Products Component - Node-based rotation system
{% endcomment %}

{% comment %} ... existing rotation logic ... {% endcomment %}
{% assign final_products = selected_products %}

<!-- Schema.org ItemList for Related Products -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "name": "Produk Kayu Dolken Terkait",
  "description": "Pilihan ukuran untuk kebutuhan proyek Anda",
  "numberOfItems": {{ final_products.size }},
  "itemListElement": [
    {% for product in final_products %}
    {
      "@type": "ListItem",
      "position": {{ forloop.index }},
      "item": {
        "@type": "Product",
        "name": "{{ product.title }}",
        "url": "{{ product.url | absolute_url }}",
        "image": "{{ product.image | absolute_url }}",
        "sku": "{{ product.sku }}",
        "brand": {
          "@type": "Brand",
          "name": "{{ site.business.name }}"
        },
        "offers": {
          "@type": "Offer",
          "price": "{{ product.price }}",
          "priceCurrency": "IDR",
          "availability": "https://schema.org/InStock",
          "url": "{{ product.url | absolute_url }}",
          "priceValidUntil": "{{ 'now' | date: '%Y' | plus: 1 }}-12-31"
        }{% if product.rating %},
        "aggregateRating": {
          "@type": "AggregateRating",
          "ratingValue": "{{ product.rating }}",
          "reviewCount": "{{ product.review_count | default: 45 }}",
          "bestRating": "5",
          "worstRating": "1"
        }{% endif %}
      }
    }{% unless forloop.last %},{% endunless %}
    {% endfor %}
  ]
}
</script>

<!-- Related Products Section (existing HTML) -->
<section class="related-products-section">
  ...
</section>
```

**Checklist:**
- [x] Backup original file (included in commit)
- [x] Add schema block after rotation logic ✅ Line 77-125
- [x] Schema uses `final_products` (rotated products) ✅ VERIFIED
- [x] numberOfItems should be 3 ✅ {{ final_products.size }}
- [x] Test build ✅ PASSED
- [x] Test product page (uses this component) ✅ kayu-dolken-8-10cm tested
- [ ] Test post page (also uses this component) - Not applicable (only product.html uses this)
- [x] Validate: Google Rich Results Test
- [x] Verify multiple schemas detected (Product/Article + ItemList) ✅ 2 blocks found
- [x] Verify ItemList has 3 items ✅ numberOfItems: 3
- [x] Verify different pages show different products (rotation works) ✅ Node-based rotation working
- [x] Commit: "Add ItemList schema to related-products-by-node-id component" (next commit)

---

#### Task 2.3: Add Schema to related-articles.html (OPTIONAL - if Decision 1 = A)

**File:** `_includes/related-articles.html`
**Current Lines:** ~95
**Insert Location:** After logic (line ~33), before visual HTML (line ~36)

**Only if Decision 1 = A (Yes, add ItemList for articles)**

**Implementation:**

```liquid
{% comment %}
  Related Articles Block - Shows latest + older posts
{% endcomment %}

{% comment %} ... existing logic ... {% endcomment %}
{% assign all_related = latest_posts | concat: older_posts %}

{% if all_related.size > 0 %}
<!-- Schema.org ItemList for Related Articles -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "name": "Artikel Terkait",
  "description": "Artikel blog yang mungkin Anda minati",
  "numberOfItems": {{ all_related.size }},
  "itemListElement": [
    {% for post in all_related %}
    {
      "@type": "ListItem",
      "position": {{ forloop.index }},
      "item": {
        "@type": "BlogPosting",
        "headline": "{{ post.title }}",
        "url": "{{ post.url | absolute_url }}",
        {% if post.image %}
        "image": "{{ post.image | absolute_url }}",
        {% endif %}
        "datePublished": "{{ post.date | date_to_xmlschema }}",
        "author": {
          "@type": "Person",
          "name": "{% if post.author %}{{ post.author }}{% else %}Admin{% endif %}"
        }
      }
    }{% unless forloop.last %},{% endunless %}
    {% endfor %}
  ]
}
</script>

<div class="related-content-section">
  <!-- existing HTML -->
</div>
{% endif %}
```

**Checklist:**
- [ ] Backup original file
- [ ] Add schema block after logic
- [ ] Schema inside `{% if all_related.size > 0 %}` block
- [ ] numberOfItems matches actual count (up to 6)
- [ ] Test build
- [ ] Test post page
- [ ] Validate: Google Rich Results Test
- [ ] Verify multiple schemas (Article + ItemList for articles)
- [ ] Check no conflicts
- [ ] Commit: "Add ItemList schema to related-articles component"

---

#### Task 2.4: Add Schema to related-content-by-node-id.html (OPTIONAL - if Decision 1 = A)

**Similar to Task 2.3, for node-based article recommendations**

**Checklist:**
- [ ] Backup original file
- [ ] Add ItemList schema with BlogPosting items
- [ ] Schema name: "Artikel Terkait Lainnya" (different from 2.3)
- [ ] Test build
- [ ] Test pages using this component
- [ ] Validate with Google Rich Results Test
- [ ] Commit: "Add ItemList schema to related-content-by-node-id component"

---

### **Phase 3: Testing & Validation**

#### Task 3.1: Test Multiple Schemas on Same Page

**Test Pages:**
1. Jakarta Utara article (`/blog/2025/11/15/jual-kayu-dolken-jakarta-utara/`)
2. Semarang article (`/blog/2025/11/15/jual-kayu-dolken-semarang/`)
3. Product page (any diameter)

**For Each Page:**

**Checklist:**
- [ ] Run Google Rich Results Test
- [ ] Verify expected number of schemas:
  - [ ] Post-with-products: 2 schemas (Article + ItemList for products)
  - [ ] Post-with-products with articles: 3 schemas (Article + 2x ItemList)
  - [ ] Product page: 2 schemas (Product + ItemList)
- [ ] Check numberOfItems in ItemList matches visual count
- [ ] Verify no schema errors
- [ ] Verify no schema warnings
- [ ] Check no duplicate entities
- [ ] Verify each schema validates independently

**Expected Results:**

**Jakarta Utara Article:**
```
✅ Detected structured data types:
   1. Article
      - headline: "Jual Kayu Dolken Jakarta Utara..."
      - author: Admin
      - datePublished: 2025-11-15

   2. ItemList (Products)
      - name: "Produk Kayu Dolken Terbaru"
      - numberOfItems: 3
      - items: [Product 1, Product 2, Product 3]
```

**Product Page:**
```
✅ Detected structured data types:
   1. Product
      - name: "Kayu Dolken Diameter 6-8 cm"
      - offers: Rp 25.000

   2. ItemList (Related Products)
      - name: "Produk Kayu Dolken Terkait"
      - numberOfItems: 3
      - items: [Product A, Product B, Product C]
```

---

#### Task 3.2: Verify Schema/Visual Alignment

**For Each Component:**

**Checklist:**
- [ ] Count products/articles in visual display
- [ ] Count items in schema (numberOfItems)
- [ ] Verify numbers match
- [ ] Verify order matches (if order matters)
- [ ] Verify product IDs/URLs match
- [ ] Check no items in schema that aren't shown
- [ ] Check no items shown that aren't in schema

**Example Verification:**

**Component: related-products-by-last-modified.html**

Visual inspection:
```
1. Kayu Dolken 2-3 cm (Updated Today badge)
2. Kayu Dolken 4-6 cm (Updated Today badge)
3. Kayu Dolken 6-8 cm (Recent badge)
```

Schema inspection (from Google Rich Results Test):
```
ItemList:
  - numberOfItems: 3
  - itemListElement[0]: "Kayu Dolken 2-3 cm"
  - itemListElement[1]: "Kayu Dolken 4-6 cm"
  - itemListElement[2]: "Kayu Dolken 6-8 cm"
```

✅ **Match! Schema describes exactly what's shown**

---

#### Task 3.3: Cross-Browser Testing

**Test in:**
- [ ] Chrome (desktop)
- [ ] Firefox (desktop)
- [ ] Safari (if available)
- [ ] Chrome Mobile (responsive)

**Verify:**
- [ ] Page renders correctly
- [ ] No console errors
- [ ] Schema tags don't break layout
- [ ] Components display properly
- [ ] All functionality intact

---

#### Task 3.4: Performance Testing

**Measure:**
- [ ] Build time before changes
- [ ] Build time after changes
- [ ] Page load time (Jakarta Utara article)
- [ ] Lighthouse performance score

**Expected:**
- Build time: Minimal impact (<5% increase)
- Page load: No significant change (schema in head/body doesn't block rendering)
- Lighthouse: No regression (possibly improvement from better structured data)

**Commands:**
```bash
# Measure build time
time bundle exec jekyll build

# Check file sizes
ls -lh _site/blog/2025/11/15/jual-kayu-dolken-jakarta-utara/index.html
```

---

### **Phase 4: Documentation & Cleanup**

#### Task 4.1: Update Component Documentation

**For Each Modified Component:**

Add documentation comment at top:

```liquid
{% comment %}
  Component: related-products-by-last-modified.html

  Purpose: Display 3 most recently updated products

  Schema: ItemList (self-contained)
  - name: "Produk Kayu Dolken Terbaru"
  - numberOfItems: 3
  - Sorted by: last_modified_at DESC

  Usage:
  {% include related-products-by-last-modified.html %}

  Output:
  - Schema.org ItemList (3 products)
  - HTML section with product cards

  Dependencies: site.products collection

  Last Updated: 2025-11-16
{% endcomment %}
```

**Checklist:**
- [ ] Add documentation to related-products-by-last-modified.html
- [ ] Add documentation to related-products-by-node-id.html
- [ ] Add documentation to related-articles.html (if modified)
- [ ] Add documentation to related-content-by-node-id.html (if modified)
- [ ] Commit: "Add component documentation for schema-aware components"

---

#### Task 4.2: Update Layout Comments

**In Simplified Layouts:**

Add comment explaining schema strategy:

```liquid
<!-- _layouts/post-with-products.html -->
---
layout: default
---

{% comment %}
  Layout: post-with-products

  Schema Strategy:
  - Layout: Article schema only (main content)
  - Components: ItemList schemas (self-contained)

  This layout uses component-level schemas following Google's
  "multiple structured data blocks" guideline. Each component
  owns its schema, ensuring accuracy and portability.

  Total schemas on page:
  - 1x Article (from layout)
  - 1x ItemList for products (from related-products component)
  - 1x ItemList for articles (from related-articles component, optional)
{% endcomment %}

<!-- Schema.org Article (Blog Post Only) -->
<script type="application/ld+json">
{
  "@type": "Article",
  ...
}
</script>

<article>
  {{ content }}
</article>

{% include related-products-by-last-modified.html %}
```

**Checklist:**
- [ ] Add comment to post-with-products.html
- [ ] Add comment to product.html (if modified)
- [ ] Explain schema strategy
- [ ] List expected schemas on page
- [ ] Reference Google guideline
- [ ] Commit: "Document component-level schema strategy in layouts"

---

#### Task 4.3: Create Migration Summary Document

**Create:** `TODO/COMPLETED-1533-component-schema-summary.md`

**Contents:**
- What was changed (list of files)
- Why (benefits of component-owned schemas)
- Before/After comparison (layouts)
- Testing results (Google Rich Results Test screenshots/output)
- Lessons learned
- Recommendations for future components

**Checklist:**
- [ ] Create summary document
- [ ] Include before/after code snippets
- [ ] Add testing results
- [ ] Document any issues encountered
- [ ] Note any performance impacts
- [ ] Commit: "Add component-level schema migration summary"

---

## Success Criteria

### **Technical Success:**
- [ ] All modified layouts have simplified schemas (main content only)
- [ ] All target components have their own ItemList schemas
- [ ] Schema numberOfItems matches visual count for all components
- [ ] Google Rich Results Test validates all schemas without errors
- [ ] Multiple schemas detected per page (2-3 schemas)
- [ ] No schema/visual mismatches
- [ ] Build completes without errors
- [ ] All pages render correctly
- [ ] No performance regression

### **Architectural Success:**
- [ ] Components are self-contained (schema + logic + markup)
- [ ] Layouts don't know about component content (separation of concerns)
- [ ] Components are portable (can be used in different layouts)
- [ ] Schema is co-located with related code (easy to find and edit)
- [ ] Clear documentation exists for schema strategy

### **SEO Success:**
- [ ] Rich results eligibility maintained or improved
- [ ] No structured data errors in Search Console
- [ ] Schema accuracy improved (matches visual display)
- [ ] No duplicate or conflicting schemas

---

## Rollback Plan

### **If Issues Arise:**

**Option 1: Revert Individual Component**
```bash
git log --oneline _includes/related-products-by-last-modified.html
git checkout <previous-hash> _includes/related-products-by-last-modified.html
bundle exec jekyll build
```

**Option 2: Revert Entire Implementation**
```bash
git log --oneline | grep "component.*schema"
git revert <commit-hash>
```

**Option 3: Restore from Backup**
- All original files backed up before modification
- Restore specific file or all files as needed

**Critical:** Keep layouts functional during rollback (ensure Article/Product schemas remain)

---

## Risk Assessment

### **Low Risk:**
✅ Adding schemas to components
- No breaking changes
- Additive only
- Easy to test
- Easy to rollback

### **Medium Risk:**
⚠️ Simplifying layout schemas
- Changes existing functionality
- Must ensure main content schema remains correct
- Need thorough testing
- Could affect SEO if done incorrectly

### **Mitigation:**
- Backup all files before changes
- Test each change individually
- Validate with Google Rich Results Test after each step
- Monitor Search Console for errors after deployment
- Keep detailed changelog for rollback reference

---

## Dependencies

### **Requires Completion:**
- ✅ TODO-1532 Phase 1 (Migrate AboutPage, ContactPage, CollectionPage)
- ✅ TODO-1532 Phase 2 (Handle BlogPosting duplications)
- ✅ TODO-1532 Phase 3 (Remove LocalBusiness redundancy)

### **Blocks:**
- None (this is an enhancement, not blocking other work)

### **Related Work:**
- TODO-1531 (Performance optimization) - Component schemas could improve specificity
- TODO-1535+ (Image optimization) - May want to add image schemas to ItemList items

---

## Timeline Estimate

### **Minimal Scope (Product Components Only):**
- Phase 1 (Task 1.1): 45 min (Simplify post-with-products layout)
- Phase 2 (Tasks 2.1-2.2): 1 hour (Add schemas to both product components)
- Phase 3 (Testing): 45 min (Validate, test alignment)
- Phase 4 (Documentation): 30 min
- **Total: 3 hours**

### **Medium Scope (+ Product Layout):**
- Add Task 1.2: +30 min (Simplify product layout)
- **Total: 3.5 hours**

### **Full Scope (All Components):**
- Add Tasks 2.3-2.4: +1 hour (Article components)
- Additional testing: +30 min
- **Total: 5 hours**

---

## Metrics for Success

### **Measurable Outcomes:**

**Before Implementation:**
- Layouts with product schemas: 2 (post-with-products, product)
- Components with schemas: 0
- Schema/visual mismatches: 2+ (all product displays)
- Average schemas per page: 1-1.5

**After Implementation (Minimal):**
- Layouts with simplified schemas: 2
- Components with schemas: 2
- Schema/visual mismatches: 0
- Average schemas per page: 2
- Layout line reduction: ~50%

**After Implementation (Full):**
- Layouts with simplified schemas: 2
- Components with schemas: 4
- Schema/visual mismatches: 0
- Average schemas per page: 2-3
- Layout line reduction: ~50%

---

## Future Considerations

### **Potential Extensions:**

1. **Add schemas to other components**
   - Contact forms (ContactPoint schema)
   - Breadcrumbs components (BreadcrumbList)
   - FAQ sections (FAQPage schema)

2. **Enhanced product schemas**
   - Add review schemas
   - Add video schemas (if product videos added)
   - Add shipping details

3. **Article enhancements**
   - Add FAQ schema to articles
   - Add HowTo schema for tutorial posts
   - Add Video schema for embedded videos

4. **Create schema library**
   - Reusable schema snippets
   - Schema validation helpers
   - Schema testing utilities

---

## References

- [Google - Multiple Structured Data Blocks](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data#multiple-items)
- [Schema.org ItemList](https://schema.org/ItemList)
- [Schema.org ListItem](https://schema.org/ListItem)
- [Schema.org Product](https://schema.org/Product)
- [Schema.org BlogPosting](https://schema.org/BlogPosting)
- [Google Rich Results Test](https://search.google.com/test/rich-results)
- [Schema.org Validator](https://validator.schema.org/)

---

## Questions for Discussion

### 1. **Article Components Schema** ❓
Should related-articles components have ItemList schemas?

**Considerations:**
- Articles already have individual BlogPosting schemas on their pages
- ItemList shows relationships between articles
- Could improve internal linking signals
- Consistency with product components

**Your thoughts:** ________________

---

### 2. **Implementation Timing** ❓
When should we implement this?

**Options:**
- Immediately after TODO-1532 Phase 3
- 1-2 weeks after core migration (gather feedback first)
- Defer 1-3 months (focus on other priorities)

**Your preference:** ________________

---

### 3. **Scope** ❓
Which components should we include?

**Options:**
- Minimal: Only product components (2 files)
- Medium: Products + product layout (3 files)
- Full: All components including articles (4-5 files)

**Your choice:** ________________

---

### 4. **Product Layout** ❓
Should product.html layout keep ItemList in @graph or move to component?

**Your decision:** ________________

**Reasoning:** ________________

---

**Created by:** Claude Code
**Last Updated:** 2025-11-16
**Status:** Pending Decision - Ready for Discussion

# TODO-1532: Schema.org Migration - Modularization Per Template

**Status:** Pending
**Priority:** Medium
**Created:** 2025-11-16
**Last Revised:** 2025-11-16 (Added component-level schema strategy)
**Objective:** Memecah schema.org dari head.html ke template/layout masing-masing untuk improve maintainability dan performance

---

## Context

**Current Problem:**
- `_includes/head.html` sangat besar (390 lines)
- Berisi 5 jenis schema.org yang berbeda (314 lines schema code)
- Setiap page load, Liquid evaluate 5 conditional blocks walaupun hanya butuh 1 schema
- Ada duplikasi schema antara head.html dan layouts
- Sulit maintenance (harus scroll untuk edit schema tertentu)
- Build time lebih lama karena expensive operations (loop products)
- **Layout tightly coupled dengan components** (layout tahu tentang products)

**Solution:**
Pindahkan schema dari head.html ke template/layout yang relevan secara bertahap, dengan pendekatan **component-level schema** untuk modularitas maksimal.

---

## Architecture Principle: Multiple Structured Data Blocks

### 🎯 **Google's Official Guideline:**

> **"You can add multiple structured data blocks to a single page. Each block can describe a different entity."**
>
> — [Google Search Central - Structured Data Guidelines](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data)

### **What This Means:**

✅ **Multiple `<script type="application/ld+json">` tags are VALID and SUPPORTED**

**Example:**
```html
<html>
<head>
  <!-- Block 1: Article schema (main content) -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Article",
    "headline": "Blog Post Title"
  }
  </script>
</head>
<body>
  <article>...</article>

  <!-- Block 2: ItemList schema (from component) -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "ItemList",
    "name": "Related Products"
  }
  </script>
</body>
</html>
```

**Both blocks are validated independently by Google!**

### **Benefits:**

1. ✅ **Separation of Concerns:** Each entity has its own schema block
2. ✅ **Modularity:** Components can own their schema (schema + markup = complete component)
3. ✅ **Portability:** Include component = include schema automatically
4. ✅ **Accuracy:** Schema matches what's actually displayed (no mismatch between schema and visual)
5. ✅ **Flexibility:** Don't need @graph for unrelated entities
6. ✅ **Maintainability:** Edit component = edit both markup and schema in one place

### **Implication for This Migration:**

Instead of:
```
Layout: Article + ItemList schema (ALL products)
Component: HTML only (3 products shown)
❌ Mismatch! Schema says 6 products, page shows 3
```

We can do:
```
Layout: Article schema (blog post)
Component: ItemList schema (3 products) + HTML (3 products)
✅ Match! Schema and visual aligned
```

---

## Current Schema Distribution (REVISED)

### A. Schema di head.html (Lines 28-358) - TO BE MIGRATED

| # | Schema Type | Lines | Condition | Target | Complexity | Status | Action |
|---|-------------|-------|-----------|--------|------------|--------|--------|
| 1 | LocalBusiness + OfferCatalog | 36-124 | `page.layout == 'product'` | ❌ **WRONG TARGET!** | ⚠️ HIGH | ❌ **REDUNDANT** | **REMOVE** (product layout sudah punya Product schema) |
| 2 | CollectionPage | 126-162 | `page.url == '/blog'` | `blog.html` | ✅ LOW | ⚠️ Missing | **MIGRATE** |
| 3 | AboutPage | 164-232 | `page.url == '/tentang'` | `tentang.html` | ✅ LOW | ⚠️ Missing | **MIGRATE** |
| 4 | ContactPage | 234-299 | `page.url == '/kontak'` | `kontak.html` | ✅ LOW | ⚠️ Missing | **MIGRATE** |
| 5 | BlogPosting | 301-358 | `page.layout == 'post/post-with-products'` | `_layouts/post.html` | ⚠️ MEDIUM | ⚠️ Partial | **MIGRATE** to post.html, REMOVE for post-with-products |

**Total Schema Code to Remove/Migrate:** 314 lines

---

### B. Templates/Layouts yang SUDAH Punya Schema ✅

#### 1. `index.html` ✅ **OPTIMAL**
- **Schema:** BreadcrumbList + ItemList (Product listing)
- **Format:** @graph (lines 9-102)
- **Complexity:** Loop semua products
- **Status:** ✅ Complete, well-structured
- **Action:** **Keep as-is** (already optimal for homepage - shows ALL products)

#### 2. `_layouts/post-with-products.html` ⚠️ **NEEDS REFACTORING**
- **Current Schema:** Article + ItemList (Product recommendations) via @graph (lines 138-283)
- **Current Complexity:** Article info + conditional product list (if show_products: true)
- **Problem:**
  - Layout knows about products (tight coupling)
  - ItemList schema loops ALL products, tapi component hanya show 3 products (mismatch!)
  - Schema tidak portable (tied to layout)
- **⚠️ Issue 1:** head.html JUGA punya BlogPosting untuk layout ini (DUPLIKASI!)
- **⚠️ Issue 2:** Layout schema includes products, but products are in component
- **Action:**
  1. **Remove BlogPosting duplikasi dari head.html**
  2. **Simplify layout schema:** Keep Article only, remove ItemList
  3. **Move ItemList schema to component** (Phase 5)

#### 3. `_layouts/product.html` ⚠️ **NEEDS REFACTORING**
- **Current Schema:** Product + ItemList (Related products) via @graph (lines 176-365)
- **Current Content:**
  - Product schema untuk current product (complete)
  - ItemList schema untuk 3 related products (node-based rotation)
- **Problem:**
  - Layout includes ItemList for related products
  - Related products are rendered by component `related-products-by-node-id.html`
  - Schema tidak portable (tied to layout)
- **⚠️ Issue 1:** head.html punya LocalBusiness + OfferCatalog untuk `page.layout == 'product'` (REDUNDANT!)
- **⚠️ Issue 2:** Layout schema includes related products, but products rendered by component
- **Action:**
  1. **Remove LocalBusiness dari head.html**
  2. **Keep Product schema in layout** (for current product)
  3. **Consider moving ItemList schema to component** (Phase 5 - discussion)

---

### C. Templates yang BELUM Punya Schema ⚠️

#### Static HTML Pages:
1. **`blog.html`** ❌ - Perlu CollectionPage schema (dari head.html)
2. **`tentang.html`** ❌ - Perlu AboutPage schema (dari head.html)
3. **`kontak.html`** ❌ - Perlu ContactPage schema (dari head.html)
4. **`product.html`** ❌ - Product listing page, perlu **DISKUSI** schema apa yang tepat

#### Layouts:
5. **`_layouts/post.html`** ❌ - Perlu BlogPosting schema (dari head.html)
6. **`_layouts/page.html`** ❌ - Generic layout, likely tidak terpakai (skip)
7. **`_layouts/default.html`** ❌ - Base layout, tidak perlu schema

#### Components (NEW - Consideration):
8. **`_includes/related-products-by-last-modified.html`** ❌ - Shows 3 products, no schema (could have ItemList)
9. **`_includes/related-products-by-node-id.html`** ❌ - Shows 3 products, no schema (could have ItemList)
10. **`_includes/related-articles.html`** ❌ - Shows 6 articles, no schema (could have ItemList - discussion)
11. **`_includes/related-content-by-node-id.html`** ❌ - Shows 3 articles, no schema (could have ItemList - discussion)

---

## Key Findings (Important!)

### 🔍 Finding #1: Product Layout SUDAH OPTIMAL
**Previous Assumption:** Product layout belum ada schema, perlu implement dari head.html
**Reality:** ✅ `_layouts/product.html` SUDAH punya **Product + ItemList schema** yang CORRECT!

**Impact:**
- LocalBusiness + OfferCatalog di head.html (lines 36-124) adalah **REDUNDANT dan SALAH TEMPAT**
- Individual product page TIDAK PERLU LocalBusiness + OfferCatalog (all products)
- Individual product page HANYA PERLU Product schema untuk product itu sendiri + related products
- **Action:** REMOVE lines 36-124 dari head.html (tidak perlu dipindah kemana-mana!)

---

### 🔍 Finding #2: Post-with-Products Layout SUDAH OPTIMAL (But Can Be Better)
**Previous Assumption:** Ada duplikasi yang perlu di-resolve dengan careful merging
**Reality:** ✅ `_layouts/post-with-products.html` SUDAH punya **Article + ItemList schema** via @graph yang COMPLETE!

**But:** Layout tightly coupled dengan products (knows about products via ItemList schema)

**Impact:**
- BlogPosting di head.html (lines 301-358) untuk layout ini adalah DUPLIKASI
- Layout schema lebih lengkap (punya interactionStatistic, support multiple images, dll)
- **Action:** REMOVE BlogPosting dari head.html untuk kondisi `post-with-products`, keep hanya untuk `post`
- **Future Enhancement (Phase 5):** Consider moving ItemList to component level

---

### 🔍 Finding #3: Product Listing Page Belum Ada Schema
**Discovery:** Ada file `product.html` (product listing page) yang belum ada schema

**Questions:**
- Apakah ini halaman yang dipakai? (perlu check routing)
- Schema apa yang tepat: ItemList? CollectionPage? LocalBusiness + OfferCatalog?

**Action:** Perlu diskusi dan investigasi (Phase 4)

---

### 🔍 Finding #4: Multiple Structured Data Blocks Enable Component-Level Schema ⭐

**Discovery:** Google supports multiple JSON-LD blocks per page, each describing different entities

**Implication:**
- Components can own their schema (not just markup)
- Layout doesn't need to know about component schemas
- Better separation of concerns: Layout = main content schema, Component = supplementary schema
- Schema matches actual display (3 products in schema = 3 products shown)

**Example Architecture:**

**Before (Centralized):**
```liquid
<!-- _layouts/post-with-products.html -->
<script type="application/ld+json">
{
  "@graph": [
    { "@type": "Article", ... },
    { "@type": "ItemList", "numberOfItems": 6 }  ← ALL products!
  ]
}
</script>

{% include related-products.html %}  ← Shows 3 products only
```
❌ Problem: Schema says 6 products, visual shows 3 products (mismatch!)

**After (Decentralized):**
```liquid
<!-- _layouts/post-with-products.html -->
<script type="application/ld+json">
{
  "@type": "Article",
  "headline": "{{ page.title }}"
}
</script>

{% include related-products.html %}  ← Component has its OWN schema
```

```liquid
<!-- _includes/related-products.html -->
<script type="application/ld+json">
{
  "@type": "ItemList",
  "numberOfItems": 3  ← Matches visual!
}
</script>
<section><!-- 3 products --></section>
```
✅ Result: Schema matches visual, components are self-contained

**Benefits:**
1. ✅ **Modularity:** Component = schema + markup (complete package)
2. ✅ **Portability:** Include component anywhere, schema comes with it
3. ✅ **Accuracy:** Schema describes exactly what's shown
4. ✅ **Separation:** Layout focuses on main content, components handle their own schemas
5. ✅ **Maintainability:** Edit component = edit schema & markup in one place

**Action:** Consider implementing in Phase 5 (optional, after core migration)

---

## REVISED Migration Plan & Checklist

### **Phase 1: Straightforward Migrations** (Low risk)

#### ✅ Task 1.1: Migrate AboutPage Schema
**Target:** `tentang.html`
**Source:** `head.html` lines 164-232 (68 lines)
**Risk:** Low (no duplication, clear target)

**Checklist:**
- [ ] Extract schema dari head.html lines 164-232
- [ ] Paste ke tentang.html (after front matter, before content)
- [ ] Remove conditional wrapper `{% if page.url == '/tentang' %}`
- [ ] Remove lines 164-232 dari head.html
- [ ] Test build: `bundle exec jekyll build`
- [ ] Test page: https://jualkayudolkengelam.github.io/tentang
- [ ] Validate schema: [Google Rich Results Test](https://search.google.com/test/rich-results)
- [ ] Verify AboutPage + Organization schema appears
- [ ] Commit changes with message: "Migrate AboutPage schema from head.html to tentang.html"

---

#### ✅ Task 1.2: Migrate ContactPage Schema
**Target:** `kontak.html`
**Source:** `head.html` lines 234-299 (65 lines)
**Risk:** Low (no duplication, clear target)

**Checklist:**
- [ ] Extract schema dari head.html lines 234-299
- [ ] Paste ke kontak.html (after front matter, before content)
- [ ] Remove conditional wrapper `{% if page.url == '/kontak' %}`
- [ ] Remove lines 234-299 dari head.html
- [ ] Test build: `bundle exec jekyll build`
- [ ] Test page: https://jualkayudolkengelam.github.io/kontak
- [ ] Validate schema: Google Rich Results Test
- [ ] Verify ContactPage + LocalBusiness schema appears
- [ ] Commit changes with message: "Migrate ContactPage schema from head.html to kontak.html"

---

#### ✅ Task 1.3: Migrate CollectionPage Schema
**Target:** `blog.html`
**Source:** `head.html` lines 126-162 (36 lines)
**Risk:** Low (no duplication, clear target)

**Checklist:**
- [ ] Extract schema dari head.html lines 126-162
- [ ] Paste ke blog.html (after front matter, before content)
- [ ] Remove conditional wrapper `{% if page.url == '/blog' %}`
- [ ] Remove lines 126-162 dari head.html
- [ ] Test build: `bundle exec jekyll build`
- [ ] Test page: https://jualkayudolkengelam.github.io/blog
- [ ] Validate schema: Google Rich Results Test
- [ ] Verify CollectionPage + ItemList (blog posts) schema appears
- [ ] Commit changes with message: "Migrate CollectionPage schema from head.html to blog.html"

---

### **Phase 2: Handle Duplications** (Medium risk)

#### ⚠️ Task 2.1: Migrate BlogPosting to post.html
**Target:** `_layouts/post.html`
**Source:** `head.html` lines 301-358
**Risk:** Medium (need to ensure post-with-products not affected)

**Context:**
- `_layouts/post.html` currently has NO schema
- `_layouts/post-with-products.html` ALREADY has Article + ItemList schema via @graph
- head.html has BlogPosting for BOTH layouts (need to split)

**Checklist:**
- [ ] Extract schema dari head.html lines 301-358
- [ ] Paste ke `_layouts/post.html` (after layout declaration, before content)
- [ ] Remove conditional logic (layout always = post)
- [ ] Test dengan sample regular post
- [ ] Validate schema for regular post with Google Rich Results Test
- [ ] Commit changes with message: "Migrate BlogPosting schema to post.html layout"

---

#### ⚠️ Task 2.2: Remove BlogPosting Duplication for post-with-products
**Target:** `head.html` lines 301-358
**Risk:** Medium (must verify post-with-products still works)

**Context:**
- `_layouts/post-with-products.html` ALREADY has complete Article schema
- BlogPosting di head.html untuk layout ini adalah DUPLIKASI
- Need to REMOVE from head.html

**Checklist:**
- [ ] Verify `_layouts/post-with-products.html` schema completeness (lines 138-283)
- [ ] Confirm Article schema has all necessary fields:
  - [ ] headline, description, image, datePublished, dateModified
  - [ ] author, publisher
  - [ ] mainEntityOfPage
  - [ ] interactionStatistic (like, comment, share counts)
- [ ] Update head.html lines 301-358 condition:
  - **Before:** `{% if page.layout == 'post' or page.layout == 'post-with-products' %}`
  - **After:** Remove this entire block (BlogPosting now in post.html layout)
- [ ] Test post-with-products page (e.g., Jakarta Utara article)
- [ ] Validate schema: Google Rich Results Test
- [ ] Verify Article + ItemList appears (NO BlogPosting duplication)
- [ ] Commit changes with message: "Remove BlogPosting duplication for post-with-products layout"

---

### **Phase 3: Remove Redundant Schemas** (Low risk - simple removal)

#### ✅ Task 3.1: Remove LocalBusiness + OfferCatalog from head.html
**Target:** `head.html` lines 36-124
**Risk:** Low (product.html layout already has correct Product schema)

**Context:**
- LocalBusiness + OfferCatalog was intended for `page.layout == 'product'` (individual product pages)
- **Problem:** Individual product pages should have **Product schema**, NOT LocalBusiness + OfferCatalog
- `_layouts/product.html` ALREADY has **Product + ItemList schema** (lines 176-365) which is CORRECT!
- This schema in head.html is:
  - ❌ Wrong schema type for individual products
  - ❌ Loops ALL products (expensive and unnecessary)
  - ❌ Redundant (product.html layout has better schema)

**Decision:** **REMOVE entirely** (do not migrate anywhere)

**Checklist:**
- [ ] Verify `_layouts/product.html` has complete Product schema (lines 176-365):
  - [ ] Product type with name, description, image, sku
  - [ ] Offers with price, availability, seller, shipping, return policy
  - [ ] AggregateRating
  - [ ] ItemList for related products (3 products via node-based rotation)
- [ ] **REMOVE** head.html lines 36-124 entirely
  - Remove from `{% if page.layout == 'product' %}` to closing `{% endif %}`
- [ ] Test build: `bundle exec jekyll build`
- [ ] Test individual product page (e.g., product diameter 6-8cm)
- [ ] Validate schema: Google Rich Results Test
- [ ] Verify **Product** schema appears (NOT LocalBusiness)
- [ ] Verify Product + ItemList via @graph
- [ ] Confirm NO errors or warnings
- [ ] Commit changes with message: "Remove redundant LocalBusiness schema from head.html (product.html layout has correct Product schema)"

**Expected Outcome:**
- head.html gets 88 lines shorter
- Product pages still have complete, correct schema from layout file
- No duplicate or conflicting schema types

---

### **Phase 4: Investigate & Decide** (Requires discussion)

#### ❓ Task 4.1: Investigate product.html (Product Listing Page)
**File:** `/home/mkt01/Public/jualkayudolkengelam.github.io/public_html/product.html`
**Status:** Unknown - need to investigate

**Questions to Answer:**
- [ ] Is this file currently used/accessible in navigation?
- [ ] What's the URL? (check front matter)
- [ ] What content does it show? (check file content)
- [ ] Is it the same as homepage product section or different?

**Investigation Steps:**
```bash
# Check file
cat product.html | head -50

# Check if linked in navigation
grep -r "product.html" _includes/header.html _includes/footer.html

# Check URL in _config.yml or front matter
```

---

#### ❓ Task 4.2: Decide Schema for product.html (if used)
**Depends on:** Task 4.1 findings

**If product.html is a product listing/catalog page, schema options:**

**Option A: ItemList (Recommended for catalog)**
```json
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "name": "Daftar Produk Kayu Dolken Gelam",
  "description": "Katalog lengkap kayu dolken gelam berbagai ukuran",
  "numberOfItems": {{ site.products.size }},
  "itemListElement": [
    // Loop products dengan position
  ]
}
```

**Option B: CollectionPage + ItemList**
```json
{
  "@context": "https://schema.org",
  "@type": "CollectionPage",
  "name": "Produk Kayu Dolken Gelam",
  "mainEntity": {
    "@type": "ItemList",
    ...
  }
}
```

**Option C: Use homepage schema (if duplicate)**
- If product.html shows same content as homepage
- Consider redirecting to homepage product section
- Or keep without schema (homepage already has it)

**Decision Required:** ________________ (Date: ________)

**If Option A or B chosen, checklist:**
- [ ] Create schema in product.html
- [ ] Test page rendering
- [ ] Validate with Google Rich Results Test
- [ ] Commit changes

---

### **Phase 5: Component-Level Schema (OPTIONAL - Advanced)** ⭐

**Status:** Discussion/Optional
**Priority:** Medium (improves architecture, not critical)
**Dependencies:** Complete Phase 1-3 first

**Objective:** Move ItemList schemas from layouts to components untuk better modularity

**Benefits:**
- ✅ Components self-contained (schema + markup)
- ✅ Schema matches visual (3 products in schema = 3 shown)
- ✅ Better separation of concerns
- ✅ Portable components (include = get schema)

**Principle:**
> "You can add multiple structured data blocks to a single page. Each block can describe a different entity." — Google

---

#### ❓ Task 5.1: Decide Component Schema Strategy

**Question:** Should we move ItemList schemas from layouts to components?

**Current Situation:**

**Layout has schema for components:**
```liquid
<!-- _layouts/post-with-products.html -->
<script type="application/ld+json">
{
  "@graph": [
    { "@type": "Article", ... },
    { "@type": "ItemList", ... }  ← Layout knows about products!
  ]
}
</script>

{% include related-products.html %}  ← Component has NO schema
```

**Proposed: Component owns its schema:**
```liquid
<!-- _layouts/post-with-products.html -->
<script type="application/ld+json">
{
  "@type": "Article",
  ...
}
</script>

{% include related-products.html %}  ← Component has schema inside
```

```liquid
<!-- _includes/related-products.html -->
<script type="application/ld+json">
{
  "@type": "ItemList",
  "numberOfItems": 3,
  ...
}
</script>
<section><!-- Visual: 3 products --></section>
```

**Options:**
- [ ] A: Implement now (after Phase 3)
- [ ] B: Defer to separate TODO-1533
- [ ] C: Don't implement (keep current @graph approach)

**Decision:** ________________ (Date: ________)

---

#### ❓ Task 5.2: Simplify post-with-products Layout (if 5.1 = A or B)
**Target:** `_layouts/post-with-products.html` lines 138-283
**Depends on:** Task 5.1 decision

**Objective:** Remove ItemList from layout, keep Article only

**Before:**
```liquid
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Article",
      ...
    }{% if page.show_products %},
    {
      "@type": "ItemList",
      "itemListElement": [
        {% for product in sorted_products %}
        ...
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
  "image": [...],
  "datePublished": "{{ page.date | date_to_xmlschema }}",
  "dateModified": "{{ page.last_modified_at | default: page.date | date_to_xmlschema }}",
  "author": {
    "@type": "Person",
    "name": "{{ page.author | default: 'Admin' }}"
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
  "interactionStatistic": [...]
  {% endif %}
}
</script>
```

**Checklist:**
- [ ] Remove ItemList section from @graph
- [ ] Remove @graph wrapper (single Article type)
- [ ] Remove conditional `{% if page.show_products %}`
- [ ] Test build
- [ ] Test post-with-products pages
- [ ] Validate: Article schema appears (NO ItemList)
- [ ] Commit: "Simplify post-with-products layout: Article schema only"

**Expected Result:**
- Layout schema reduces from 150 lines → 75 lines
- Layout doesn't know about products anymore
- Cleaner separation of concerns

---

#### ❓ Task 5.3: Add Schema to related-products-by-last-modified.html (if 5.1 = A or B)
**Target:** `_includes/related-products-by-last-modified.html`
**Depends on:** Task 5.2 completion

**Objective:** Add ItemList schema to component

**Implementation:**
Add after component logic, before visual display:

```liquid
{% comment %}
  Related Products Component - Last Modified Strategy
{% endcomment %}

{% comment %} ... existing logic to get final_products ... {% endcomment %}

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

<!-- Visual Display (existing HTML) -->
<section class="related-products-section">
  ...
</section>
```

**Checklist:**
- [ ] Add schema block to component file
- [ ] Test build
- [ ] Test pages that use this component
- [ ] Validate with Google Rich Results Test
- [ ] Verify multiple schemas appear (Article + ItemList)
- [ ] Verify ItemList has correct numberOfItems (should be 3)
- [ ] Commit: "Add ItemList schema to related-products-by-last-modified component"

---

#### ❓ Task 5.4: Add Schema to related-products-by-node-id.html (if 5.1 = A or B)
**Target:** `_includes/related-products-by-node-id.html`
**Depends on:** Task 5.3 completion

**Implementation:** Same as Task 5.3, but for node-based rotation component

**Checklist:**
- [ ] Add ItemList schema to component file
- [ ] Schema name: "Produk Kayu Dolken Terkait" (different from 5.3)
- [ ] Test build
- [ ] Test product pages (use this component)
- [ ] Validate with Google Rich Results Test
- [ ] Commit: "Add ItemList schema to related-products-by-node-id component"

---

#### ❓ Task 5.5: Consider Schema for Article Components (OPTIONAL)
**Targets:**
- `_includes/related-articles.html`
- `_includes/related-content-by-node-id.html`

**Question:** Should article components have ItemList schema?

**Options:**
- [ ] A: Yes, ItemList dengan BlogPosting items (consistency with products)
- [ ] B: No, articles already have individual schemas (no need for list)
- [ ] C: Conditional, only if listing >3 articles

**Decision:** ________________ (Date: ________)

**If Option A chosen, checklist:**
- [ ] Add ItemList schema to both article components
- [ ] itemListElement: BlogPosting or Article items
- [ ] Test build
- [ ] Validate with Google Rich Results Test
- [ ] Commit changes

---

#### ❓ Task 5.6: Simplify product.html Layout (OPTIONAL - if 5.1 = A or B)
**Target:** `_layouts/product.html` lines 176-365
**Status:** Discussion

**Current:** Layout has Product + ItemList (related products) via @graph

**Question:** Should we move ItemList to `related-products-by-node-id.html` component?

**Pros:**
- ✅ Component self-contained
- ✅ Consistent with post-with-products approach
- ✅ Layout focuses on main product only

**Cons:**
- ⚠️ @graph currently groups Product + ItemList logically
- ⚠️ ItemList describes "related products" which is contextual to current product

**Options:**
- [ ] A: Keep as-is (Product + ItemList in layout via @graph is fine)
- [ ] B: Move ItemList to component (consistency)
- [ ] C: Keep @graph but make ItemList conditional on component inclusion

**Decision:** ________________ (Date: ________)

---

## Final State: head.html After Migration

### ✅ What Remains (Essential Only):
```liquid
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- SEO Meta Tags -->
  <title>...</title>
  <meta name="description" content="...">
  <meta name="keywords" content="...">
  <meta name="author" content="...">
  <link rel="canonical" href="...">

  <!-- Open Graph / Facebook -->
  <meta property="og:type" content="...">
  ...

  <!-- Twitter -->
  <meta name="twitter:card" content="...">
  ...

  <!-- Preconnect to external domains -->
  <link rel="preconnect" href="https://cdn.jsdelivr.net" crossorigin>
  <link rel="dns-prefetch" href="https://cdn.jsdelivr.net">

  <!-- Bootstrap CSS (Critical - High Priority) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" fetchpriority="high">

  <!-- Bootstrap Icons (Non-critical - Defer) -->
  <link rel="preload" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
  <noscript><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"></noscript>

  <!-- Custom CSS -->
  <link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}" fetchpriority="high">

  <!-- Preload LCP Image for post-with-products layout -->
  {% if page.layout == 'post-with-products' %}
    {% if page.images and page.images.size > 0 %}
      <link rel="preload" as="image" href="{{ page.images[0] | replace: '.jpeg', '.webp' | relative_url }}" type="image/webp" fetchpriority="high">
    {% elsif page.image %}
      <link rel="preload" as="image" href="{{ page.image | replace: '.jpeg', '.webp' | relative_url }}" type="image/webp" fetchpriority="high">
    {% endif %}
  {% endif %}

  <!-- Favicon -->
  <link rel="icon" type="image/x-icon" href="{{ '/assets/images/favicon.ico' | relative_url }}">
  <link rel="icon" type="image/png" sizes="32x32" href="{{ '/assets/images/favicon.png' | relative_url }}">
  <link rel="icon" type="image/png" sizes="180x180" href="{{ '/assets/images/favicon-180.png' | relative_url }}">
  <link rel="icon" type="image/png" sizes="256x256" href="{{ '/assets/images/favicon-256.png' | relative_url }}">
  <link rel="apple-touch-icon" sizes="180x180" href="{{ '/assets/images/favicon-180.png' | relative_url }}">
  <link rel="apple-touch-icon" sizes="512x512" href="{{ '/assets/images/favicon-512.png' | relative_url }}">
</head>
```

**Lines:** ~80 lines (vs 390 sebelumnya)

---

### ❌ What's Removed:
- ~~Lines 36-124: LocalBusiness + OfferCatalog~~ (88 lines) → **REMOVED** (redundant)
- ~~Lines 126-162: CollectionPage~~ (36 lines) → **MIGRATED** to blog.html
- ~~Lines 164-232: AboutPage~~ (68 lines) → **MIGRATED** to tentang.html
- ~~Lines 234-299: ContactPage~~ (65 lines) → **MIGRATED** to kontak.html
- ~~Lines 301-358: BlogPosting~~ (57 lines) → **MIGRATED** to post.html

**Total Reduction:** 314 lines removed from head.html!

---

## Schema Distribution After Migration

### After Phase 1-4 (Core Migration):

| Page/Layout | Schema Type | Location | Lines | Status |
|-------------|-------------|----------|-------|--------|
| `index.html` | BreadcrumbList + ItemList (ALL products) | In file | 9-102 | ✅ Existing |
| `blog.html` | CollectionPage + ItemList | In file | TBD | ⚠️ To migrate |
| `tentang.html` | AboutPage + Organization | In file | TBD | ⚠️ To migrate |
| `kontak.html` | ContactPage + LocalBusiness | In file | TBD | ⚠️ To migrate |
| `product.html` | TBD (ItemList?) | In file | TBD | ❓ To decide |
| `_layouts/post.html` | BlogPosting | In layout | TBD | ⚠️ To migrate |
| `_layouts/post-with-products.html` | Article + ItemList (@graph) | In layout | 138-283 | ✅ Existing |
| `_layouts/product.html` | Product + ItemList (@graph) | In layout | 176-365 | ✅ Existing |

### After Phase 5 (Component-Level Schema - OPTIONAL):

| Page/Layout | Main Schema | Component Schema | Total Blocks |
|-------------|-------------|------------------|--------------|
| `index.html` | BreadcrumbList + ItemList (ALL) | - | 1 block |
| `blog.html` | CollectionPage + ItemList (posts) | - | 1 block |
| `tentang.html` | AboutPage + Organization | - | 1 block |
| `kontak.html` | ContactPage + LocalBusiness | - | 1 block |
| `_layouts/post.html` | BlogPosting | ItemList (from related-products component) | 2 blocks ⭐ |
| `_layouts/post-with-products.html` | Article | ItemList (from related-products component) | 2 blocks ⭐ |
| `_layouts/product.html` | Product | ItemList (from related-products component) | 2 blocks ⭐ |

**Key Improvement in Phase 5:**
- ✅ Each component self-contained (schema + markup)
- ✅ Schema matches visual (3 in schema = 3 shown)
- ✅ Multiple valid JSON-LD blocks per page
- ✅ Better modularity and portability

---

## Testing Strategy

### After Each Phase:

**1. Build Test:**
```bash
bundle exec jekyll build
# Should complete without errors
```

**2. Visual Test:**
- [ ] Page renders correctly (styling intact)
- [ ] No broken layouts
- [ ] Content displays properly

**3. Schema Validation:**
- [ ] Google Rich Results Test: https://search.google.com/test/rich-results
- [ ] Schema.org Validator: https://validator.schema.org/
- [ ] Check for errors/warnings
- [ ] Verify expected schema types appear
- [ ] Verify NO duplicate schemas (or intentional multiple blocks)

**4. Multiple Blocks Validation (Phase 5):**
- [ ] Verify multiple JSON-LD blocks detected
- [ ] Each block validates independently
- [ ] No conflicts between blocks
- [ ] numberOfItems matches visual count

**5. Functional Test:**
- [ ] Links work
- [ ] Forms work (if applicable)
- [ ] Navigation intact

---

## Rollback Plan

**If issues found:**

**Option 1: Git Revert**
```bash
git log --oneline  # Find commit before migration
git revert <commit-hash>
# Or
git reset --hard <commit-hash>
```

**Option 2: Backup Restoration**
- Keep backup: `cp _includes/head.html _includes/head.html.backup`
- Restore: `cp _includes/head.html.backup _includes/head.html`

**Option 3: Incremental Rollback**
- Only revert specific phase, not entire migration
- Identify which phase caused issue
- Revert only that commit

---

## Success Criteria

### Phase 1-4 (Core Migration) Success:
- [ ] All 5 schemas migrated/removed from head.html
- [ ] head.html reduced from 390 lines to ~80 lines (80% reduction)
- [ ] No schema duplication across files
- [ ] All pages pass Google Rich Results Test without errors
- [ ] All expected schema types appear correctly
- [ ] Site functionality intact (no broken pages/features)
- [ ] Build completes without errors
- [ ] SEO maintained (schema.org validation passes)
- [ ] Performance improved (less conditional evaluation)

### Phase 5 (Component-Level Schema) Success (if implemented):
- [ ] Components have their own schema blocks
- [ ] Layouts simplified (main content schema only)
- [ ] Multiple JSON-LD blocks validated by Google
- [ ] Schema numberOfItems matches visual display
- [ ] No schema/visual mismatch
- [ ] Components are portable (reusable across layouts)
- [ ] All pages still pass Google Rich Results Test
- [ ] Build time not significantly impacted

---

## Timeline Estimate (REVISED)

### Phase 1: Straightforward Migrations
- Task 1.1 (AboutPage): 30 min
- Task 1.2 (ContactPage): 30 min
- Task 1.3 (CollectionPage): 30 min
- **Subtotal:** 1.5 hours

### Phase 2: Handle Duplications
- Task 2.1 (Migrate BlogPosting): 45 min
- Task 2.2 (Remove duplication): 30 min
- **Subtotal:** 1.25 hours

### Phase 3: Remove Redundant Schemas
- Task 3.1 (Remove LocalBusiness): 30 min
- **Subtotal:** 0.5 hours

### Phase 4: Investigate & Decide
- Task 4.1 (Investigate product.html): 30 min
- Task 4.2 (Implement if needed): 1 hour
- **Subtotal:** 1.5 hours (conditional)

### Phase 5: Component-Level Schema (OPTIONAL)
- Task 5.1 (Decide strategy): 15 min
- Task 5.2 (Simplify post-with-products): 45 min
- Task 5.3 (Add to last-modified component): 30 min
- Task 5.4 (Add to node-id component): 30 min
- Task 5.5 (Article components - optional): 1 hour
- Task 5.6 (Product layout - optional): 30 min
- **Subtotal:** 2-3.5 hours (depending on scope)

**Total Estimated Time:**
- **Phase 1-4 (Core):** 3.25 - 4.75 hours
- **Phase 1-5 (Full):** 5.25 - 8.25 hours

Much faster than original estimate (6-11 hours) for core migration because:
- ✅ Product layout already has correct schema (no implementation needed)
- ✅ Post-with-products already has correct schema (just remove duplication)
- ✅ LocalBusiness just needs removal (not migration)

Phase 5 is optional enhancement for better architecture.

---

## Key Decisions Made

### ✅ Decision 1: LocalBusiness + OfferCatalog
**Question:** Pindahkan kemana atau modify?
**Decision:** **REMOVE entirely**
**Reason:**
- Individual product pages should use Product schema, NOT LocalBusiness
- `_layouts/product.html` already has correct Product + ItemList schema
- LocalBusiness + OfferCatalog (all products) tidak tepat untuk individual product page
**Date:** 2025-11-16

### ✅ Decision 2: Post-with-Products Schema
**Question:** Merge atau replace?
**Decision:** **Keep layout schema, remove from head.html**
**Reason:**
- Layout already has complete Article + ItemList schema via @graph
- Head.html BlogPosting is duplicate and less complete
**Date:** 2025-11-16

### ✅ Decision 3: Multiple Structured Data Blocks Architecture
**Question:** Use @graph everywhere or allow multiple JSON-LD blocks?
**Decision:** **Allow multiple blocks for independent entities**
**Reason:**
- Google officially supports multiple structured data blocks per page
- Each block can describe a different entity
- Better separation of concerns (layout vs component schemas)
- Enables component-level schema ownership
- Schema can match visual display accurately
**Date:** 2025-11-16

---

## Discussion Points (Pending)

### ❓ Discussion 1: Product Listing Page (product.html)
**Question:** Schema apa yang tepat untuk product listing page?
**Status:** Pending investigation (Task 4.1)
**Options:**
- A: ItemList (simple product catalog)
- B: CollectionPage + ItemList (more structured)
- C: No schema if duplicate of homepage
- D: Redirect to homepage if same content

**Decision:** ________________ (Date: ________)

---

### ❓ Discussion 2: Generic Page Layout (_layouts/page.html)
**Question:** Apakah layout ini terpakai? Perlu schema?
**Status:** Low priority (can defer)
**Options:**
- A: No schema needed (pages use specific templates)
- B: Add generic WebPage schema if used
- C: Remove layout if unused

**Decision:** ________________ (Date: ________)

---

### ❓ Discussion 3: Component-Level Schema Implementation ⭐
**Question:** Implement component-level schema (Phase 5)?
**Status:** Pending decision after Phase 1-3 complete
**Benefits:**
- ✅ Better modularity (component = schema + markup)
- ✅ Better accuracy (schema matches visual)
- ✅ Better separation of concerns
- ✅ Portable components

**Concerns:**
- ⚠️ Multiple JSON-LD blocks (but valid!)
- ⚠️ Extra work (update multiple files)
- ⚠️ Need to test thoroughly

**Options:**
- A: Implement in Phase 5 (after core migration)
- B: Create separate TODO-1533
- C: Defer to future optimization
- D: Don't implement (keep @graph approach)

**Decision:** ________________ (Date: ________)

---

### ❓ Discussion 4: Article Components Schema
**Question:** Should related-articles components have ItemList schema?
**Status:** Depends on Discussion 3 decision
**Options:**
- A: Yes (consistency with product components)
- B: No (articles already have individual schemas)
- C: Conditional (only for large lists)

**Decision:** ________________ (Date: ________)

---

## References

- [Schema.org Documentation](https://schema.org/)
- [Google Search Central - Structured Data](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data)
- **[Google - Multiple Structured Data Blocks](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data#multiple-items)** ⭐
- [Google Rich Results Test](https://search.google.com/test/rich-results)
- [Schema.org Validator](https://validator.schema.org/)
- [Jekyll Liquid Documentation](https://jekyllrb.com/docs/liquid/)
- [Schema.org @graph](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data#structured-data-format)
- [Schema.org ItemList](https://schema.org/ItemList)
- [Schema.org ListItem](https://schema.org/ListItem)

---

## Revision History

**2025-11-16 (Initial):** Created TODO with 5 phases based on head.html analysis

**2025-11-16 (Major Revision #1):** Updated after discovering:
- `_layouts/product.html` already has Product + ItemList schema (lines 176-365)
- `_layouts/post-with-products.html` already has Article + ItemList schema (lines 138-283)
- LocalBusiness + OfferCatalog in head.html is redundant and wrong schema type
- Simplified from 5 phases to 4 phases, reduced time estimate by 50%

**2025-11-16 (Major Revision #2):** Added component-level schema architecture:
- Added "Architecture Principle: Multiple Structured Data Blocks" section
- Added Finding #4 about Google's multiple blocks support
- Added Phase 5 (optional): Component-Level Schema implementation
- Updated schema distribution tables to show before/after Phase 5
- Added 6 new tasks for component-level schema (5.1-5.6)
- Added Discussion 3 & 4 for component schema decisions
- Updated timeline estimate to include Phase 5
- Clarified that current layouts have schema/visual mismatch issue
- Emphasized benefits of component-owned schemas

---

**Created by:** Claude Code
**Last Updated:** 2025-11-16
**Status:**
- **Phase 1-4:** Ready for execution
- **Phase 5:** Pending decision (optional enhancement)

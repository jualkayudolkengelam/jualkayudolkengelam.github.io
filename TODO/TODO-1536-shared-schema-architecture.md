# TODO-1536: Shared Schema Architecture Implementation

**Status:** Planning
**Priority:** High
**Created:** 2025-11-17
**Dependencies:** TODO-1534 (Drupal naming convention)
**Objective:** Implement shared schema includes untuk reusability dan DRY principle

---

## Context

### Current Situation:
- ✅ Component-level schema implemented (block--product-list.html)
- ✅ Schema duplication fixed on /product/ page
- ❌ **WebPage schema missing** di semua halaman
- ❌ **Schema code duplicated** di berbagai templates
- ❌ **No shared schema includes** untuk reusability

### Google Rich Results Test (/product/ page):
```
✅ Berhasil di-crawl (17 Nov 2025, 11:11:36)
✅ Data terstruktur terdeteksi:
   - Cuplikan produk: 5 item valid
   - Listingan penjual: 5 item valid
   - Carousel: 1 item valid
   - Cuplikan ulasan: 5 item valid

❌ Missing: WebPage schema
```

---

## Missing Components

### 1. WebPage Schema ❌

**What:** Base schema untuk semua halaman
**Where:** Should be in ALL pages
**Why:** SEO best practice, rich results eligibility

**Example:**
```liquid
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebPage",
  "@id": "{{ page.url | absolute_url }}#webpage",
  "url": "{{ page.url | absolute_url }}",
  "name": "{{ page.title }}",
  "description": "{{ page.description }}",
  "isPartOf": {
    "@type": "WebSite",
    "@id": "{{ site.url }}{{ site.baseurl }}/#website"
  },
  "breadcrumb": {
    "@type": "BreadcrumbList",
    "@id": "{{ page.url | absolute_url }}#breadcrumb"
  }
}
</script>
```

**Needed in:**
- Homepage (index.html)
- Product listing page (product.html)
- Blog listing page (blog.html)
- Static pages (tentang.html, kontak.html)
- All other pages

---

### 2. schema--page.html ❌

**What:** Shared WebPage schema include
**Purpose:** DRY - reuse WebPage schema across pages
**Location:** `_includes/schema--page.html`

**Implementation:**
```liquid
{% comment %}
  Shared Schema: WebPage

  Usage:
  {% include schema--page.html %}

  Parameters:
  - page: (required) page object
  - type: (optional) WebPage type variant (default: "WebPage")
  - breadcrumb: (optional) show breadcrumb (default: true)
{% endcomment %}

{% assign schema_type = include.type | default: "WebPage" %}
{% assign show_breadcrumb = include.breadcrumb | default: true %}

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "{{ schema_type }}",
  "@id": "{{ page.url | absolute_url }}#webpage",
  "url": "{{ page.url | absolute_url }}",
  "name": "{{ page.title }}",
  "description": "{{ page.description | default: site.description }}",
  "inLanguage": "{{ site.lang | default: 'id' }}",
  "isPartOf": {
    "@type": "WebSite",
    "@id": "{{ site.url }}{{ site.baseurl }}/#website",
    "url": "{{ site.url }}{{ site.baseurl }}/",
    "name": "{{ site.title }}"
  }{% if show_breadcrumb %},
  "breadcrumb": {
    "@type": "BreadcrumbList",
    "@id": "{{ page.url | absolute_url }}#breadcrumb"
  }{% endif %}{% if page.image %},
  "primaryImageOfPage": {
    "@type": "ImageObject",
    "url": "{{ page.image | absolute_url }}"
  }{% endif %}{% if page.date %},
  "datePublished": "{{ page.date | date_to_xmlschema }}",
  "dateModified": "{% if page.last_modified_at %}{{ page.last_modified_at | date_to_xmlschema }}{% else %}{{ page.date | date_to_xmlschema }}{% endif %}"{% endif %}
}
</script>
```

**Benefits:**
- ✅ Single source of truth for WebPage schema
- ✅ Easy to update (update once, applies everywhere)
- ✅ Consistent across all pages
- ✅ Parameterized for flexibility

---

### 3. schema--product.html ❌

**What:** Shared Product schema include
**Purpose:** Reuse Product schema in node--product.html, block--product.html, block--product-list.html
**Location:** `_includes/schema--product.html`

**Status:** Documented in TODO-1534 (lines 421-489) but NOT IMPLEMENTED

**Implementation:**
```liquid
{% comment %}
  Shared Schema: Product

  Usage in node--product.html:
  {% include schema--product.html product=page %}

  Usage in block--product.html:
  {% include schema--product.html product=include.product %}

  Usage in block--product-list.html:
  "item": {% include schema--product.html product=product raw=true %}

  Parameters:
  - product: (required) product object
  - raw: (optional) output raw JSON without <script> tags
{% endcomment %}

{% assign raw_output = include.raw | default: false %}
{% assign product = include.product %}

{% unless raw_output %}<script type="application/ld+json">{% endunless %}
{
  "@context": "https://schema.org",
  "@type": "Product",
  "@id": "{{ product.url | absolute_url }}#product",
  "name": "{{ product.title }}",
  "description": "{{ product.description | strip_html | strip_newlines | escape }}",
  "image": "{{ product.image | absolute_url }}",
  "url": "{{ product.url | absolute_url }}",
  "sku": "{{ product.sku }}",
  "brand": {
    "@type": "Brand",
    "name": "{{ site.business.name }}"
  },
  "category": "{{ product.category | default: 'Kayu Dolken Gelam' }}",
  "material": "{{ product.material | default: 'Kayu Gelam' }}",
  "offers": {
    "@type": "Offer",
    "price": "{{ product.price }}",
    "priceCurrency": "IDR",
    "availability": "https://schema.org/InStock",
    "url": "{{ product.url | absolute_url }}",
    "priceValidUntil": "{{ 'now' | date: '%Y' | plus: 1 }}-12-31",
    "seller": {
      "@type": "Organization",
      "name": "{{ site.business.name }}"
    }
  }{% if product.rating or product.review_count %},
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "{{ product.rating | default: 4.5 }}",
    "reviewCount": "{{ product.review_count | default: 45 }}",
    "bestRating": "5",
    "worstRating": "1"
  }{% endif %}{% if product.diameter %},
  "additionalProperty": [
    {
      "@type": "PropertyValue",
      "name": "Diameter",
      "value": "{{ product.diameter }}"
    },
    {
      "@type": "PropertyValue",
      "name": "Panjang",
      "value": "4 Meter"
    }
  ]{% endif %}
}
{% unless raw_output %}</script>{% endunless %}
```

**Benefits:**
- ✅ DRY: Single source for Product schema
- ✅ Consistency across all product displays
- ✅ Easy maintenance
- ✅ Can be used with/without script tags (raw mode)

---

### 4. block--product.html ❌

**What:** Single product card component
**Purpose:** Reusable product card with schema
**Location:** `_includes/block--product.html`

**Current Situation:**
- Product cards are hardcoded in various places
- No reusable component for single product
- Inconsistent styling across pages

**Implementation:**
```liquid
{% comment %}
  Component: Single Product Card

  Usage:
  {% for product in site.products %}
    {% include block--product.html product=product %}
  {% endfor %}

  Parameters:
  - product: (required) product object
  - show_schema: (optional) include schema (default: false)
  - variant: (optional) card style (default: "standard")
{% endcomment %}

{% assign product = include.product %}
{% assign show_schema = include.show_schema | default: false %}
{% assign variant = include.variant | default: "standard" %}

{% if show_schema %}
  {% include schema--product.html product=product %}
{% endif %}

<div class="product-card card border-0 shadow-sm h-100">
  <div class="card-body">
    <h5 class="card-title text-wood">{{ product.title }}</h5>
    <p class="card-text">{{ product.description | truncate: 100 }}</p>

    <div class="product-price text-wood fw-bold fs-5 mb-3">
      Rp {{ product.price | rupiah }}
    </div>

    {% if product.rating %}
    <div class="product-rating mb-3">
      <span class="text-warning">
        {% assign rating = product.rating %}
        {% for i in (1..5) %}
          {% if i <= rating %}★{% else %}☆{% endif %}
        {% endfor %}
      </span>
      <strong>{{ product.rating }}</strong>
      <small class="text-muted">({{ product.review_count | default: 0 }})</small>
    </div>
    {% endif %}

    <div class="d-grid gap-2">
      <a href="{{ product.url | relative_url }}" class="btn btn-wood">
        <i class="bi bi-info-circle"></i> Detail
      </a>
      <a href="https://wa.me/{{ site.business.whatsapp }}?text=Halo,%20saya%20ingin%20pesan%20{{ product.title }}"
         class="btn btn-success" target="_blank">
        <i class="bi bi-whatsapp"></i> Pesan
      </a>
    </div>
  </div>
</div>
```

**Used by:**
- Product grids
- Related products sections
- Featured products
- Search results

---

## Implementation Plan

### Phase 1: WebPage Schema ✅ HIGH PRIORITY

#### Task 1.1: Create schema--page.html
```bash
# Create file
touch _includes/schema--page.html

# Add WebPage schema implementation
# (see implementation above)
```

#### Task 1.2: Add WebPage schema to all pages

**Pages to update:**
- [ ] index.html (homepage)
- [ ] product.html (product listing)
- [ ] blog.html (blog listing)
- [ ] tentang.html (about page)
- [ ] kontak.html (contact page)

**Add to each page (before other schemas):**
```liquid
{% include schema--page.html %}
```

#### Task 1.3: Validate with Google Rich Results Test
- [ ] Test each page
- [ ] Verify WebPage schema detected
- [ ] No schema errors/warnings

---

### Phase 2: Product Schema Sharing

#### Task 2.1: Create schema--product.html
```bash
touch _includes/schema--product.html
# Add implementation (see above)
```

#### Task 2.2: Update node--product.html
```liquid
<!-- Before: Inline Product schema -->
<!-- After: -->
{% include schema--product.html product=page %}
```

#### Task 2.3: Create block--product.html
```bash
touch _includes/block--product.html
# Add implementation (see above)
```

#### Task 2.4: Test schema sharing
- [ ] Verify schema identical across usages
- [ ] No duplication
- [ ] Google validation passes

---

### Phase 3: Additional Shared Schemas (Optional)

#### schema--article.html
For blog posts (Article/BlogPosting)

#### schema--breadcrumb.html
For breadcrumb navigation

#### schema--organization.html
For business info (LocalBusiness)

---

## File Structure After Implementation

```
_includes/
├── schema--page.html              # WebPage schema ← NEW
├── schema--product.html           # Product schema ← NEW
├── block--product.html            # Single product card ← NEW
├── block--product-list.html       # Product list (existing)
├── block--related-product--by-node.html
└── ...

Pages using schema--page.html:
├── index.html                     # ← Add include
├── product.html                   # ← Add include
├── blog.html                      # ← Add include
├── tentang.html                   # ← Add include
└── kontak.html                    # ← Add include

Templates using schema--product.html:
├── _layouts/node--product.html    # ← Use shared schema
├── _includes/block--product.html  # ← Use shared schema
└── _includes/block--product-list.html  # ← Use shared schema
```

---

## Success Criteria

### Technical Success:
- [ ] schema--page.html created and working
- [ ] schema--product.html created and working
- [ ] block--product.html created and working
- [ ] All pages have WebPage schema
- [ ] No schema duplication
- [ ] Google Rich Results Test passes for all pages

### Validation Results:
```
Each page should show:
✅ WebPage (new!)
✅ Other relevant schemas (Product, ItemList, etc.)
✅ No errors
✅ No warnings
```

---

## Benefits

### 1. DRY Principle
- Schema defined once, used everywhere
- Easy to update (change once, applies everywhere)
- Reduces code duplication

### 2. Consistency
- Same schema structure across all pages
- No variations or missed fields
- Easier to maintain

### 3. SEO Improvement
- WebPage schema improves rich results eligibility
- Better structured data coverage
- Improved search engine understanding

### 4. Maintainability
- Centralized schema management
- Easy to add new fields
- Clear separation of concerns

---

## Timeline Estimate

| Phase | Tasks | Time |
|-------|-------|------|
| Phase 1: WebPage Schema | 3 tasks | 1-2 hours |
| Phase 2: Product Schema | 4 tasks | 2-3 hours |
| Phase 3: Additional (optional) | 3 schemas | 2-3 hours |
| **Total** | **10 tasks** | **5-8 hours** |

---

## Related TODOs

- TODO-1534: Drupal naming convention (architecture principle)
- TODO-1533: Component-level schema (schema ownership)
- TODO-1532: Schema migration per template

---

**Created by:** Claude Code
**Last Updated:** 2025-11-17
**Status:** Planning - Ready for Implementation

**Next Action:** Implement Phase 1 (WebPage schema) for immediate SEO benefit

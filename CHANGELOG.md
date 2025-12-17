# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.1] - 2025-11-16

### Fixed

**Component Schema - Complete Product Fields**

Fixed Google Rich Results non-critical warnings by adding optional but recommended Product schema fields to component-level schemas.

#### Files Changed

**`_includes/block--related-product--by-last-modified.html`**
- Added `shippingDetails` object to Offer schema
  - Free shipping (value: 0 IDR)
  - Ships to Indonesia (addressCountry: ID)
  - Handling time: 1-2 days
  - Transit time: 3-7 days
- Added `hasMerchantReturnPolicy` object
  - 7 days return window
  - Return method: by mail
  - Return fees: free

**`_includes/block--related-product--by-node.html`**
- Added `shippingDetails` object to Offer schema (same as above)
- Added `hasMerchantReturnPolicy` object (same as above)

#### Impact

- ✅ **Before:** 2 non-critical warnings per product in Google Rich Results Test
- ✅ **After:** 0 warnings - all Product schemas fully validated
- ✅ **Schema parity:** Component schemas now match layout schemas (product.html)
- ✅ **SEO improvement:** Complete merchant/shipping information for search engines

#### Testing

```bash
# Verified in Google Rich Results Test
URL: https://jualkayudolkengelam.net/blog/2025/11/15/jual-kayu-dolken-semarang/
Result: 11 items valid, 0 non-critical warnings
```

#### Technical Details

```
Files modified: 2
Lines added: +70
- shippingDetails: +28 lines per file
- hasMerchantReturnPolicy: +7 lines per file
```

#### Commits

- `2880ad2` - fix: Add optional Product schema fields to component schemas

---

## [1.0.0] - 2025-11-16

### Added

**Component-Level Schema Architecture Implementation**

Major restructuring of schema.org implementation from centralized (head.html) to decentralized component-level architecture, following Google's "multiple structured data blocks" principle.

#### Architecture Changes

**Before:**
- All schemas centralized in `_includes/head.html` (391 lines)
- Schemas in layouts with @graph structure
- Schema/visual mismatches (schema describes 6 products, visual shows 3)

**After:**
- Clean head.html with only meta tags (59 lines)
- Layouts handle main content schemas only
- Components own their schemas (schema + logic + presentation together)
- Perfect schema/visual accuracy

#### Files Changed

##### 1. **`_includes/head.html`** (-367 lines)

**Removed all schema.org blocks:**
- ❌ LocalBusiness + OfferCatalog (for product pages) - lines 28-124
- ❌ CollectionPage + ItemList (for /blog) - lines 126-162
- ❌ AboutPage + Organization (for /tentang) - lines 164-232
- ❌ ContactPage + LocalBusiness (for /kontak) - lines 234-299
- ❌ BlogPosting (for post layouts) - lines 301-358

**Kept:**
- ✅ SEO meta tags (title, description, keywords, author, canonical)
- ✅ Open Graph tags (Facebook sharing)
- ✅ Twitter Card tags
- ✅ Performance optimizations (preconnect, fetchpriority, preload)
- ✅ Favicons

##### 2. **`_layouts/post-with-products.html`** (-84 lines)

**Simplified schema structure:**
- ❌ Removed @graph wrapper
- ❌ Removed ItemList schema for products (moved to component)
- ❌ Removed conditional `{% if page.show_products %}`
- ✅ Kept Article schema only (main content)

**Schema now:**
```json
{
  "@type": "Article",
  "headline": "...",
  "author": {...},
  "publisher": {...},
  "interactionStatistic": [...]
}
```

##### 3. **`_layouts/product.html`** (-188 lines)

**Removed duplicate logic:**
- ❌ Removed node-based rotation logic (lines 252-287, duplicated from component)
- ❌ Removed ItemList schema (lines 248-362, moved to component)
- ❌ Removed @graph wrapper
- ✅ Kept Product schema only (current product)

**Schema now:**
```json
{
  "@type": "Product",
  "name": "...",
  "sku": "...",
  "offers": {...},
  "aggregateRating": {...}
}
```

##### 4. **`_includes/block--related-product--by-last-modified.html`** (+48 lines)

**Added component-level schema:**
- ✅ ItemList schema for 3 most recently updated products
- ✅ Schema placed after logic, before HTML
- ✅ Uses `final_products` variable (matches visual display)
- ✅ numberOfItems: 3 (accurate)

**Schema structure:**
```json
{
  "@type": "ItemList",
  "name": "Produk Kayu Dolken Terbaru",
  "numberOfItems": 3,
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "item": {
        "@type": "Product",
        "name": "...",
        "offers": {...},
        "aggregateRating": {...}
      }
    }
  ]
}
```

##### 5. **`_includes/block--related-product--by-node.html`** (+48 lines)

**Added component-level schema:**
- ✅ ItemList schema for 3 rotated products
- ✅ Node-based rotation (each page shows different products)
- ✅ Schema uses same rotation logic as visual
- ✅ Perfect schema/visual match

#### Results

**Page Structure Examples:**

**Blog Post Page** (`/blog/2025/11/15/jual-kayu-dolken-jakarta-utara/`)
```
📄 2 separate JSON-LD blocks:
  1. Article schema (from layout)
  2. ItemList schema (from component - 3 products)
```

**Product Page** (`/product/kayu-dolken-8-10cm/`)
```
📦 2 separate JSON-LD blocks:
  1. Product schema (from layout - current product)
  2. ItemList schema (from component - 3 related products)
```

#### Benefits

- ✅ **Schema accuracy:** Describes exactly what's displayed (no more 6 vs 3 mismatch)
- ✅ **Component modularity:** Each component owns its schema + logic + presentation
- ✅ **Multiple JSON-LD blocks:** Follows Google's best practice
- ✅ **Maintainability:** Changes to component automatically update schema
- ✅ **No duplication:** Eliminated duplicate rotation logic in layouts
- ✅ **Separation of concerns:** Layouts handle main content, components handle supplementary data

#### Code Statistics

```
Total changes: 5 files
Lines deleted: -639
Lines added: +96
Net reduction: -543 lines (85% reduction in schema code)

File breakdown:
  head.html:                          -367 lines
  post-with-products.html:            -84 lines
  product.html:                       -188 lines
  related-products-by-last-modified:  +48 lines
  related-products-by-node-id:        +48 lines
```

#### Architecture Principle

Following Google's documentation:
> "You can add multiple structured data blocks to a single page. Each block can describe a different entity."

**Implementation:**
- Layout: Main content schema (Article/Product)
- Component: Supplementary schema (ItemList for related products)
- Each entity in separate `<script type="application/ld+json">` block

#### Testing & Validation

**Build Status:**
```bash
✅ Jekyll build: PASSED (0.327s)
✅ Generated: 173 files (35M)
✅ No errors or warnings
```

**Google Rich Results Test:**
```
✅ Multiple schema types detected per page
✅ Article + ItemList (blog pages)
✅ Product + ItemList (product pages)
✅ numberOfItems matches visual display
✅ All schemas valid
```

**Verified Pages:**
- `/blog/2025/11/15/jual-kayu-dolken-jakarta-utara/` ✅
- `/blog/2025/11/15/jual-kayu-dolken-semarang/` ✅
- `/product/kayu-dolken-8-10cm/` ✅
- `/product/kayu-dolken-6-8cm/` ✅

#### Migration Path

This release completes **TODO-1533: Component-Level Schema Implementation**

**Completed phases:**
- ✅ Phase 1: Prepare Layouts (remove conflicting schemas)
- ✅ Phase 2: Add Schemas to Components (product components)

**Optional future work:**
- [ ] Add schemas to article components (block--related-content--latest.html)
- [ ] Add schemas to content components (block--related-content--by-node.html)

#### Breaking Changes

**None.** This is a refactoring that improves architecture without breaking functionality.

**Visual changes:** None - all pages render identically
**Schema changes:** More accurate, better structured (improvement, not breaking)

#### Backup

Original head.html preserved as `_includes/head-backup.html` before migration.

#### Commits

- `e2401fb` - feat: Implement component-level schema architecture
- `5f571bc` - feat: Component schema for product pages

#### Documentation

**Related TODO files:**
- `TODO/TODO-1531-performance-optimization-plan.md`
- `TODO/TODO-1532-schema-migration-per-template.md`
- `TODO/TODO-1533-component-level-schema.md`

---

## [Unreleased]

### Planned

**Performance Optimizations (TODO-1531):**
- Service Worker & PWA implementation
- Asset versioning & cache busting
- Jekyll Cache plugin for schema generation
- Lazy load Bootstrap JS
- jekyll-picture-tag for responsive images
- Critical CSS inlining

**Schema Migration (TODO-1532):**
- Migrate remaining static page schemas (tentang, kontak, blog)
- Optional: Add schemas to article components

---

## Version History

- **v1.0.1** (2025-11-16) - Fix: Complete Product schema fields (shippingDetails, hasMerchantReturnPolicy)
- **v1.0.0** (2025-11-16) - Major: Component-level schema architecture implementation
- **v0.9.0** (2025-11-16) - Performance optimizations (preconnect, fetchpriority, LCP preload)
- **v0.8.0** (2025-11-15) - Modern hero intro cards for articles
- **v0.7.0** (2025-11-15) - CSS architecture refactoring with SCSS partials
- **v0.6.0** (2025-11-15) - Engagement metrics display (likes, comments, shares)
- **v0.5.0** (2025-11-14) - Product photos and WebP optimization
- **v0.4.0** (2025-11-14) - Node-based product rotation system
- **v0.3.0** (2025-11-14) - Blog layout split (post vs post-with-products)
- **v0.2.0** (2025-11-14) - Initial schema.org implementation
- **v0.1.0** (2025-11-14) - Initial Jekyll setup

---

**Project:** Jual Kayu Dolken Gelam Website
**Owner:** Kayu Dolken Gelam - Amirudin Abdul Karim
**Repository:** https://github.com/jualkayudolkengelam/jualkayudolkengelam.net
**Website:** https://jualkayudolkengelam.net

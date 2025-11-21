# TODO-1534: Drupal Naming Convention Migration

**Status:** ✅ COMPLETED
**Priority:** Medium
**Created:** 2025-11-17
**Completed:** 2025-11-17
**Objective:** Migrate Jekyll layouts and components to Drupal-style naming convention for better organization, consistency, and scalability

---

## Context

### Current Naming (Inconsistent):
```
_layouts/
├── default.html
├── post.html
├── post-with-city.html
└── product.html

_includes/
├── related-content-by-node-id.html
├── related-products-by-last-modified.html
├── block--related-product--by-node.html
├── product-list.html
└── image-carousel.html
```

### Problems:
1. ❌ **Tidak ada hierarchy** - Susah bedakan base vs variant
2. ❌ **Tidak konsisten** - Ada `post.html`, `product.html`, tapi base-nya `default.html`
3. ❌ **Tidak scalable** - Sulit tambah variants baru
4. ❌ **Tidak self-documenting** - Nama tidak menjelaskan relationship
5. ❌ **Components tidak terorganisir** - `related-*`, `product-*` tercampur tanpa pattern

---

## Drupal Naming Convention

### Drupal Three-Tier Template Architecture:

```
┌─────────────────────────────────────────────────────────┐
│ page.html - Page Wrapper (header, footer, sidebars)    │
│                                                         │
│  ┌───────────────────────────────────────────────────┐ │
│  │ node.html - Content Template (article/product)   │ │
│  │                                                   │ │
│  │  ┌─────────────────────────────────────────────┐ │ │
│  │  │ block.html - Reusable Components           │ │ │
│  │  │  (related content, product list, carousel) │ │ │
│  │  └─────────────────────────────────────────────┘ │ │
│  └───────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

### Template Types:

1. **page.html** - Page wrappers (site structure)
   - Controls overall page layout
   - Contains header, footer, navigation
   - Wraps node content

2. **node.html** - Content templates (content types)
   - Individual content item display
   - Article, product, post layouts
   - Main content area

3. **block.html** - Components (reusable blocks)
   - Related content, product lists
   - Carousels, cards, CTAs
   - Embedded in page or node

### Pattern Structure:
```
{entity-type}--{variant}.html
{entity-type}--{variant}--{sub-variant}.html

Examples:
- page.html (base page wrapper)
- page--front.html (homepage wrapper)
- node.html (base content template)
- node--product.html (product content type)
- node--post.html (blog post content type)
- block.html (base block component)
- block--product-list.html (product listing block)
```

### Key Rules:
1. ✅ **Base template** = fallback (e.g., `page.html`, `node.html`, `block.html`)
2. ✅ **Double dash `--`** = variant separator
3. ✅ **Specific > General** = cascade/specificity hierarchy
4. ✅ **Three-tier architecture** = page wraps node wraps block
5. ✅ **Alphabetically grouped** = better file organization
6. ✅ **Self-documenting** = nama explains purpose

---

## How Page, Node, and Block Work Together

### Template Hierarchy in Drupal:

```liquid
<!-- page.html (Page Wrapper) -->
<!DOCTYPE html>
<html>
<head>
  {% include head.html %}
</head>
<body>
  {% include header.html %}

  <main>
    {{ content }}  <!-- This renders node.html or node--*.html -->
  </main>

  {% include footer.html %}
</body>
</html>
```

```liquid
<!-- node--post.html (Content Template) -->
---
layout: page  <!-- Wraps in page.html -->
---

<article class="blog-post">
  <h1>{{ page.title }}</h1>
  <div class="content">
    {{ content }}  <!-- The actual post content -->
  </div>

  <!-- Embed blocks -->
  {% include block--related-content--by-node.html %}
  {% include block--product-list.html %}
</article>

<!-- Article schema -->
<script type="application/ld+json">
{
  "@type": "Article",
  "headline": "{{ page.title }}"
}
</script>
```

```liquid
<!-- block--related-content--by-node.html (Component) -->
<section class="related-content">
  <h3>Artikel Terkait</h3>
  {% for post in related_posts %}
    <div class="card">{{ post.title }}</div>
  {% endfor %}
</section>

<!-- BlogPosting schema -->
<script type="application/ld+json">
{
  "@type": "ItemList",
  "itemListElement": [...]
}
</script>
```

### Flow Example:

1. User visits `/blog/post-1`
2. Jekyll loads `_posts/post-1.md`:
   ```yaml
   ---
   layout: node--post
   title: "My Post"
   ---
   Post content here...
   ```

3. Jekyll processes `node--post.html`:
   - Reads frontmatter: `layout: page`
   - Renders post content + related blocks
   - Outputs HTML to `{{ content }}`

4. Jekyll wraps in `page.html`:
   - Adds header, footer, navigation
   - Inserts `{{ content }}` from node--post.html
   - Final output sent to browser

### Benefits:

✅ **Separation of concerns:**
- page.html = site structure
- node.html = content display
- block.html = reusable components

✅ **DRY (Don't Repeat Yourself):**
- Header/footer only in page.html (one place)
- Content layouts in node--*.html (specific to type)
- Blocks reused across multiple node templates

✅ **Easy maintenance:**
- Change site header → edit page.html only
- Change blog layout → edit node--post.html only
- Update product list → edit block--product-list.html only

---

## Proposed New Structure

### Layouts (_layouts/)

#### Current → New Mapping:

| Current | New | Type | Notes |
|---------|-----|------|-------|
| `default.html` | `page.html` | Page wrapper | Base page layout (header, footer) |
| *(new)* | `page--front.html` | Homepage wrapper | Special layout for homepage only |
| *(new)* | `page--product.html` | Product wrapper | Special layout for product pages with product-specific includes |
| *(new)* | `node.html` | Base content | Fallback content template |
| `post.html` | `node--post.html` | Blog post content | Single blog post layout |
| `post-with-city.html` | `node--post-with-city.html` | City post content | Blog post + city-specific content |
| `product.html` | `node--product.html` | Product content | Single product detail |

---

### When to Use page--* vs node--*

#### Understanding the Decision:

**Question:** When do we need page--* variants vs just using page.html?

**Answer:** Create a `page--*.html` variant when you need **page-type-specific includes** or **different site structure**.

**Key Principle:**
- **Node templates** = Pure entity content (no includes)
- **Page wrappers** = Site structure + page-type-specific includes

---

#### ✅ Homepage NEEDS page--front.html (Site Structure Variation)

**Reason:** Homepage has **different site structure** than other pages.

**Current Analysis of default.html (Lines 1-15):**
```html
<!DOCTYPE html>
<html>
  {% include head.html %}
  {% include header.html %}
  <main class="main-content">
    {{ content }}
  </main>
  {% include footer.html %}
  {% include whatsapp-button.html %}
</html>
```

**Why Homepage Needs Different Wrapper:**
1. **Different header style:**
   - Regular pages: Standard header with navigation
   - Homepage: Could have transparent/fixed header, hero section

2. **Different layout structure:**
   - Regular pages: May have sidebar, standard container
   - Homepage: Full-width hero, multiple sections (features, testimonials, products preview, blog preview)

3. **Different footer:**
   - Regular pages: Compact footer
   - Homepage: Expanded footer with more info, newsletter signup

**Example page--front.html Structure:**
```html
<body class="homepage">
  <header class="transparent-header fixed">Logo | Menu</header>

  <section class="hero-full-width">
    <!-- Big hero section -->
  </section>

  <main class="no-sidebar full-width">
    {{ content }}  <!-- Homepage content blocks -->
  </main>

  <footer class="expanded-footer">
    <!-- Bigger footer with newsletter, social, multiple columns -->
  </footer>
</body>
```

**✅ Result:** Homepage has **different wrapper** = needs `page--front.html`

---

#### ✅ Products NEED page--product.html (Page-Type-Specific Includes)

**Reason:** Product pages need **product-specific includes** that other pages don't need.

**Architecture Principle:**
- **Node templates** = Pure entity content (standalone, no includes)
- **Page wrappers** = Place for page-type-specific includes

**Why Products Need page--product.html:**

1. **Product pages need product-specific components:**
   - Related products (by node similarity)
   - Product catalog/listing
   - Product comparison tables
   - Product-specific CTAs

2. **Blog pages DON'T need these:**
   - Blog posts only need related articles (not products)
   - Static pages don't need product components
   - Forcing product includes on all pages via page.html = wrong!

3. **Node should be pure entity:**
   - `node--product.html` = Product detail content ONLY
   - No includes in node (separation of concerns)
   - Includes belong in page wrapper

**Correct Structure:**
```
page--product.html (product page wrapper)
├── header.html, footer.html
├── {{ content }} → renders node--product.html
└── Product-specific includes:
    ├── block--related-product--by-node.html
    └── block--product-list.html

node--product.html (pure product entity)
├── layout: page--product  ← uses product wrapper
└── Product detail HTML (image, specs, price)
    └── NO includes here!
```

**Example page--product.html:**
```html
<main class="main-content">
  {{ content }}  <!-- node--product.html content -->

  <!-- Product-specific includes -->
  <div class="container">
    <div class="row mt-5">
      <div class="col-12">
        {% include block--related-product--by-node.html %}
      </div>
    </div>
    <div class="row mt-4">
      <div class="col-12">
        {% include block--product-list.html title="Produk Lainnya" %}
      </div>
    </div>
  </div>
</main>
```

**✅ Result:** Products need **page wrapper with specific includes** = `page--product.html` + `node--product.html`

---

#### Decision Matrix:

| Need | Use | Example |
|------|-----|---------|
| Different **site structure** OR **page-type-specific includes** | `page--*.html` | Homepage (hero, different footer), Products (related products, catalog) |
| Different **content layout** only | `node--*.html` | Products (price, specs) vs Posts (date, author) |
| **Reusable component** with data | `block--*.html` | Product card, related content widget |
| Same component, different **variant/behavior** | `block--*--*.html` | Related products by-node vs by-last-modified |

---

#### Real Examples from This Site:

**page.html (Site Wrapper - Base):**
- Used by: Blog posts, Static pages, Hybrid posts
- Contains: header.html, footer.html, whatsapp-button.html
- Purpose: Consistent site structure for standard pages
- Includes: None (or general content for all pages)

**page--front.html (Homepage Wrapper - Variant):**
- Used by: Homepage only (index.md or index.html)
- Contains: Same header/footer as page.html, different hero/layout
- Purpose: Special homepage design for conversion
- Includes: Hero carousel, featured products, latest posts

**page--product.html (Product Wrapper - Variant):**
- Used by: Product detail pages (wraps node--product.html)
- Contains: Same header/footer as page.html
- Purpose: Product pages with product-specific components
- Includes: Related products, product catalog, comparison

**node--post.html (Blog Content):**
- Wrapped by: page.html
- Layout: `layout: page`
- Contains: Post title, date, content, author
- Purpose: Blog post content layout
- Includes: NONE (pure content)

**node--product.html (Product Content):**
- Wrapped by: page--product.html (NOT page.html!)
- Layout: `layout: page--product`
- Contains: Product title, image, price, specs
- Purpose: Product detail content layout
- Includes: NONE (pure entity, includes in page wrapper)

**node--post-with-city.html (City Content):**
- Wrapped by: page.html (same wrapper!)
- Contains: Post content + city-specific content
- Purpose: Blog post with city-specific information

---

### Shared Schema Architecture

#### Problem: Schema Duplication

When same entity (e.g., Product) appears in multiple places, we get duplicate schema code:
- `node--product.html` needs Product schema
- `block--product.html` needs Product schema
- `/product.html` listing needs ItemList with Product schemas

**Solution:** Shared Schema Includes

**Create:** `_includes/schema--product.html`
```liquid
{% comment %}
  Shared Product Schema
  Used by: node--product.html, block--product.html, block--product-list.html
{% endcomment %}

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "{{ include.product.title }}",
  "description": "{{ include.product.description | strip_html | escape }}",
  "image": "{{ include.product.image | absolute_url }}",
  "url": "{{ include.product.url | absolute_url }}",
  "sku": "{{ include.product.sku }}",
  "offers": { ... },
  "aggregateRating": { ... }
}
</script>
```

**Usage:**

In `node--product.html`:
```liquid
---
layout: page--product
---
{% include schema--product.html product=page %}
<!-- Product detail HTML -->
```

In `block--product.html`:
```liquid
{% include schema--product.html product=include.product %}
<!-- Product card HTML -->
```

In `block--product-list.html`:
```liquid
<script type="application/ld+json">
{
  "@type": "ItemList",
  "itemListElement": [
    {% for product in site.products %}
    {
      "@type": "ListItem",
      "position": {{ forloop.index }},
      "item": {% include schema--product.html product=product raw=true %}
    }
    {% endfor %}
  ]
}
</script>
```

**Benefits:**
✅ Single source of truth for Product schema
✅ No duplication - update once, applies everywhere
✅ Consistent schema across all contexts
✅ Easier to maintain and debug

**Shared Schemas to Create:**
- `schema--product.html` - Product entity schema
- `schema--article.html` - BlogPosting/Article schema
- `schema--organization.html` - Business/Organization schema
- `schema--breadcrumb.html` - BreadcrumbList schema

---

#### Future Variants (Examples):

**Page Templates (Wrappers):**
```
page--two-column.html     # Two-column layout (future)
page--full-width.html     # Full-width layout (future)
page--landing.html        # Landing page (future, for marketing campaigns)
```

**Node Templates (Content Types):**
```
node--post--archive.html  # Blog archive layout (future)
node--category.html       # Category listing (future)
node--page.html           # Static page content (future)
```

---

### Blocks/Components (_includes/)

#### New Block Organization:

**Base Blocks:**
```
block.html                     # Base block template (new)
block--content.html            # Generic content block (new)
block--product.html            # Generic product block (new)
```

**Related Content Blocks:**
```
block--related-content.html                    # Base related content
block--related-content--by-node.html          # Node-based proximity
block--related-content--latest.html           # Latest posts
```

**Product Blocks:**
```
block--product-list.html                      # Full product catalog
block--product-list--featured.html            # Featured products only
block--related-product.html                   # Base related products
block--related-product--by-node.html          # Node-based rotation
block--related-product--by-last-modified.html # Recently updated
```

**UI Blocks:**
```
block--carousel.html                   # Generic carousel
block--carousel--image.html            # Image gallery carousel
block--carousel--product.html          # Product carousel
```

**Navigation Blocks:**
```
block--menu.html                       # Base menu
block--menu--main.html                 # Main navigation
block--menu--footer.html               # Footer menu
```

**Utility Blocks:**
```
block--cta.html                        # Call-to-action
block--hero.html                       # Hero section
block--card.html                       # Generic card
block--card--link.html                 # Link card (terdekat)
```

---

## Migration Plan

### Phase 1: Layouts Migration

#### Task 1.1: Rename Layout Files

**Checklist:**
- [ ] Backup current layouts (git commit before migration)
- [ ] Rename `default.html` → `page.html` (page wrapper)
- [ ] Create `page--front.html` (homepage wrapper - copy from page.html, customize for homepage)
- [ ] Create `page--product.html` (product wrapper - copy from page.html, add product-specific includes)
- [ ] Create `node.html` (base content template - copy from page.html, strip wrapper)
- [ ] Rename `post.html` → `node--post.html` (content type)
- [ ] Rename `post-with-products.html` → `node--post-with-product.html` (content type)
- [ ] Rename `product.html` → `node--product.html` (content type)
- [ ] Update all frontmatter `layout:` references in content files
- [ ] Update homepage (index.html/index.md) to use `layout: page--front`
- [ ] Update product pages to use `layout: page--product`
- [ ] Test build
- [ ] Commit: "Migrate layouts to Drupal naming convention"

**Commands:**
```bash
cd _layouts/

# Rename page wrapper
git mv default.html page.html

# Create homepage wrapper (will need manual editing)
cp page.html page--front.html

# Create product wrapper (will need manual editing for includes)
cp page.html page--product.html

# Create base node template (will need manual editing)
cp page.html node.html

# Rename content type templates
git mv post.html node--post.html
git mv post-with-products.html node--post-with-product.html
git mv product.html node--product.html
```

**Files to Update (frontmatter):**
```bash
# Find all files using old layout names
grep -r "layout: default" _posts/ _post_with_product/ _products/
grep -r "layout: post" _posts/
grep -r "layout: post-with-products" _post_with_product/
grep -r "layout: product" _products/

# Update references
# - Posts use node-- templates (wrapped by page.html)
# - Products use page--product wrapper (which wraps node--product.html internally)
sed -i 's/layout: default/layout: page/g' {files}
sed -i 's/layout: post$/layout: node--post/g' {files}
sed -i 's/layout: post-with-products/layout: node--post-with-product/g' {files}
sed -i 's/layout: product/layout: page--product/g' {files}  # Products use page wrapper variant!
```

**Manual Steps for page--front.html:**
After creating page--front.html, customize it for homepage:
1. Add `class="homepage"` to body tag
2. Consider adding hero section before main content
3. Change header styling (e.g., transparent, fixed)
4. Modify footer (expanded with more info)
5. Adjust main layout (full-width, no sidebar)
6. This will be used ONLY by homepage (index.html/index.md)

**Manual Steps for page--product.html:**
After creating page--product.html, add product-specific includes:
1. Keep same header/footer as page.html (site structure stays consistent)
2. Change `{{ content }}` section to include product-specific components:
   ```liquid
   <main class="main-content">
     {{ content }}  <!-- Renders node--product.html -->

     <!-- Product-specific includes -->
     <div class="row mt-5">
       <div class="col-12">
         {% include block--related-product--by-node.html %}
       </div>
     </div>

     <div class="row mt-5">
       <div class="col-12">
         {% include block--product-list.html %}
       </div>
     </div>
   </main>
   ```
3. This wrapper will be used by ALL product pages (_products/*.md)
4. Keeps node--product.html pure (entity only, no includes)

**Manual Steps for node.html:**
After creating node.html, edit it to:
1. Remove header/footer (those belong in page.html)
2. Keep only content area structure
3. Set its layout to `page` (node wraps in page)
4. This becomes the fallback content template

---

#### Task 1.2: Update Layout References

**Locations to check:**
- [ ] Homepage (`index.html` or `index.md`) frontmatter → should use `layout: page--front`
- [ ] `_posts/*.md` frontmatter → should use `layout: node--post`
- [ ] `_post_with_product/*.md` frontmatter → should use `layout: node--post-with-product`
- [ ] `_products/*.md` frontmatter → should use `layout: page--product` (wrapper, not node!)
- [ ] Static pages (about, contact, etc.) → should use `layout: page` (if they need wrapper)
- [ ] Any other collections
- [ ] Documentation/README

**Verification:**
```bash
# Should return empty (no old layout references)
grep -r "layout: default" . --exclude-dir=_site
grep -r "layout: post-with-products" . --exclude-dir=_site
grep -r "layout: product$" . --exclude-dir=_site
grep -r "layout: post$" . --exclude-dir=_site

# Should find NEW references
grep -r "layout: page" . --exclude-dir=_site
grep -r "layout: page--front" . --exclude-dir=_site  # Homepage
grep -r "layout: page--product" . --exclude-dir=_site  # Products
grep -r "layout: node--" . --exclude-dir=_site  # Content types
```

---

### Phase 2: Blocks/Components Migration

#### Task 2.1: Reorganize Related Content Blocks

**Current:**
```
_includes/related-content-by-node-id.html
_includes/related-articles.html
```

**New:**
```
_includes/block--related-content--by-node.html
_includes/block--related-content--latest.html
```

**Steps:**
- [ ] Rename `related-content-by-node-id.html` → `block--related-content--by-node.html`
- [ ] Rename `related-articles.html` → `block--related-content--latest.html`
- [ ] Update all `{% include %}` references
- [ ] Test build
- [ ] Commit: "Migrate related-content blocks to Drupal naming"

---

#### Task 2.2: Reorganize Product Blocks

**Current:**
```
_includes/product-list.html
_includes/related-products-by-last-modified.html
_includes/block--related-product--by-node.html
```

**New:**
```
_includes/block--product-list.html
_includes/block--related-product--by-last-modified.html
_includes/block--related-product--by-node.html
```

**Steps:**
- [ ] Rename product-related includes
- [ ] Update all `{% include %}` references in layouts & content
- [ ] Test build
- [ ] Commit: "Migrate product blocks to Drupal naming"

---

#### Task 2.3: Reorganize UI Blocks

**Current:**
```
_includes/image-carousel.html
_includes/jual-kayu-dolken-terdekat-link-card.html
```

**New:**
```
_includes/block--carousel--image.html
_includes/block--card--link.html (atau block--link-card.html)
```

**Steps:**
- [ ] Rename UI components
- [ ] Update include references
- [ ] Test carousel functionality
- [ ] Test build
- [ ] Commit: "Migrate UI blocks to Drupal naming"

---

#### Task 2.4: Organize Utility Blocks

**Current includes that stay or reorganize:**
```
_includes/head.html → keep (system file)
_includes/header.html → keep (system file)
_includes/footer.html → keep (system file)
_includes/whatsapp-button.html → block--cta--whatsapp.html
```

**New utility blocks to create:**
- [ ] Extract CTA sections → `block--cta.html`
- [ ] Extract hero sections → `block--hero.html`
- [ ] Generic card template → `block--card.html`

---

### Phase 3: Documentation & Standards

#### Task 3.1: Create Naming Convention Guide

**Create:** `docs/NAMING-CONVENTION.md`

**Contents:**
- Drupal naming pattern explanation
- Layout naming rules
- Block naming rules
- Examples for each type
- Guidelines for creating new templates
- Migration history

**Checklist:**
- [ ] Document pattern structure
- [ ] Provide examples
- [ ] List all current layouts & blocks
- [ ] Guidelines for contributors
- [ ] Commit: "Add Drupal naming convention documentation"

---

#### Task 3.2: Update Component Documentation

**Update headers in each file:**

**Before:**
```liquid
{% comment %}
  File: product-list.html
  Description: Product catalog listing
{% endcomment %}
```

**After:**
```liquid
{% comment %}
  ============================================================================
  Block: Product List (Catalog)
  ============================================================================

  @file        block--product-list.html
  @type        Block
  @variant     product-list (full catalog)
  @description Complete product catalog with pricing table and schema

  Drupal-style naming: block--{entity}--{variant}.html

  Related blocks:
  - block--product-list--featured.html (featured products only)
  - block--related-product--by-node.html (node-based recommendations)

  Usage:
  {% include block--product-list.html %}
  ============================================================================
{% endcomment %}
```

**Checklist:**
- [ ] Add Drupal naming reference to all block headers
- [ ] Document related blocks
- [ ] Update file paths in comments
- [ ] Add @type and @variant tags
- [ ] Commit: "Update block documentation with Drupal naming"

---

### Phase 4: Testing & Validation

#### Task 4.1: Build Testing

**Checklist:**
- [ ] Clean build: `bundle exec jekyll clean`
- [ ] Full build: `bundle exec jekyll build`
- [ ] Check for errors/warnings
- [ ] Verify no missing includes
- [ ] Test all page types:
  - [ ] Homepage (uses page--front.html wrapper - special layout)
  - [ ] Blog posts (uses node--post.html wrapped by page.html)
  - [ ] Blog with products (uses node--post-with-product.html wrapped by page.html)
  - [ ] Product pages (uses node--product.html wrapped by page--product.html)
  - [ ] Static pages (uses page.html wrapper directly if no node template)
- [ ] Verify all blocks render correctly
- [ ] Check schema.org markup intact
- [ ] Verify page > node > block hierarchy works

---

#### Task 4.2: Link Verification

**Checklist:**
- [ ] All internal links work
- [ ] All includes found
- [ ] No 404s from old references
- [ ] RSS feed works
- [ ] Sitemap generates correctly

---

#### Task 4.3: Schema Validation

**Verify schemas unaffected:**
- [ ] Article schema (node--post.html, node--post-with-product.html)
- [ ] Product schema (node--product.html)
- [ ] ItemList schema (block--product-list.html)
- [ ] ImageGallery schema (block--carousel--image.html)
- [ ] BlogPosting schema (block--related-content-*.html)
- [ ] Test with Google Rich Results Test
- [ ] Verify @id paths still correct after rename

---

### Phase 5: Cleanup & Finalization

#### Task 5.1: Remove Old Naming References

**Check for any remaining old patterns:**
```bash
# Search for old naming patterns in code/docs
grep -r "related-content-by-node" .
grep -r "related-products-by" .
grep -r "product-list" . --exclude-dir=_site

# Should find ZERO results
```

**Checklist:**
- [ ] No old include references in content
- [ ] No old layout references in frontmatter
- [ ] Update README if references old names
- [ ] Update any documentation
- [ ] Check git history/comments

---

#### Task 5.2: Create Migration Summary

**Create:** `TODO/COMPLETED-1533-drupal-naming-migration-summary.md`

**Contents:**
- Migration date
- Files renamed (before/after table)
- Breaking changes (if any)
- Benefits achieved
- Lessons learned
- Future recommendations

---

## File Mapping Reference

### Complete Layouts Mapping:

| Old Path | New Path | Template Type |
|----------|----------|---------------|
| `_layouts/default.html` | `_layouts/page.html` | Page wrapper (base) |
| *(new)* | `_layouts/page--front.html` | Page wrapper (homepage) |
| *(new)* | `_layouts/page--product.html` | Page wrapper (products) |
| *(new)* | `_layouts/node.html` | Content template (base) |
| `_layouts/post.html` | `_layouts/node--post.html` | Blog post content |
| `_layouts/post-with-products.html` | `_layouts/node--post-with-product.html` | Hybrid post content |
| `_layouts/product.html` | `_layouts/node--product.html` | Product content |

### Complete Blocks Mapping:

| Old Path | New Path | Block Type |
|----------|----------|------------|
| `_includes/related-content-by-node-id.html` | `_includes/block--related-content--by-node.html` | Related content |
| `_includes/related-articles.html` | `_includes/block--related-content--latest.html` | Related content |
| `_includes/product-list.html` | `_includes/block--product-list.html` | Product listing |
| `_includes/related-products-by-last-modified.html` | `_includes/block--related-product--by-last-modified.html` | Related products |
| `_includes/block--related-product--by-node.html` | `_includes/block--related-product--by-node.html` | Related products |
| `_includes/image-carousel.html` | `_includes/block--carousel--image.html` | UI component |
| `_includes/jual-kayu-dolken-terdekat-link-card.html` | `_includes/block--card--link.html` | UI component |
| `_includes/whatsapp-button.html` | `_includes/block--cta--whatsapp.html` | CTA component |

### System Files (Keep As-Is):

| File | Keep Original | Reason |
|------|---------------|--------|
| `_includes/head.html` | ✅ Yes | Jekyll convention |
| `_includes/header.html` | ✅ Yes | Jekyll convention |
| `_includes/footer.html` | ✅ Yes | Jekyll convention |
| `_includes/article-schema.html` | ❓ Consider `block--schema--article.html` | Schema component |

---

## Benefits After Migration

### 1. **Better Organization**
```
_includes/
├── block--card--link.html
├── block--carousel--image.html
├── block--cta--whatsapp.html
├── block--product-list.html
├── block--related-content--by-node.html
├── block--related-content--latest.html
├── block--related-product--by-last-modified.html
└── block--related-product--by-node.html
```
✅ All blocks grouped together alphabetically
✅ Clear hierarchy visible from names

### 2. **Scalability**
Easy to add new variants:
```
block--product-list--featured.html      # New variant
block--related-content--by-category.html # New variant
page--post--archive.html                # New layout
```

### 3. **Self-Documenting**
```
block--related-product--by-last-modified.html
^      ^                ^
|      |                └── Variant: sorting method
|      └── Entity: product (related)
└── Type: block/component
```

### 4. **Consistency**
All files follow same pattern → easier onboarding, maintenance

### 5. **Searchability**
```bash
# Find all product-related blocks
ls _includes/block--*product*

# Find all related-content blocks
ls _includes/block--related-content*

# Find all carousel blocks
ls _includes/block--carousel*
```

---

## Risks & Mitigation

### Risk 1: Breaking Changes
**Mitigation:**
- ✅ Use `git mv` to preserve history
- ✅ Do comprehensive testing before commit
- ✅ Update all references in single commit
- ✅ Have rollback plan (git revert)

### Risk 2: Missed References
**Mitigation:**
- ✅ Use grep to find all references
- ✅ Search entire codebase
- ✅ Test all page types
- ✅ Check generated HTML for missing includes

### Risk 3: Schema Breakage
**Mitigation:**
- ✅ Schema markup is in file content, not filename
- ✅ Test with Google Rich Results after migration
- ✅ Verify @id paths still work
- ✅ Check all schema types

---

## Timeline Estimate

| Phase | Tasks | Estimated Time |
|-------|-------|----------------|
| Phase 1: Layouts | 2 tasks | 1-2 hours |
| Phase 2: Blocks | 4 tasks | 3-4 hours |
| Phase 3: Documentation | 2 tasks | 1-2 hours |
| Phase 4: Testing | 3 tasks | 2-3 hours |
| Phase 5: Cleanup | 2 tasks | 1 hour |
| **Total** | **13 tasks** | **8-12 hours** |

---

## Success Criteria

- [ ] Page wrapper renamed: `default.html` → `page.html`
- [ ] Homepage wrapper created: `page--front.html`
- [ ] Homepage (index.html/index.md) uses `layout: page--front`
- [ ] Product wrapper created: `page--product.html` with product-specific includes
- [ ] Product pages (_products/*.md) use `layout: page--product`
- [ ] Base node template created: `node.html`
- [ ] All content templates renamed to `node--*.html` pattern
- [ ] All blocks renamed to `block--*.html` pattern
- [ ] No old naming references remain in codebase
- [ ] All pages render correctly (including homepage and products with new wrappers)
- [ ] All includes found
- [ ] Three-tier hierarchy works: page > node > block
- [ ] Node templates are pure entities (no includes)
- [ ] Page wrappers contain page-type-specific includes
- [ ] Schema.org markup intact (no duplication)
- [ ] Build completes without errors
- [ ] Google Rich Results Test passes
- [ ] Documentation updated
- [ ] Migration summary created

---

## Implementation Status

### ✅ Completed (2025-11-17)

**Layouts Migration:**
- ✅ `page.html` - Base page wrapper (migrated from default.html)
- ✅ `page--front.html` - Homepage wrapper (created)
- ✅ `page--product.html` - Product wrapper with product-specific includes (created)
- ✅ `node.html` - Base content template (created)
- ✅ `node--page.html` - Static page content (created)
- ✅ `node--post.html` - Blog post content (migrated)
- ✅ `node--post-with-city.html` - City post content (migrated)
- ✅ `node--product.html` - Product detail content (migrated)

**Blocks Migration:**
- ✅ `block--breadcrumb.html` - Breadcrumb navigation with Schema.org markup (created)
- ✅ `block--navigation.html` - Main navigation menu with SiteNavigationElement schema (created)
- ✅ `block--product.html` - Single product card component (existing)
- ✅ `block--product-list.html` - Product listing catalog (migrated)
- ✅ `block--related-content--by-node.html` - Node-based related content (migrated)
- ✅ `block--related-content--latest.html` - Latest articles (migrated)
- ✅ `block--related-product--by-node.html` - Node-based related products (migrated)
- ✅ `block--related-product--by-last-modified.html` - Recently updated products (migrated)
- ✅ `block--carousel--image.html` - Image gallery carousel (migrated)
- ✅ `block--card--link.html` - Link card component (migrated)
- ✅ `block--cta--whatsapp.html` - WhatsApp CTA button (migrated)

**Schema Architecture:**
- ✅ `schema--page.html` - Shared WebPage schema (created)
- ✅ `schema--product.html` - Shared Product schema (created)
- ✅ `schema--product-page.html` - Product page specific schema (created)

**Content Updates:**
- ✅ All frontmatter layout references updated
- ✅ All `{% include %}` references updated to new block names
- ✅ Breadcrumb with Schema.org BreadcrumbList added to all non-homepage pages
- ✅ Container wrapper (`container py-4`) added for consistent layout

**Additional Improvements:**
- ✅ Navigation menu extracted to reusable component with schema
- ✅ Breadcrumb component supports custom parent (parent_name, parent_url)
- ✅ Blog posts use breadcrumb component (Beranda > Blog > [Title])
- ✅ All pages have consistent container layout

**Build & Testing:**
- ✅ Jekyll build completes without errors
- ✅ All page types render correctly
- ✅ All blocks render correctly
- ✅ Schema.org markup intact and valid
- ✅ No missing includes or broken references

**Commits:**
- ✅ Breadcrumb and container wrapper implementation committed
- ✅ Navigation component with schema committed

---

## References

- [Drupal Twig Templates](https://www.drupal.org/docs/theming-drupal/twig-in-drupal/twig-template-naming-conventions)
- [Drupal Template Suggestions](https://www.drupal.org/docs/theming-drupal/twig-in-drupal/working-with-twig-templates)
- [BEM Naming Convention](http://getbem.com/naming/)

---

**Created by:** Claude Code
**Last Updated:** 2025-11-17
**Status:** ✅ COMPLETED

**Revision Notes:**
- Added `page--front.html` for homepage wrapper (special layout)
- Added `page--product.html` for product wrapper (includes separation)
- Corrected architecture: Products NEED page--product.html for page-type-specific includes
- Architecture principle: Node templates = pure entities (no includes), Page wrappers = includes container
- Added decision matrix for when to use `page--*` vs `node--*` vs `block--*`
- Added shared schema architecture to prevent duplication
- Included real examples from this site showing current structure
- Updated migration plan to include both homepage and product wrapper creation
- Updated success criteria to verify proper separation of concerns
- Fixed sed commands to use `layout: page--product` for products (not node--product)

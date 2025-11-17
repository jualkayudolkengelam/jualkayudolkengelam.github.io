# TODO-1535: Drupal Naming Convention Migration - Execution Checklist

**Status:** Not Started
**Priority:** High
**Created:** 2025-11-17
**Dependencies:** TODO-1534 (Naming Convention Planning)
**Objective:** Execute step-by-step migration of Jekyll layouts and components to Drupal-style naming convention

---

## Context

This is the **execution checklist** for implementing the Drupal naming convention migration planned in TODO-1534.

**Reference Documentation:** `TODO/TODO-1534-drupal-naming-convention-migration.md`

**Key Migration:**
- `default.html` → `page.html` (page wrapper)
- *(new)* → `page--front.html` (homepage wrapper)
- *(new)* → `node.html` (base content template)
- `post.html` → `node--post.html` (blog content)
- `post-with-products.html` → `node--post-with-product.html` (hybrid content)
- `product.html` → `node--product.html` (product content)
- All includes → `block--*.html` pattern

---

## Pre-Migration Checklist

### Safety & Backup

- [ ] **Verify working directory is clean**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html
  git status
  ```
  - Should show "working tree clean" or only expected changes

- [ ] **Create backup commit (current state)**
  ```bash
  git add -A
  git commit -m "Pre-migration backup: Before Drupal naming convention migration

  Current state before TODO-1535 execution.
  Reference: TODO-1534-drupal-naming-convention-migration.md

  🤖 Generated with [Claude Code](https://claude.com/claude-code)

  Co-Authored-By: Claude <noreply@anthropic.com>"
  ```

- [ ] **Create migration branch (optional but recommended)**
  ```bash
  git checkout -b migration/drupal-naming-convention
  ```

- [ ] **Document current file structure**
  ```bash
  ls -1 _layouts/ > /tmp/layouts-before.txt
  ls -1 _includes/ > /tmp/includes-before.txt
  ```

---

## Phase 1: Layouts Migration

### Task 1.1: Rename and Create Layout Files

**Working Directory:** `_layouts/`

- [ ] **Navigate to layouts directory**
  ```bash
  cd _layouts/
  pwd  # Should show: /home/mkt01/Public/jualkayudolkengelam.github.io/public_html/_layouts
  ```

- [ ] **Rename default.html → page.html**
  ```bash
  git mv default.html page.html
  git status  # Verify: renamed: _layouts/default.html -> _layouts/page.html
  ```

- [ ] **Create page--front.html (homepage wrapper)**
  ```bash
  cp page.html page--front.html
  git add page--front.html
  ```

- [ ] **Edit page--front.html for homepage customization**
  - [ ] Add `class="homepage"` to body tag
  - [ ] Add comment: `<!-- Page Wrapper: Homepage (page--front.html) -->`
  - [ ] Consider adding hero section placeholder
  - [ ] Document: "This wrapper is used ONLY by homepage (index.html)"

- [ ] **Create node.html (base content template)**
  ```bash
  cp page.html node.html
  git add node.html
  ```

- [ ] **Edit node.html to strip wrapper elements**
  - [ ] Remove `<!DOCTYPE html>`, `<html>`, `<head>` tags
  - [ ] Remove `{% include head.html %}`
  - [ ] Remove `{% include header.html %}`
  - [ ] Remove `{% include footer.html %}`
  - [ ] Remove `{% include whatsapp-button.html %}`
  - [ ] Keep only: `<article>` or `<main>` content area
  - [ ] Add frontmatter: `layout: page` (node wraps in page)
  - [ ] Add comment: `<!-- Base Content Template (node.html) -->`

- [ ] **Rename post.html → node--post.html**
  ```bash
  git mv post.html node--post.html
  git status  # Verify rename
  ```

- [ ] **Update node--post.html layout reference**
  - [ ] Change frontmatter: `layout: default` → `layout: page`
  - [ ] Add comment: `<!-- Content Type: Blog Post (node--post.html) -->`

- [ ] **Rename post-with-products.html → node--post-with-product.html**
  ```bash
  git mv post-with-products.html node--post-with-product.html
  git status  # Verify rename
  ```

- [ ] **Update node--post-with-product.html layout reference**
  - [ ] Change frontmatter: `layout: default` → `layout: page`
  - [ ] Add comment: `<!-- Content Type: Blog Post with Products (node--post-with-product.html) -->`

- [ ] **Rename product.html → node--product.html**
  ```bash
  git mv product.html node--product.html
  git status  # Verify rename
  ```

- [ ] **Update node--product.html layout reference**
  - [ ] Change frontmatter: `layout: default` → `layout: page`
  - [ ] Add comment: `<!-- Content Type: Product (node--product.html) -->`

- [ ] **Verify layouts directory structure**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html
  ls -1 _layouts/
  ```
  Expected output:
  ```
  node--post-with-product.html
  node--post.html
  node--product.html
  node.html
  page--front.html
  page.html
  ```

---

### Task 1.2: Update Content Files Layout References

**Working Directory:** `/home/mkt01/Public/jualkayudolkengelam.github.io/public_html`

- [ ] **Find all files using old layout names**
  ```bash
  # Posts
  grep -l "layout: post" _posts/*.md 2>/dev/null | wc -l

  # Post with products
  grep -l "layout: post-with-products" _post_with_product/*.md 2>/dev/null | wc -l

  # Products
  grep -l "layout: product" _products/*.md 2>/dev/null | wc -l

  # Any remaining default
  grep -l "layout: default" . -r --include="*.md" --include="*.html" --exclude-dir=_site 2>/dev/null
  ```
  - [ ] Document counts for verification later

- [ ] **Update blog posts: layout: post → layout: node--post**
  ```bash
  # Find and replace in all _posts/*.md files
  find _posts/ -name "*.md" -type f -exec sed -i 's/^layout: post$/layout: node--post/g' {} +

  # Verify changes
  grep -l "layout: node--post" _posts/*.md | wc -l
  grep -l "layout: post$" _posts/*.md | wc -l  # Should be 0
  ```

- [ ] **Update hybrid posts: layout: post-with-products → layout: node--post-with-product**
  ```bash
  # Find and replace in all _post_with_product/*.md files
  find _post_with_product/ -name "*.md" -type f -exec sed -i 's/^layout: post-with-products$/layout: node--post-with-product/g' {} +

  # Verify changes
  grep -l "layout: node--post-with-product" _post_with_product/*.md | wc -l
  grep -l "layout: post-with-products" _post_with_product/*.md | wc -l  # Should be 0
  ```

- [ ] **Update products: layout: product → layout: node--product**
  ```bash
  # Find and replace in all _products/*.md files
  find _products/ -name "*.md" -type f -exec sed -i 's/^layout: product$/layout: node--product/g' {} +

  # Verify changes
  grep -l "layout: node--product" _products/*.md | wc -l
  grep -l "layout: product$" _products/*.md | wc -l  # Should be 0
  ```

- [ ] **Update homepage: index.html or index.md → layout: page--front**
  ```bash
  # Find homepage file
  ls -la index.* 2>/dev/null

  # Check current layout
  grep "^layout:" index.* 2>/dev/null

  # Update to page--front (manual edit or sed)
  # If index.html:
  sed -i 's/^layout: default$/layout: page--front/g' index.html
  # OR if index.md:
  sed -i 's/^layout: default$/layout: page--front/g' index.md

  # Verify
  grep "^layout:" index.*
  ```

- [ ] **Update static pages (if any): layout: default → layout: page**
  ```bash
  # Find static pages (about, contact, etc.)
  find . -maxdepth 1 -name "*.md" -o -name "*.html" | grep -v index | grep -v README

  # Check their current layout
  grep "^layout:" about.* contact.* 2>/dev/null

  # Update if they use layout: default
  # (Only if they need page wrapper, not node template)
  find . -maxdepth 1 \( -name "*.md" -o -name "*.html" \) ! -name "index.*" -type f -exec sed -i 's/^layout: default$/layout: page/g' {} +
  ```

- [ ] **Final verification: No old layout references remain**
  ```bash
  # Should return 0 results
  grep -r "layout: default" . --include="*.md" --include="*.html" --exclude-dir=_site
  grep -r "layout: post-with-products" . --include="*.md" --include="*.html" --exclude-dir=_site
  grep -r "layout: product$" . --include="*.md" --include="*.html" --exclude-dir=_site
  grep -r "layout: post$" . --include="*.md" --include="*.html" --exclude-dir=_site

  # Should find NEW references
  grep -r "layout: page" . --include="*.md" --include="*.html" --exclude-dir=_site | head -5
  grep -r "layout: node--" . --include="*.md" --include="*.html" --exclude-dir=_site | head -5
  ```

- [ ] **Stage layout changes**
  ```bash
  git add _posts/ _post_with_product/ _products/ index.* about.* contact.* 2>/dev/null
  git status
  ```

---

## Phase 2: Blocks/Components Migration

### Task 2.1: Related Content Blocks

**Working Directory:** `_includes/`

- [ ] **Navigate to includes directory**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html/_includes
  pwd
  ```

- [ ] **Check current related-content files**
  ```bash
  ls -la related-content* related-articles* 2>/dev/null
  ```

- [ ] **Rename: related-content-by-node-id.html → block--related-content--by-node.html**
  ```bash
  git mv related-content-by-node-id.html block--related-content--by-node.html
  ```

- [ ] **Rename: related-articles.html → block--related-content--latest.html** (if exists)
  ```bash
  git mv related-articles.html block--related-content--latest.html 2>/dev/null || echo "File not found, skipping"
  ```

- [ ] **Update {% include %} references to related-content blocks**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html

  # Find all files including old names
  grep -r "related-content-by-node-id.html" . --exclude-dir=_site
  grep -r "related-articles.html" . --exclude-dir=_site

  # Replace in all files
  find . -type f \( -name "*.html" -o -name "*.md" \) ! -path "./_site/*" -exec sed -i 's/related-content-by-node-id\.html/block--related-content--by-node.html/g' {} +
  find . -type f \( -name "*.html" -o -name "*.md" \) ! -path "./_site/*" -exec sed -i 's/related-articles\.html/block--related-content--latest.html/g' {} +

  # Verify no old references
  grep -r "related-content-by-node-id.html" . --exclude-dir=_site
  grep -r "related-articles.html" . --exclude-dir=_site
  ```

---

### Task 2.2: Product Blocks

- [ ] **Check current product-related files**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html/_includes
  ls -la product-list* related-products* 2>/dev/null
  ```

- [ ] **Rename: product-list.html → block--product-list.html**
  ```bash
  git mv product-list.html block--product-list.html
  ```

- [ ] **Rename: related-products-by-last-modified.html → block--related-product--by-last-modified.html**
  ```bash
  git mv related-products-by-last-modified.html block--related-product--by-last-modified.html
  ```

- [ ] **Rename: block--related-product--by-node.html → block--related-product--by-node.html**
  ```bash
  git mv block--related-product--by-node.html block--related-product--by-node.html
  ```

- [ ] **Update {% include %} references to product blocks**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html

  # Find all files including old names
  grep -r "product-list\.html" . --exclude-dir=_site
  grep -r "related-products-by-last-modified\.html" . --exclude-dir=_site
  grep -r "related-products-by-node-id\.html" . --exclude-dir=_site

  # Replace in all files
  find . -type f \( -name "*.html" -o -name "*.md" \) ! -path "./_site/*" -exec sed -i 's/product-list\.html/block--product-list.html/g' {} +
  find . -type f \( -name "*.html" -o -name "*.md" \) ! -path "./_site/*" -exec sed -i 's/related-products-by-last-modified\.html/block--related-product--by-last-modified.html/g' {} +
  find . -type f \( -name "*.html" -o -name "*.md" \) ! -path "./_site/*" -exec sed -i 's/related-products-by-node-id\.html/block--related-product--by-node.html/g' {} +

  # Verify no old references
  grep -r "product-list\.html" . --exclude-dir=_site --exclude-dir=TODO
  grep -r "related-products-by" . --exclude-dir=_site --exclude-dir=TODO
  ```

---

### Task 2.3: UI Blocks (Carousel, Cards)

- [ ] **Check current UI component files**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html/_includes
  ls -la image-carousel* *link-card* 2>/dev/null
  ```

- [ ] **Rename: image-carousel.html → block--carousel--image.html**
  ```bash
  git mv image-carousel.html block--carousel--image.html 2>/dev/null || echo "File not found, skipping"
  ```

- [ ] **Rename: jual-kayu-dolken-terdekat-link-card.html → block--card--link.html**
  ```bash
  git mv jual-kayu-dolken-terdekat-link-card.html block--card--link.html 2>/dev/null || echo "File not found, skipping"
  ```

- [ ] **Update {% include %} references to UI blocks**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html

  # Find and replace
  find . -type f \( -name "*.html" -o -name "*.md" \) ! -path "./_site/*" -exec sed -i 's/image-carousel\.html/block--carousel--image.html/g' {} +
  find . -type f \( -name "*.html" -o -name "*.md" \) ! -path "./_site/*" -exec sed -i 's/jual-kayu-dolken-terdekat-link-card\.html/block--card--link.html/g' {} +

  # Verify no old references
  grep -r "image-carousel\.html" . --exclude-dir=_site --exclude-dir=TODO
  grep -r "jual-kayu-dolken-terdekat-link-card\.html" . --exclude-dir=_site --exclude-dir=TODO
  ```

---

### Task 2.4: Utility Blocks (WhatsApp, CTAs)

- [ ] **Check current utility component files**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html/_includes
  ls -la whatsapp-button* 2>/dev/null
  ```

- [ ] **Rename: whatsapp-button.html → block--cta--whatsapp.html**
  ```bash
  git mv whatsapp-button.html block--cta--whatsapp.html 2>/dev/null || echo "File not found, skipping"
  ```

- [ ] **Update {% include %} references to WhatsApp block**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html

  # Find all references (likely in page.html, page--front.html)
  grep -r "whatsapp-button\.html" . --exclude-dir=_site

  # Replace in all files
  find . -type f \( -name "*.html" -o -name "*.md" \) ! -path "./_site/*" -exec sed -i 's/whatsapp-button\.html/block--cta--whatsapp.html/g' {} +

  # Verify no old references
  grep -r "whatsapp-button\.html" . --exclude-dir=_site --exclude-dir=TODO
  ```

- [ ] **Verify includes directory structure**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html
  ls -1 _includes/block--*
  ```
  Expected files starting with `block--`:
  ```
  block--card--link.html
  block--carousel--image.html
  block--cta--whatsapp.html
  block--product-list.html
  block--related-content--by-node.html
  block--related-content--latest.html
  block--related-product--by-last-modified.html
  block--related-product--by-node.html
  ```

- [ ] **Stage all blocks changes**
  ```bash
  git add _includes/ _layouts/
  git status
  ```

---

## Phase 3: Testing & Validation

### Task 3.1: Build Testing

- [ ] **Clean previous build**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html
  bundle exec jekyll clean
  ```

- [ ] **Run full build with verbose output**
  ```bash
  bundle exec jekyll build --verbose
  ```
  - [ ] Build completes successfully (exit code 0)
  - [ ] No errors in output
  - [ ] No warnings about missing layouts
  - [ ] No warnings about missing includes

- [ ] **Check for missing includes errors**
  ```bash
  bundle exec jekyll build 2>&1 | grep -i "could not locate"
  bundle exec jekyll build 2>&1 | grep -i "included file"
  ```
  - [ ] Should return empty (no missing includes)

- [ ] **Verify generated files exist**
  ```bash
  # Homepage
  ls -la _site/index.html

  # Sample blog post
  ls -la _site/blog/ | head -5

  # Sample product
  ls -la _site/products/ | head -5 2>/dev/null || ls -la _site/product/ | head -5
  ```

---

### Task 3.2: Visual Testing (Local Server)

- [ ] **Start local Jekyll server**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html
  bundle exec jekyll serve --host 0.0.0.0 --port 4000
  ```

- [ ] **Test Homepage (page--front.html)**
  - [ ] Visit: http://localhost:4000/
  - [ ] Page renders correctly
  - [ ] Header displays properly
  - [ ] Footer displays properly
  - [ ] WhatsApp button appears
  - [ ] No missing content blocks
  - [ ] Check browser console: no 404 errors

- [ ] **Test Blog Post (node--post.html)**
  - [ ] Visit a blog post (e.g., /blog/latest-post/)
  - [ ] Post content renders correctly
  - [ ] Related content block appears
  - [ ] Layout uses page.html wrapper (same header/footer as homepage)
  - [ ] No broken includes

- [ ] **Test Blog with Products (node--post-with-product.html)**
  - [ ] Visit a hybrid post
  - [ ] Post content renders
  - [ ] Product list block appears
  - [ ] All products display correctly
  - [ ] No broken includes

- [ ] **Test Product Page (node--product.html)**
  - [ ] Visit a product page
  - [ ] Product details render correctly
  - [ ] Product image displays
  - [ ] Price shows correctly
  - [ ] Product catalog block appears
  - [ ] No broken includes

- [ ] **Test Static Pages (page.html wrapper)**
  - [ ] Visit /about/ or /tentang/
  - [ ] Visit /contact/ or /kontak/
  - [ ] Pages render correctly
  - [ ] Same header/footer as other pages

- [ ] **Stop Jekyll server**
  ```bash
  # Press Ctrl+C in terminal
  ```

---

### Task 3.3: Schema Validation

- [ ] **Check schema in generated HTML files**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html/_site

  # Check homepage schema
  grep -o '<script type="application/ld+json">.*</script>' index.html | head -1

  # Check blog post schema
  find blog/ -name "*.html" -type f | head -1 | xargs grep -o '<script type="application/ld+json">.*</script>' | head -1

  # Check product schema
  find products/ -name "*.html" -type f 2>/dev/null | head -1 | xargs grep -o '<script type="application/ld+json">.*</script>' | head -1
  ```
  - [ ] Schemas present in all page types
  - [ ] No syntax errors in schema JSON

- [ ] **Validate with Google Rich Results Test** (if internet available)
  - [ ] Test homepage URL
  - [ ] Test blog post URL
  - [ ] Test product URL
  - [ ] All pass validation
  - [ ] No critical errors

---

### Task 3.4: Link Verification

- [ ] **Check internal links**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html

  # Build and check for broken links (if htmlproofer installed)
  # bundle exec htmlproofer ./_site --disable-external

  # OR manual check of key pages
  grep -r 'href="/' _site/index.html | head -10
  ```
  - [ ] Internal links work
  - [ ] No 404 errors

- [ ] **Verify RSS feed generated**
  ```bash
  ls -la _site/feed.xml
  cat _site/feed.xml | head -20
  ```
  - [ ] feed.xml exists
  - [ ] Contains valid XML

- [ ] **Verify sitemap generated**
  ```bash
  ls -la _site/sitemap.xml
  cat _site/sitemap.xml | head -20
  ```
  - [ ] sitemap.xml exists
  - [ ] Contains URLs

---

## Phase 4: Documentation Updates

### Task 4.1: Update Component Headers

- [ ] **Add Drupal naming documentation to page.html**
  ```liquid
  {% comment %}
  ============================================================================
  Page Wrapper: Base Layout (page.html)
  ============================================================================

  @file        page.html
  @type        Page (wrapper)
  @description Base page layout with header, footer, navigation

  Drupal-style naming: page.html (base) / page--{variant}.html

  This wrapper is used by ALL content types except homepage.

  Related wrappers:
  - page--front.html (homepage special layout)

  Usage:
  Content types set `layout: page` in frontmatter
  ============================================================================
  {% endcomment %}
  ```

- [ ] **Add documentation to page--front.html**

- [ ] **Add documentation to node.html**

- [ ] **Add documentation to node--post.html**

- [ ] **Add documentation to node--post-with-product.html**

- [ ] **Add documentation to node--product.html**

- [ ] **Add documentation to all block--*.html files**
  - [ ] block--product-list.html
  - [ ] block--related-content--by-node.html
  - [ ] block--related-product--by-node.html
  - [ ] block--related-product--by-last-modified.html
  - [ ] block--carousel--image.html (if exists)
  - [ ] block--card--link.html (if exists)
  - [ ] block--cta--whatsapp.html (if exists)

---

### Task 4.2: Create/Update Documentation Files

- [ ] **Create NAMING-CONVENTION.md guide** (if doesn't exist)
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html
  mkdir -p docs
  ```
  - [ ] Explain Drupal naming pattern
  - [ ] List all current layouts with purpose
  - [ ] List all current blocks with purpose
  - [ ] Guidelines for adding new templates
  - [ ] Reference TODO-1534

- [ ] **Update README.md** (if references old names)
  ```bash
  grep -i "default.html\|post.html\|product.html" README.md 2>/dev/null
  ```
  - [ ] Update any references to old layout names
  - [ ] Add note about Drupal naming convention

---

## Phase 5: Commit & Finalize

### Task 5.1: Final Verification

- [ ] **Ensure NO old references remain**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html

  # Layouts
  grep -r "layout: default" . --include="*.md" --include="*.html" --exclude-dir=_site --exclude-dir=TODO
  grep -r "layout: post$" . --include="*.md" --include="*.html" --exclude-dir=_site --exclude-dir=TODO
  grep -r "layout: post-with-products" . --include="*.md" --include="*.html" --exclude-dir=_site --exclude-dir=TODO
  grep -r "layout: product" . --include="*.md" --include="*.html" --exclude-dir=_site --exclude-dir=TODO

  # Includes
  grep -r "related-content-by-node-id\.html" . --exclude-dir=_site --exclude-dir=TODO
  grep -r "related-products-by" . --exclude-dir=_site --exclude-dir=TODO
  grep -r "product-list\.html" . --exclude-dir=_site --exclude-dir=TODO
  grep -r "image-carousel\.html" . --exclude-dir=_site --exclude-dir=TODO
  grep -r "whatsapp-button\.html" . --exclude-dir=_site --exclude-dir=TODO

  # All should return 0 results (empty)
  ```

- [ ] **Verify NEW naming is in place**
  ```bash
  # Layouts
  grep -r "layout: page" . --include="*.md" --include="*.html" --exclude-dir=_site | wc -l
  grep -r "layout: page--front" . --include="*.md" --include="*.html" --exclude-dir=_site | wc -l
  grep -r "layout: node--" . --include="*.md" --include="*.html" --exclude-dir=_site | wc -l

  # Includes
  grep -r "block--" . --include="*.html" --exclude-dir=_site | wc -l

  # Should have results
  ```

- [ ] **Final build test**
  ```bash
  bundle exec jekyll clean
  bundle exec jekyll build
  echo $?  # Should be 0 (success)
  ```

---

### Task 5.2: Create Migration Commit

- [ ] **Review all changes**
  ```bash
  git status
  git diff --stat
  ```

- [ ] **Stage all migration changes**
  ```bash
  git add -A
  ```

- [ ] **Create migration commit**
  ```bash
  git commit -m "$(cat <<'EOF'
  Migrate to Drupal naming convention for layouts and blocks

  ## Layouts Migration

  Renamed:
  - default.html → page.html (base page wrapper)
  - post.html → node--post.html (blog content)
  - post-with-products.html → node--post-with-product.html (hybrid content)
  - product.html → node--product.html (product content)

  Created:
  - page--front.html (homepage wrapper)
  - node.html (base content template)

  ## Blocks Migration

  Renamed all includes to block--*.html pattern:
  - related-content-by-node-id.html → block--related-content--by-node.html
  - related-articles.html → block--related-content--latest.html
  - product-list.html → block--product-list.html
  - related-products-by-last-modified.html → block--related-product--by-last-modified.html
  - block--related-product--by-node.html → block--related-product--by-node.html
  - image-carousel.html → block--carousel--image.html
  - jual-kayu-dolken-terdekat-link-card.html → block--card--link.html
  - whatsapp-button.html → block--cta--whatsapp.html

  ## Content Updates

  Updated all frontmatter layout references:
  - Blog posts: layout: post → layout: node--post
  - Hybrid posts: layout: post-with-products → layout: node--post-with-product
  - Products: layout: product → layout: node--product
  - Homepage: layout: default → layout: page--front
  - Static pages: layout: default → layout: page

  Updated all {% include %} references to new block names.

  ## Benefits

  ✅ Three-tier hierarchy: page > node > block
  ✅ Self-documenting file names
  ✅ Better organization and scalability
  ✅ Consistent naming pattern across all templates
  ✅ Easier to add new variants in the future

  ## Testing

  - ✅ Build completes without errors
  - ✅ All page types render correctly
  - ✅ All blocks render correctly
  - ✅ Schema.org markup intact
  - ✅ No missing includes
  - ✅ Internal links work

  Reference: TODO-1534, TODO-1535

  🤖 Generated with [Claude Code](https://claude.com/claude-code)

  Co-Authored-By: Claude <noreply@anthropic.com>
  EOF
  )"
  ```

- [ ] **Verify commit**
  ```bash
  git log -1 --stat
  git show --stat
  ```

---

### Task 5.3: Create Migration Summary Document

- [ ] **Create completion summary**
  ```bash
  cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html/TODO
  ```

- [ ] **Document migration results** in `COMPLETED-1535-drupal-naming-migration-summary.md`
  - [ ] Migration date
  - [ ] Files renamed (before/after table)
  - [ ] Number of content files updated
  - [ ] Any issues encountered
  - [ ] Testing results
  - [ ] Benefits achieved
  - [ ] Future recommendations

- [ ] **Update TODO-1535 status to COMPLETED**
  ```markdown
  **Status:** ✅ COMPLETED
  **Completed Date:** 2025-11-17
  ```

---

## Rollback Plan

**If migration fails or causes critical issues:**

### Rollback Steps

- [ ] **Check if migration branch was created**
  ```bash
  git branch
  ```

- [ ] **Option 1: Revert commit (if already committed)**
  ```bash
  git log --oneline | head -5  # Find the migration commit
  git revert <commit-hash>
  ```

- [ ] **Option 2: Reset to pre-migration state (if on migration branch)**
  ```bash
  git checkout main  # or master
  git branch -D migration/drupal-naming-convention
  ```

- [ ] **Option 3: Hard reset to backup commit**
  ```bash
  git log --oneline | head -10  # Find "Pre-migration backup" commit
  git reset --hard <backup-commit-hash>
  ```

- [ ] **Rebuild site after rollback**
  ```bash
  bundle exec jekyll clean
  bundle exec jekyll build
  ```

---

## Post-Migration Tasks

- [ ] **Merge migration branch to main** (if using branch)
  ```bash
  git checkout main
  git merge migration/drupal-naming-convention
  ```

- [ ] **Push to remote repository**
  ```bash
  git push origin main
  ```

- [ ] **Monitor GitHub Actions/Pages build** (if auto-deploy)
  - [ ] Build succeeds
  - [ ] Site deploys successfully
  - [ ] Live site renders correctly

- [ ] **Update project documentation**
  - [ ] Team members notified of new naming convention
  - [ ] Developer guide updated
  - [ ] Contribution guidelines updated

- [ ] **Archive TODO items**
  - [ ] Move TODO-1534 to COMPLETED/
  - [ ] Move TODO-1535 to COMPLETED/
  - [ ] Create summary document

---

## Success Metrics

**Migration is successful when:**

✅ All layout files follow `page.html` / `node--*.html` pattern
✅ All includes follow `block--*.html` pattern
✅ Homepage uses `page--front.html` wrapper
✅ All content files updated with new layout references
✅ Build completes without errors or warnings
✅ All page types render correctly (homepage, blog, products)
✅ All blocks render correctly
✅ Schema.org markup intact and valid
✅ No broken links or missing includes
✅ Three-tier hierarchy works: page > node > block
✅ Documentation updated
✅ Migration committed to git
✅ Live site deploys successfully (if applicable)

---

**Created by:** Claude Code
**Execution Date:** TBD
**Estimated Time:** 8-12 hours
**Status:** Not Started → Ready for Execution

**Dependencies Met:**
- ✅ TODO-1534 planning completed
- ✅ Drupal naming convention understood
- ✅ File mappings documented
- ✅ Migration strategy defined

**Ready to execute when user confirms approval.**

# TODO-1530: Refactor CSS Architecture - Migrate to SCSS Partials

**Priority:** Medium
**Status:** Pending
**Created:** 2025-11-16
**Assignee:** Dev Team
**Category:** Frontend / CSS Architecture

---

## 📋 Overview

Migrate inline styles and `<style>` blocks from HTML template files to modular SCSS partial files for better maintainability, performance, and developer experience.

---

## 🎯 Objectives

1. **Remove all inline styles** from `_includes/*.html` files
2. **Extract `<style>` blocks** to dedicated SCSS partials
3. **Create modular SCSS component structure**
4. **Improve CSS organization** with variables, mixins, and utilities
5. **Better performance** through single compiled CSS file

---

## 📊 Current Problems

### Inline Styles Found:
```
_includes/product-list.html              - 1 inline style
_includes/related-articles.html          - 4 inline styles
_includes/related-content-by-node-id.html - 5 inline styles
_includes/related-products-by-last-modified.html - 4 inline styles
_includes/related-products-by-node-id.html - 4 inline styles
```

### Issues:
- ❌ **CSS Duplication**: `<style>` blocks rendered on every page using include
- ❌ **No Browser Caching**: Inline styles can't be cached
- ❌ **Hard to Maintain**: CSS scattered across multiple HTML files
- ❌ **No SCSS Features**: Can't use variables, mixins, nesting
- ❌ **Larger HTML Files**: Duplicate CSS increases page size
- ❌ **Poor Separation of Concerns**: Mixing structure with presentation

---

## ✅ Proposed Solution: SCSS Partials Architecture

### New Directory Structure:

```
assets/css/
├── main.scss                      # Main import file (entry point)
├── _variables.scss               # SCSS variables, CSS custom properties
├── _base.scss                    # Base styles (body, typography, resets)
├── _utilities.scss               # Utility classes (spacing, colors, etc)
└── components/
    ├── _related-articles.scss    # Styles for related-articles.html
    ├── _related-products.scss    # Styles for related-products templates
    ├── _related-content.scss     # Styles for related-content-by-node-id.html
    ├── _product-card.scss        # Product card component styles
    ├── _product-list.scss        # Product list/table styles
    ├── _blog-card.scss           # Blog card component styles
    ├── _hero.scss                # Hero section styles
    └── _navbar.scss              # Navigation styles
```

### Main.scss Structure:

```scss
---
---

/* ==========================================================================
   Kayu Dolken Gelam - Main Stylesheet
   ========================================================================== */

// 1. Configuration & Variables
@import 'variables';

// 2. Base Styles
@import 'base';

// 3. Utility Classes
@import 'utilities';

// 4. Component Styles
@import 'components/navbar';
@import 'components/hero';
@import 'components/product-card';
@import 'components/product-list';
@import 'components/blog-card';
@import 'components/related-articles';
@import 'components/related-products';
@import 'components/related-content';
```

---

## 🔧 Implementation Steps

### Phase 1: Setup Structure (30 min) ✅
- [x] Create `assets/css/components/` directory
- [x] Create `_variables.scss` file
- [x] Create `_utilities.scss` file
- [x] Update `main.scss` with import statements

### Phase 2: Extract Variables (15 min)
- [ ] Move color definitions to variables
- [ ] Create utility class variables (heights, font-sizes, spacing)
- [ ] Define common values (border-radius, transitions, shadows)

**Example `_variables.scss`:**
```scss
// Colors
$wood-brown: #8B4513;
$wood-light: #D2691E;
$wood-dark: #654321;
$wood-lightest: #DEB887;

// Component-specific
$card-image-height: 200px;
$card-image-height-sm: 180px;
$icon-size-sm: 3rem;
$icon-size-md: 4rem;
$icon-size-lg: 8rem;

// Font sizes
$font-size-xs: 0.75rem;   // 12px
$font-size-sm: 0.875rem;  // 14px
$font-size-base: 1rem;    // 16px
$font-size-lg: 1.1rem;    // ~18px

// Transitions
$transition-default: all 0.3s ease;
$transition-transform: transform 0.3s ease;
```

### Phase 3: Extract Inline Styles (45 min) ✅

#### A. Related Articles Component
**File:** `_includes/related-articles.html`

**Current Inline Styles:**
```html
<div class="card-img-top bg-gradient-wood d-flex align-items-center justify-content-center" style="height: 180px;">
<i class="bi bi-file-text text-white" style="font-size: 3rem;"></i>
<div class="mb-2 d-flex align-items-center flex-wrap gap-2" style="font-size: 0.75rem;">
```

**Actions:**
- [x] Create `assets/css/components/_related-articles.scss`
- [x] Extract `.related-articles .card-img-top { height: 180px; }`
- [x] Extract `.related-articles .bi-file-text { font-size: 3rem; }`
- [x] Extract `.related-articles .engagement-metrics { font-size: 0.75rem; }`
- [ ] Remove inline `style=""` attributes (pending Phase 5)
- [ ] Remove `<style>` block at bottom of file (pending Phase 5)

**New SCSS (_related-articles.scss):**
```scss
// Related Articles Component
.related-articles {
  .card-img-top {
    height: $card-image-height-sm; // 180px

    &.bg-gradient-wood {
      display: flex;
      align-items: center;
      justify-content: center;
    }
  }

  .bi-file-text {
    font-size: $icon-size-sm; // 3rem
  }

  .engagement-metrics {
    font-size: $font-size-xs; // 0.75rem
    margin-bottom: 0.5rem;
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    gap: 0.5rem;
  }

  // Hover effects
  .hover-lift {
    transition: $transition-transform;

    &:hover {
      transform: translateY(-5px);
      box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
    }
  }

  .bg-gradient-wood {
    background: linear-gradient(135deg, #8B4513 0%, #D2691E 100%);
  }
}
```

**Updated HTML:**
```html
<div class="card-img-top bg-gradient-wood">
  <i class="bi bi-file-text text-white"></i>
</div>
<div class="engagement-metrics">
  <!-- content -->
</div>
```

#### B. Related Products Components
**Files:**
- `_includes/related-products-by-node-id.html`
- `_includes/related-products-by-last-modified.html`

**Current Inline Styles:**
```html
<img style="height: 200px; object-fit: cover;">
<div class="card-img-top bg-wood-gradient d-flex align-items-center justify-content-center" style="height: 200px;">
<i class="bi bi-tree text-white" style="font-size: 3rem;"></i>
<div class="mb-2 d-flex align-items-center" style="font-size: 0.875rem;">
```

**Actions:**
- [x] Create `assets/css/components/_related-products.scss`
- [x] Extract image heights, icon sizes, font sizes
- [ ] Remove inline styles from both files (pending Phase 5)
- [ ] Remove `<style>` blocks (pending Phase 5)

**New SCSS (_related-products.scss):**
```scss
// Related Products Component
.related-products-section {
  .card-img-top {
    height: $card-image-height; // 200px
    object-fit: cover;

    &.bg-wood-gradient {
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #8B4513 0%, #A0522D 50%, #CD853F 100%);
    }
  }

  .bi-tree {
    font-size: $icon-size-sm; // 3rem
  }

  .rating-display {
    font-size: $font-size-sm; // 0.875rem
    margin-bottom: 0.5rem;
    display: flex;
    align-items: center;
  }

  // Product card hover effects
  .product-card,
  .product-card-fresh {
    transition: $transition-default;

    &:hover {
      transform: translateY(-8px);
      box-shadow: 0 0.75rem 1.5rem rgba(139, 69, 19, 0.15) !important;

      .card-img-top {
        transform: scale(1.05);
      }
    }

    .card-img-top {
      transition: $transition-transform;
    }
  }

  // Different hover color for fresh strategy
  .product-card-fresh:hover {
    box-shadow: 0 0.75rem 1.5rem rgba(40, 167, 69, 0.15) !important;
  }

  .bg-wood-gradient {
    background: linear-gradient(135deg, #8B4513 0%, #A0522D 50%, #CD853F 100%);
  }
}
```

#### C. Related Content Component
**File:** `_includes/related-content-by-node-id.html`

**Actions:**
- [x] Create `assets/css/components/_related-content.scss`
- [x] Extract image heights, icon sizes, font sizes
- [ ] Remove inline styles (pending Phase 5)
- [ ] Remove `<style>` block (pending Phase 5)

**New SCSS (_related-content.scss):**
```scss
// Related Content Component
.related-content-section {
  .card-img-top {
    height: $card-image-height; // 200px
    object-fit: cover;

    &.bg-wood-gradient {
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #8B4513 0%, #A0522D 50%, #CD853F 100%);
    }
  }

  .bi-file-text {
    font-size: $icon-size-sm; // 3rem
    opacity: 0.75;
  }

  .engagement-metrics {
    font-size: $font-size-xs; // 0.75rem
    margin-bottom: 0.5rem;
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    gap: 0.5rem;
  }

  // Card hover effects
  .related-content-card {
    transition: $transition-default;
    position: relative;

    &:hover {
      transform: translateY(-8px);
      box-shadow: 0 0.75rem 1.5rem rgba(139, 69, 19, 0.15) !important;

      .card-img-top {
        transform: scale(1.05);
      }
    }

    .card-img-top {
      transition: $transition-transform;
    }

    .card-body {
      z-index: 2;
    }
  }

  .bg-wood-gradient {
    background: linear-gradient(135deg, #8B4513 0%, #A0522D 50%, #CD853F 100%);
  }

  .bg-wood-light {
    background-color: #F5DEB3 !important;
  }
}
```

#### D. Product List Component
**File:** `_includes/product-list.html`

**Current Inline Style:**
```html
<div class="card border-0 shadow-sm mb-3{% if product.popular %} border-warning{% endif %}"{% if product.popular %} style="border-width: 2px !important;"{% endif %}>
```

**Actions:**
- [x] Create `assets/css/components/_product-list.scss`
- [x] Extract popular product border styling
- [ ] Remove inline style attribute (pending Phase 5)

**New SCSS (_product-list.scss):**
```scss
// Product List Component
.product-list {
  // Mobile card view
  .card {
    &.border-warning {
      border-width: 2px !important;
    }
  }

  // Desktop table view
  .table-warning {
    background-color: rgba(255, 193, 7, 0.1);
  }
}
```

### Phase 4: Create Utility Classes (30 min) ✅

**File:** `assets/css/_utilities.scss`

```scss
// Utility Classes

// Image Heights
.img-height-180 {
  height: 180px;
}

.img-height-200 {
  height: 200px;
}

.img-height-250 {
  height: 250px;
}

// Object Fit
.object-fit-cover {
  object-fit: cover;
}

// Icon Sizes
.icon-sm {
  font-size: 3rem;
}

.icon-md {
  font-size: 4rem;
}

.icon-lg {
  font-size: 8rem;
}

// Font Sizes
.text-xs {
  font-size: 0.75rem;
}

.text-sm {
  font-size: 0.875rem;
}

// Display Flex Utilities
.d-flex-center {
  display: flex;
  align-items: center;
  justify-content: center;
}

.d-flex-align-center {
  display: flex;
  align-items: center;
}

// Gradients
.bg-gradient-wood {
  background: linear-gradient(135deg, #8B4513 0%, #D2691E 100%);
}

.bg-wood-gradient {
  background: linear-gradient(135deg, #8B4513 0%, #A0522D 50%, #CD853F 100%);
}
```

### Phase 5: Update HTML Templates (60 min)

#### Updated Template Examples:

**Before (related-articles.html):**
```html
<div class="card-img-top bg-gradient-wood d-flex align-items-center justify-content-center" style="height: 180px;">
  <i class="bi bi-file-text text-white" style="font-size: 3rem;"></i>
</div>
```

**After:**
```html
<div class="card-img-top bg-gradient-wood">
  <i class="bi bi-file-text text-white"></i>
</div>
```

**Before (related-products-by-node-id.html):**
```html
<img src="..." style="height: 200px; object-fit: cover;">
<div class="mb-2 d-flex align-items-center" style="font-size: 0.875rem;">
```

**After:**
```html
<img src="..." class="card-img-top">
<div class="mb-2 rating-display">
```

**Before (product-list.html):**
```html
<div class="card border-0 shadow-sm mb-3{% if product.popular %} border-warning{% endif %}"{% if product.popular %} style="border-width: 2px !important;"{% endif %}>
```

**After:**
```html
<div class="card border-0 shadow-sm mb-3{% if product.popular %} border-warning{% endif %}">
```

### Phase 6: Testing & Validation (30 min)

- [ ] Run `bundle exec jekyll build` - verify no errors
- [ ] Check compiled CSS file size
- [ ] Visual regression testing on:
  - [ ] Homepage
  - [ ] Product pages
  - [ ] Blog pages
  - [ ] Product listing page
- [ ] Test responsive breakpoints (mobile, tablet, desktop)
- [ ] Verify browser caching (check Network tab)
- [ ] Test all hover effects still work
- [ ] Verify all colors/gradients unchanged

---

## 📈 Expected Benefits

### Performance Improvements:
- ✅ **Smaller HTML Files**: No duplicate `<style>` blocks
- ✅ **Better Caching**: CSS compiled to single cacheable file
- ✅ **Faster Page Loads**: Browser caches CSS across pages
- ✅ **Reduced Requests**: 1 CSS file vs inline styles per page

### Developer Experience:
- ✅ **Modular Architecture**: Each component has dedicated SCSS file
- ✅ **SCSS Features**: Variables, mixins, nesting, functions
- ✅ **Easier Maintenance**: Change once, apply everywhere
- ✅ **Version Control**: Track CSS changes separately from HTML
- ✅ **Better Organization**: Clear separation of concerns

### Code Quality:
- ✅ **DRY Principle**: No CSS duplication
- ✅ **Consistency**: Shared variables ensure consistent styling
- ✅ **Reusability**: Utility classes & mixins
- ✅ **Scalability**: Easy to add new components

---

## 📊 Metrics & Success Criteria

### Before Migration:
- Total inline `style=""` attributes: **18+**
- `<style>` blocks in includes: **5 files**
- CSS duplication: **High** (every page renders component styles)
- CSS compilation: **Single main.scss** (468 lines)

### After Migration:
- Inline styles: **0**
- `<style>` blocks in includes: **0**
- CSS files: **1 compiled main.css** (all partials imported)
- Component SCSS partials: **~8 files**
- Utility classes created: **15+**

### Success Criteria:
- ✅ Zero inline `style=""` attributes in `_includes/*.html`
- ✅ Zero `<style>` blocks in template files
- ✅ All visual styling preserved (no regressions)
- ✅ Build completes without errors
- ✅ CSS file size < 50KB (gzipped)
- ✅ All pages render correctly on mobile/desktop

---

## 🔗 Related Files

### Files to Modify:
```
_includes/related-articles.html
_includes/related-content-by-node-id.html
_includes/related-products-by-last-modified.html
_includes/related-products-by-node-id.html
_includes/product-list.html
```

### Files to Create:
```
assets/css/_variables.scss
assets/css/_utilities.scss
assets/css/components/_related-articles.scss
assets/css/components/_related-products.scss
assets/css/components/_related-content.scss
assets/css/components/_product-list.scss
```

### Files to Update:
```
assets/css/main.scss
```

---

## ⏱️ Estimated Timeline

| Phase | Task | Duration | Complexity |
|-------|------|----------|------------|
| 1 | Setup directory structure | 30 min | Low |
| 2 | Extract variables | 15 min | Low |
| 3 | Extract component styles | 45 min | Medium |
| 4 | Create utility classes | 30 min | Low |
| 5 | Update HTML templates | 60 min | Medium |
| 6 | Testing & validation | 30 min | Medium |
| **Total** | | **3.5 hours** | **Medium** |

---

## 🚨 Risk Assessment

### Potential Risks:

1. **Visual Regressions**
   - **Risk:** Styles not applied correctly after migration
   - **Mitigation:** Visual testing on all pages before deploy
   - **Impact:** Medium

2. **SCSS Compilation Errors**
   - **Risk:** Syntax errors in SCSS files
   - **Mitigation:** Test build after each partial creation
   - **Impact:** Low

3. **Selector Specificity Issues**
   - **Risk:** CSS selectors don't match after refactor
   - **Mitigation:** Use same class names, test thoroughly
   - **Impact:** Low

4. **Browser Caching Issues**
   - **Risk:** Users see old styles due to cache
   - **Mitigation:** Update CSS file version/hash
   - **Impact:** Low

---

## 📝 Implementation Notes

### Best Practices:

1. **Component Naming**: Use BEM methodology for new classes
   ```scss
   .related-products {
     &__card { }
     &__image { }
     &__title { }
   }
   ```

2. **Variable Naming**: Use semantic names
   ```scss
   $card-image-height: 200px;  // Good
   $height-200: 200px;         // Bad
   ```

3. **File Organization**: One component per file
   ```scss
   components/
     _related-articles.scss   // Only related-articles styles
     _related-products.scss   // Only related-products styles
   ```

4. **Comments**: Document complex styles
   ```scss
   // Gradient background for placeholder images
   // Used when product has no image uploaded
   .bg-wood-gradient {
     background: linear-gradient(...);
   }
   ```

---

## ✅ Checklist

### Pre-Implementation:
- [ ] Read and understand this TODO document
- [ ] Backup current working site
- [ ] Create feature branch: `git checkout -b feature/scss-architecture`
- [ ] Test current build works: `./rebuild.sh`

### During Implementation:
- [ ] Create directory structure
- [ ] Extract variables to `_variables.scss`
- [ ] Create component partials one by one
- [ ] Update `main.scss` with imports
- [ ] Remove inline styles from templates
- [ ] Remove `<style>` blocks from templates
- [ ] Create utility classes
- [ ] Test build after each major change

### Post-Implementation:
- [ ] Final build test
- [ ] Visual regression testing
- [ ] Check CSS file size
- [ ] Validate HTML structure unchanged
- [ ] Test on multiple browsers
- [ ] Test on mobile/tablet/desktop
- [ ] Git commit with descriptive message
- [ ] Update this TODO with completion date
- [ ] Document any deviations from plan

---

## 📚 References

- [Sass Documentation](https://sass-lang.com/documentation)
- [Jekyll Sass/SCSS](https://jekyllrb.com/docs/assets/#sassscss)
- [BEM Methodology](http://getbem.com/)
- [CSS Architecture Best Practices](https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Organizing)

---

## 🎯 Completion Criteria

This TODO is considered **COMPLETE** when:

1. ✅ All inline `style=""` attributes removed from includes
2. ✅ All `<style>` blocks removed from template files
3. ✅ SCSS partials created for all components
4. ✅ Variables and utilities properly organized
5. ✅ Build succeeds without errors
6. ✅ Visual testing passes on all pages
7. ✅ CSS file size optimized
8. ✅ Code committed and deployed

---

**Last Updated:** 2025-11-16
**Version:** 1.0

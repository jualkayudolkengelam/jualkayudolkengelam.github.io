# Release Notes - v1.0.3

**Release Date:** 20 November 2025
**Author:** 4ndrisw
**Period:** 19 November 2025 - 20 November 2025

---

## 📋 Summary

Major updates focusing on content expansion, product page refactoring, and architectural improvements. This release includes new city-specific articles (Bandung, Karawang, Terdekat), product recommendation format standardization, and significant CSS/layout enhancements.

**Total Commits:** 50+
**Files Changed:** 100+
**Lines Added:** ~4,500
**Lines Removed:** ~500

---

## 🎯 Highlights

- ✨ Added 3 new city-specific articles (Bandung, Karawang, Jawa-Bali region)
- 🔄 Standardized product recommendation format across all products
- 🏗️ Implemented instruction-based template system for better content management
- 🎨 Enhanced CSS utilities and layout improvements
- 📦 Converted multiple blog articles to block-based architecture
- 🖼️ Added WebP image optimization for new articles

---

## 📦 New Features

### Content Additions
- **New Article:** Jual Kayu Dolken Bandung with complete frontmatter structure
- **New Article:** Jual Kayu Dolken Karawang with KIIC/industry focus
- **New Article:** Jual Kayu Dolken Terdekat with Jawa-Bali regional coverage
- **WebP Images:** Added optimized WebP images for Bandung and Karawang articles

### Template System
- **Instruction-Based Template:** New flexible content structure for city articles
- **Documentation:** Added DOCS--post-with-product-guide.md
- **README:** Added README--post-with-product.md
- **Template File:** TEMPLATE--post-with-product.md for consistent article creation
- **Validation:** Added validate-post.sh script for frontmatter validation
- **Checklist:** Added checklist-post.md for content creation workflow

### Block Components
- **Hero Block:** block--hero-jual-kayu-dolken-terdekat.html for regional articles
- Enhanced block--tentang-kota-kami.html with better formatting
- Improved block--area-pengiriman-kayu-dolken.html structure

---

## 🔄 Refactoring & Improvements

### Product Pages
- **Standardized Rekomendasi Format:**
  - Converted kayu-dolken-8-10cm.md from array to single object format
  - Converted kayu-dolken-10-12cm.md from array to single object format
  - Removed {% for %} loop complexity, now uses simple {% include %}
  - Merged multiple rekomendasi sections into unified structure
  - Eliminated duplicate "Rekomendasi Penggunaan" heading issue
  - **Result:** 2 files, +45/-60 lines (cleaner code)

### CSS & Styling
- **Utilities Enhancement:**
  - Added 52+ new utility classes in _utilities.scss
  - Fixed oval circle icons to perfect round circles
  - Added badge utilities and icon containers
  - Improved contrast and alignment across components
- **Layout Improvements:**
  - Improved tentang-kota layout with CSS classes
  - Enhanced block-level formatting for better readability
  - Removed inline styles in favor of utility classes

### Blog Architecture
- **Block-Based Conversion:**
  - Converted Jakarta Utara article to block architecture
  - Converted hitung-kebutuhan article to block architecture with frontmatter
  - Converted maintenance article to block-based architecture (wider layout)
  - Converted perbedaan-kayu-gelam article to block-based architecture
  - Reorganized post blocks by article type
- **Testimonial Improvements:**
  - Standardized testimonial format for Jakarta Utara
  - Balanced project cards and testimonials across all city pages
  - Moved testimonial quote decoration styles to CSS utilities
  - Reduced quote icon size from 10rem to 4rem

### Code Quality
- **Extracted Inline Code:**
  - Extracted inline carousel script to reusable external JS file
  - Extracted WhatsApp button styles to separate SCSS file
  - Replaced inline styles with utility classes in root HTML files
  - Moved carousel JS to external file for better maintainability
- **Component Refactoring:**
  - Moved kesimpulan block to shared-block for reusability
  - Moved related products section from layout to content
  - Extracted hero section to reusable block component

---

## 🐛 Bug Fixes

- **Icons:** Fixed oval circle icons to perfect round circles
- **Testimonials:** Standardized testimonial format for Jakarta Utara
- **Layout:** Fixed card layout from 4 columns to 2 columns for better mobile display
- **Translation:** Translated English headings and labels to Indonesian in maintenance article
- **Translation:** Translated English content to Indonesian in maintenance front matter
- **Contrast:** Improved alignment, contrast, and removed problematic inline styles

---

## 📝 Content Updates

### City Articles
- **Jakarta Utara:** Updated with standardized testimonial format and balanced content
- **Semarang:** Enhanced with balanced project cards and testimonials
- **Bandung:** New comprehensive article with Jawa Barat regional focus
- **Karawang:** New industrial-focused article with KIIC/Surya Cipta coverage
- **Terdekat:** New multi-region article covering entire Jawa-Bali area

### Template Improvements
- Updated TEMPLATE--post-with-product.md with latest structure
- Added frontmatter customization capabilities
- Improved content flexibility and reusability

---

## 🏗️ Architecture Changes

### Template System
- Implemented instruction-based template with flexible content structure
- Added validation and documentation for consistent content creation
- Created standardized workflow with checklist

### Block Architecture
- Converted multiple articles to component-based structure
- Improved separation of concerns (layout vs content)
- Enhanced reusability across different article types

### Product Pages
- Simplified rekomendasi rendering logic
- Eliminated complex array loops in favor of object-based approach
- Improved maintainability and consistency

---

## 📊 Statistics

### Commits by Hour (20 Nov 2025)
- 2 hours ago: Product format standardization
- 3 hours ago: Terdekat article adoption
- 4-6 hours ago: Layout improvements and new city articles
- 11-13 hours ago: Template system implementation
- 16-17 hours ago: Blog architecture conversion

### File Changes by Category
- **Content:** 15+ article files (new + updated)
- **Templates:** 5 new template/doc files
- **Blocks:** 10+ block components updated
- **Styles:** 2 major CSS files enhanced
- **Scripts:** 2 new validation/utility scripts
- **Images:** 15+ WebP/JPEG images added

### Code Metrics
- **Largest Addition:** +2,078 lines (Template system implementation)
- **Largest Refactor:** +794/-182 lines (Terdekat article adoption)
- **Most Files Changed:** 15 files (Bandung & Karawang addition)
- **Total Deletions:** ~500 lines (cleanup and optimization)

---

## 🔗 Related Releases

- [v1.0.2](RELEASE/RELEASE_NOTES-v1.0.2.md) - 19 November 2025
- [v1.0.1](RELEASE/RELEASE_NOTES-v1.0.1.md) - Previous release

---

## 🚀 Migration Guide

### For Product Pages
If you have custom product pages using array-based rekomendasi:

**Before:**
```yaml
rekomendasi:
  - tipe: "penggunaan"
    judul: "Title 1"
    sections: [...]
  - tipe: "why_popular"
    judul: "Title 2"
    sections: [...]
```

**After:**
```yaml
rekomendasi:
  tipe: "penggunaan"
  sections:
    - heading: "Section 1"
      deskripsi: "..."
    - heading: "Section 2"
      items: [...]
```

**Template Change:**
```liquid
<!-- Before -->
{% for rekomendasi_item in page.rekomendasi %}
  {% include products/block--product-rekomendasi.html %}
{% endfor %}

<!-- After -->
<section id="product-rekomendasi">
  {% include products/block--product-rekomendasi.html %}
</section>
```

### For City Articles
Use the new TEMPLATE--post-with-product.md as base for new articles. Follow DOCS--post-with-product-guide.md for detailed instructions.

---

## 📞 Support

For questions or issues related to this release:
- Check DOCS--post-with-product-guide.md for template usage
- Review checklist-post.md for content creation workflow
- Run validate-post.sh to validate frontmatter structure

---

**Generated:** 20 November 2025 08:30 WIB
**Repository:** jualkayudolkengelam.net
**Branch:** main

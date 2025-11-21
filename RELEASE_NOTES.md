# Release Notes - v1.0.4

**Release Date:** November 21, 2025
**Period Covered:** November 20, 2024 06:38 - November 21, 2025

---

## 🎯 Major Features

### Tutorial Block System
- **Complete Tutorial Architecture** (c5a1d96, be84ee4, 24e4a38, a3e1072, b9b1b89, 0f9bcd4, de5dea4)
  - Implemented comprehensive tutorial block components with interactive elements
  - Added 6 tutorial blocks: intro, cara-menghitung calculator, panduan-pemilihan, mengenal-ukuran, cara-pemasangan, tips-praktis, cara-merawat
  - Organized tutorial blocks in dedicated subdirectory structure
  - Integrated interactive calculator widget for kebutuhan kayu dolken

- **Tutorial Template System** (ae6d10e, 4a62f5a)
  - Created `TEMPLATE--post-tutorial.md` for standardized tutorial content creation
  - Centralized template management in organized structure

### Block Architecture Enhancements
- **Inspirasi Block Organization** (6170101, 7105ef2)
  - Moved inspirasi block components to dedicated subfolder structure
  - Fixed include paths for proper block loading
  - Improved code organization and reusability

- **Centralized Block Registry** (d99699d)
  - Added `BLOCK-COLLECTION.yml` for centralized block management
  - Updated templates to use centralized block registry
  - Streamlined block inclusion across content

### Multi-Purpose Content System
- **AI Workflow Templates** (caac2e8, 95156ad)
  - Added comprehensive frontmatter template with critical warnings
  - Implemented AI workflow template for multi-purpose content generation
  - Standardized content creation process

### Content Block Refactoring
- **Aplikasi Article Blocks** (9a2bf92, 4254a89, ecd4c93)
  - Created 4 reusable block components for aplikasi articles
  - Renamed block--aplikasi-use-case.html to block--aplikasi-hotel.html
  - Added complete YAML structure template in block headers
  - Implemented semantic class naming pattern

- **Block-Based Architecture Conversion** (6c3b52a, 1b64c6e, fc0d41b)
  - Converted multiple articles to block-based architecture:
    - perbedaan-kayu-gelam article
    - maintenance article (cara-merawat)
    - Jakarta Utara city article
    - hitung-kebutuhan calculator article
  - Moved testimonial quote decoration to CSS utilities
  - Reorganized post blocks by article type

---

## 🎨 UI/UX Improvements

### Design System
- **Tips Desain Block** (71e58b5, 3e153dd, 04c021d)
  - Converted Tips Desain section to reusable block component
  - Added comprehensive heading hierarchy (h3-h6)
  - Balanced layout with 6th design tip card

- **Icon & Badge Redesign** (8bb4ac5, 2347b52)
  - Replaced circular elements with cleaner badge and icon design
  - Fixed oval circle icons to perfect round circles
  - Improved icon-text alignment in tips-desain block (9d3de91)

- **Card Layout Optimization** (3e80c30, 27349ac)
  - Moved card identifier classes from column wrapper to card element
  - Fixed separator breaking card layout in Keunggulan section

### Heading Hierarchy
- **Complete H3-H6 Structure** (c7f8993, 086b331, c70404d, 3e153dd)
  - Added comprehensive heading hierarchy to all block components
  - Implemented 2 required paragraphs between H2 and H3 sections
  - Added required content hierarchy to all cards

- **Semantic Section IDs** (cfb9520)
  - Added semantic section IDs to all h2 headings for better navigation
  - Improved document structure and accessibility

---

## 🏗️ Architecture & Code Quality

### Drupal-Style Architecture
- **Three-Tier Naming Convention** (eadf2f6, 80fb184)
  - Migrated to Drupal naming convention for layouts and blocks
  - Implemented page wrapper, layout, and block component structure
  - Added comprehensive documentation headers to all layout files (022a3ad)

### Schema.org Structured Data
- **Component-Level Schema** (e2401fb, 5f571bc, fdb08bf)
  - Implemented component-level schema architecture
  - Added component schema for product pages
  - Added optional Product schema fields to components

- **Schema Enhancements** (51fd9fd, 6e12087, a1b1c2d)
  - Added dynamic FAQ block with Schema.org structured data
  - Implemented contact and why-choose-us dynamic blocks
  - Added ItemList schemas to related content components (6633fbd, 7637002, ee2256a, 5c62261)

- **Image & Gallery Schema** (f1916ee, 0150b30, 3949e9d)
  - Added ImageGallery schema with representativeOfPage
  - Implemented @id for entity separation
  - Added image carousel component with proper schema

### CSS Architecture Refactoring
- **SCSS Partials System** (c3bc086, 0e54c00, 7a9f5d4, d130894)
  - Phase 1-5 complete: Setup SCSS partials architecture
  - Extracted component styles to SCSS partials
  - Removed inline styles from related templates
  - Completed inline style removal across all components

- **WhatsApp Button Component** (c126733)
  - Extracted WhatsApp button styles to separate SCSS file
  - Improved component modularity

### JavaScript Refactoring
- **Carousel Component** (ec4a932, a975587)
  - Extracted inline carousel script to reusable external JS file
  - Improved code maintainability and reusability

- **Calculator Widget** (95d607f)
  - Added calculator widget to homepage
  - Implemented external JS file for calculator functionality

---

## 📝 Content Management

### Template System
- **Block Templates** (4c6f03d, 05a0883)
  - Created complete tutorial template blocks
  - Added CSS selector support and section wrappers
  - Implemented sidebar widgets and responsive layout (b58d5d0)

- **Frontmatter Templates** (e2afe18, f3da978)
  - Updated template to reflect split mengapa-memilih blocks
  - Split block--mengapa-memilih into two separate blocks

### Content Organization
- **Kesimpulan Block** (3876efe)
  - Moved kesimpulan block to shared-block for reusability
  - Improved content component organization

- **Related Content System** (db4c85e, a1b1c2d, 2ebe833, 6e12087)
  - Converted sections to reusable block components with dynamic content
  - Added dynamic block for size selection tips
  - Implemented three dynamic block components for multi-city content

---

## 🔧 Bug Fixes

### Layout & Display
- **Card Layout Fixes** (4d61ae3, fdf62a4)
  - Changed card layout from 4 columns to 2 columns for better mobile display
  - Added 4th card to age-based maintenance for balanced layout

- **Testimonial Format** (283c7ae, 6dbdb35)
  - Standardized testimonial format for Jakarta Utara
  - Balanced project cards and testimonials across all city pages

### Content & Localization
- **Indonesian Translation** (79c224d, 1b7f3b4)
  - Translated English headings and labels to Indonesian in maintenance article
  - Fixed English content in maintenance article frontmatter

### Schema Validation
- **Product Schema Fixes** (8bbcdae, 4c2a535, f9c4a57)
  - Added required fields to Product snippets to fix validation errors
  - Used minimal Product reference schema to avoid duplicates
  - Changed related products from ItemList to individual Product schemas

---

## 🚀 Automation & Workflows

### GitHub Actions
- **Metrics Automation** (e3fa0ee, 90a6c8e, c250060)
  - Added weekly engagement metrics update workflow (TODO-1528)
  - Implemented product metrics cronjob (TODO-1529)
  - Fixed workflow permissions for automated commits (2efefc0)

### Content Updates
- **Last Modified Tracking** (3e1b2e4, 7bda784, 10eb3f5)
  - Implemented last_modified_at for dynamic related products rotation
  - Sorted blog posts by last_modified_at for fresh content priority
  - Added last_modified_at update to post-metrics workflow

---

## 📦 Assets & Media

### Image Optimization
- **WebP Implementation** (3f07600, d1f0ce1)
  - Added WebP images for Bandung & Karawang articles
  - Implemented WebP support with fallback images

### Product Images
- **Product Photo Updates** (d96165a, 4eabcb7, 1ac45b4, 1f169f4)
  - Added photos to product 10-12cm
  - Added photos to product 8-10cm
  - Added 3 photos to product 2-3cm dolken

---

## 📚 Documentation

### Technical Documentation
- **TODO System** (c9f755a, 4f46ef9, db4c85e, 9aefd60)
  - Added TODO-1537 for heading hierarchy refactor tracking
  - Created TODO-1533 component-level schema documentation
  - Added TODO-1532 schema migration per template
  - Documented modular post template system specification (TODO-1538)

### Release Management
- **Version Documentation** (aa516f1, c194273, a6c1cbb, 41fa3ce)
  - Added comprehensive file headers with versioning
  - Created CHANGELOG.md with version history
  - Added RELEASE_NOTES-v1.0.2.md to RELEASE folder
  - Completed RELEASE_NOTES.md for v1.0.3

---

## ⚡ Performance Optimization

### Core Web Vitals
- **Page Performance** (effae5d)
  - Optimized page performance for Core Web Vitals
  - Improved loading speed and user experience

### Code Organization
- **Refactoring** (e253880, c1e5f7a, 1393892)
  - Multiple refactoring phases for improved code quality
  - Enhanced maintainability and performance

---

## 🏙️ City-Specific Content

### New City Articles
- **Bandung & Karawang** (3f07600, 9ab6ebb)
  - Added Bandung & Karawang articles with WebP images
  - Adopted Karawang frontmatter to jual-kayu-dolken-terdekat with Jawa-Bali scope

### City Article Improvements
- **Jakarta Utara** (283c7ae, 0eec3c7)
  - Standardized testimonial format
  - Fixed layout and content structure

- **Tentang Kota Layout** (e41cdf9)
  - Improved tentang-kota layout with CSS classes
  - Added block-level formatting

---

## 🔍 SEO Improvements

### Structured Data
- **Navigation Schema** (afd4e6e, 3c6b179)
  - Moved navigation schema from navigation block to header
  - Added navigation component with proper schema

### Breadcrumb Navigation
- **Site-Wide Breadcrumbs** (1c711d2, ba4e43b)
  - Added breadcrumb navigation and container wrapper to all pages
  - Refactored breadcrumb implementation for consistency

---

## 📱 Responsive Design

### Mobile Optimization
- **Calculator Improvements** (046b277, a77c72d, 490ac66)
  - Fixed calculator formula for meter-to-meter calculation
  - Added rounded result display
  - Corrected calculator field names to match template schema

### Layout Enhancements
- **DevTools Support** (b58d5d0)
  - Added DevTools identifiers for easier debugging
  - Implemented responsive layout patterns

---

## 🎯 Business Features

### Trust Building
- **Social Proof Elements** (8fa7dfd, cf51096)
  - Added reusable social proof block for credibility building
  - Implemented trust badges below product carousel

### Contact Page
- **Enhanced Contact** (f0c3865)
  - Added payment methods display
  - Implemented fast response badges

---

## 🔄 Product Management

### Product Display
- **Related Products** (860ee91, 9561c0f, 7bda784)
  - Enhanced related products display with rich content
  - Excluded current product from related products display
  - Used related-products partial in product layout

### Product Status
- **Status Indicators** (5a87d78)
  - Added last_modified_at update to product metrics
  - Implemented product status display

---

## 📊 Metrics & Analytics

### Engagement Tracking
- **InteractionCounter Schema** (90810c9)
  - Implemented Schema.org InteractionCounter for engagement metrics
  - Added like counter functionality (bd4ebea, 5a2dc67)

### Rating System
- **AggregateRating** (4c5a8fa, fec9ed8)
  - Fixed AggregateRating implementation
  - Improved rating display and validation

---

## 🛠️ Technical Improvements

### Build & Deploy
- **Jekyll 4.3.0** (d216d33)
  - Added GitHub Actions workflow for Jekyll 4.3.0 deployment
  - Improved build process automation

### Schema Consolidation
- **@graph Structure** (896883c, ce19175)
  - Implemented comprehensive schema with @graph structure
  - Fixed WebPage schema detection by consolidating schemas

---

## 📋 Migration & Refactoring

### Product Recommendations
- **Rekomendasi Format** (5b98f8b)
  - Converted 8-10cm and 10-12cm products to new rekomendasi format
  - Standardized product display patterns

### Nested Block Pattern
- **Block Hierarchy** (ef310b3, b71f216)
  - Implemented nested block pattern for better code reusability
  - Fixed architecture - moved related content to page wrapper

---

## 🎨 Content Blocks

### Hotel & Cafe Application
- **Aplikasi Blocks** (c3c6531, c70404d, 712d38a)
  - Added complete YAML structure template
  - Implemented required content hierarchy for all cards
  - Completed semantic class naming for aplikasi-hotel cards

### Case Study Block
- **Case Study Component** (1731278)
  - Added comprehensive heading hierarchy to case study block
  - Improved case study presentation

---

## 🌐 Multi-City Content

### Dynamic Blocks
- **City-Specific Components** (24132bc, 058b5fc, 401002f, ce6406b, 3a24a1e)
  - Added tentang kota kami block component
  - Created relevansi kayu dolken block
  - Implemented aplikasi kayu dolken gelam block
  - Added studi kasus proyek block component
  - Created area pengiriman kayu dolken block

---

## 🔗 Related Content System

### Content Discovery
- **Related Articles** (7f89e9d, 4f62509, e7dfaa8, a75af47)
  - Implemented related content by node ID
  - Created related-content-by-node-id.html component
  - Added related content to product pages
  - Auto-updated related content display

---

## 🎓 Tutorial Content

### Tutorial Articles
- **Production Tutorials** (39a0ef6, e72209d)
  - Published "Cara Memilih Ukuran Kayu Dolken yang Tepat"
  - Published "Cara Menghitung Kebutuhan Kayu Dolken"
  - Added comprehensive tutorial structure

### Calculator Features
- **Interactive Tools** (a77c72d, 490ac66, 046b277)
  - Implemented calculator widget with proper validation
  - Fixed field naming and formula calculations
  - Added rounded result display for better UX

---

## 🐛 Notable Bug Fixes

1. **Liquid Parameter Passing** (541738a) - Corrected parameter passing for content section blocks
2. **Price Formatting** (afba65c) - Fixed price formatting to use rupiah filter
3. **Circle Icons** (2347b52) - Fixed oval circle icons to perfect round circles
4. **Schema Validation** (40eee9c, 81053f2, ce19175) - Multiple schema.org validation fixes
5. **Product Schema** (8730fab) - Enabled individual Product schema in nested block pattern
6. **Related Products** (a911891) - Removed duplicate ItemList schema from related products

---

## 📈 Version History References

- **v1.0.3** - Previous release with major schema and template improvements
- **v1.0.2** - Block architecture foundation
- **v1.0.1** - Architecture planning and documentation
- **v1.0.0** - Production ready initial release

---

## 🔮 Future Considerations

Based on recent commits, upcoming features may include:
- Further tutorial block expansions
- Enhanced multi-city content automation
- Additional interactive calculator widgets
- Extended block component library

---

**Total Commits in Period:** ~245 commits
**Contributors:** 4ndrisw (primary), github-actions[bot] (automated), jualkayudolkengelam
**Lines Changed:** Extensive refactoring across entire codebase

---

## 📝 Notes

This release represents a massive refactoring effort focused on:
1. **Modularity** - Block-based architecture for maximum reusability
2. **SEO Excellence** - Comprehensive Schema.org structured data
3. **Content Scalability** - Template system for rapid content creation
4. **Code Quality** - SCSS architecture and external JS components
5. **User Experience** - Interactive widgets and responsive design
6. **Automation** - GitHub Actions for metrics and deployment

The codebase is now significantly more maintainable, scalable, and optimized for both users and search engines.
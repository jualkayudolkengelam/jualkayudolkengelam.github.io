# Kayu Dolken Gelam - Website

Website bisnis kayu dolken gelam menggunakan Jekyll dan GitHub Pages. Dirancang khusus untuk SEO, mobile-friendly, dan conversion-oriented dengan arsitektur modular berbasis komponen.

**Current Version:** v1.0.5

## 🎯 Features

- ✅ **Modular Architecture** dengan block-based component system
- ✅ **Schema.org Structured Data** untuk SEO maksimal
- ✅ **Responsive Design** menggunakan Bootstrap 5
- ✅ **Blog System** dengan pagination dan related articles
- ✅ **Product Catalog** dengan pricing dan WhatsApp integration
- ✅ **Drupal-Style Naming** untuk layouts dan components
- ✅ **SCSS Architecture** dengan modular partials
- ✅ **Custom JavaScript Pattern** via frontmatter
- ✅ **WhatsApp Floating Button** untuk konversi maksimal
- ✅ **Sitemap.xml** otomatis untuk search engines
- ✅ **Mobile-First Design** untuk traffic WhatsApp

## 📂 Struktur File

```
.
├── _config.yml                 # Konfigurasi Jekyll utama
├── _layouts/                   # Layout templates (Drupal-style)
│   ├── page.html               # Base page layout
│   ├── page--front.html        # Homepage variant
│   ├── page--post.html         # Blog post variant
│   ├── page--product.html      # Product variant
│   ├── node--post.html         # Blog post entity
│   ├── node--post-with-city.html
│   ├── node--product.html      # Product entity
│   └── node--page.html         # Generic page entity
├── _includes/                  # Organized components
│   ├── reusable/              # 42 block components
│   │   ├── block--hero-homepage.html
│   │   ├── block--products-grid.html
│   │   ├── block--blog-preview.html
│   │   ├── block--cta-order.html
│   │   ├── block--breadcrumb.html
│   │   ├── block--contact-cards.html
│   │   ├── block--quick-contact-form.html
│   │   ├── block--product-list.html
│   │   ├── block--related-content--latest.html
│   │   ├── block--cta--whatsapp.html
│   │   └── ... (33 more blocks)
│   ├── schema/                # 21 schema components
│   │   ├── schema--front.html         # Homepage schema
│   │   ├── schema--page.html          # Generic page schema
│   │   ├── schema--global.html        # Site-wide schema
│   │   ├── schema--blog-list.html
│   │   ├── schema--blog-preview.html
│   │   ├── schema--product-list.html
│   │   ├── schema--product-page.html
│   │   ├── schema--breadcrumb.html
│   │   ├── schema--faq-contact.html
│   │   ├── schema--carousel--image.html
│   │   └── ... (12 more schemas)
│   ├── components/            # Special components
│   ├── posts/                 # Post-specific includes
│   ├── products/              # Product-specific includes
│   ├── head.html              # Meta tags, SEO
│   ├── header.html            # Navigation
│   └── footer.html
├── _posts/                    # Blog posts
│   └── YYYY-MM-DD-title.md
├── _products/                 # Product collection
│   └── product-name.md
├── assets/
│   ├── css/
│   │   ├── main.scss          # Main stylesheet
│   │   └── _partials/         # SCSS partials
│   │       ├── _variables.scss
│   │       ├── _components.scss
│   │       ├── _blocks.scss
│   │       └── ...
│   └── js/
│       ├── kalkulator-kayu-dolken.js
│       ├── contact-form.js
│       └── ...
├── index.html                 # Homepage
├── blog.html                  # Blog listing (paginated)
├── product.html               # Product catalog
├── about.html                 # About page
├── contact.html               # Contact page
├── robots.txt
├── sitemap.xml               # Auto-generated
├── Gemfile
├── CHANGELOG.md              # Version history
├── RELEASE_NOTES.md          # Detailed release notes
└── README.md
```

## 🏗️ Architecture

### Component-Based System

Website menggunakan arsitektur berbasis komponen dengan dua kategori utama:

#### 1. Reusable Blocks (42 components)
Content blocks yang dapat digunakan kembali di berbagai halaman:

**Content Blocks:**
- Blog preview, Products grid, Product list
- Features, Why choose us, Nearest location
- Hero sections (3 variants)

**Form Blocks:**
- Quick contact form, Calculator widget

**Navigation Blocks:**
- Breadcrumb, Navigation menu

**CTA Blocks:**
- CTA order, WhatsApp button

**Info Blocks:**
- Business info, Contact cards, FAQ blocks

**Dynamic Blocks:**
- Related content, Related products, Carousel image

**City-Specific Blocks:**
- Aplikasi, Area pengiriman, Cara pemesanan
- Keunggulan, Relevansi, Studi kasus, Testimoni

#### 2. Schema Components (21 schemas)
Schema.org structured data untuk SEO:

**Page Schemas:**
- About, Contact, Front (homepage)
- Product catalog, Product page
- Global site, Generic page

**Content Schemas:**
- Blog catalog, Blog list, Blog preview
- Post, Product, Product list

**Navigation Schemas:**
- Breadcrumb

**Component Schemas:**
- Carousel/Image gallery, FAQ (2 types)

**Related Content Schemas:**
- Related content, Related products

### Drupal-Style Naming Convention

Layouts menggunakan pola penamaan Drupal:
- `page.html` - Base wrapper
- `page--front.html` - Homepage variant
- `page--post.html` - Blog post variant
- `page--product.html` - Product variant
- `node--post.html` - Blog post entity
- `node--product.html` - Product entity

### Include Patterns

**Block Includes:**
```liquid
{% include reusable/block--hero-homepage.html %}
{% include reusable/block--products-grid.html %}
```

**Schema Includes:**
```liquid
{% include schema/schema--product-list.html %}
{% include schema/schema--breadcrumb.html %}
```

**Custom Schema via Frontmatter:**
```yaml
custom_schema:
  - schema/schema--front.html
  - schema/schema--product-catalog.html
```

**Custom JavaScript via Frontmatter:**
```yaml
custom_js:
  - /assets/js/kalkulator-kayu-dolken.js
  - /assets/js/contact-form.js
```

## 🚀 Local Development

### Prerequisites

- Ruby (versi 2.7 atau lebih baru)
- Bundler
- Git

### Setup

1. **Clone repository**:
   ```bash
   git clone https://github.com/jualkayudolkengelam/jualkayudolkengelam.github.io.git
   cd jualkayudolkengelam.github.io/public_html
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Jalankan development server**:
   ```bash
   bundle exec jekyll serve
   ```

4. **Akses website**:
   ```
   http://localhost:4000
   ```

### Development dengan Live Reload

```bash
bundle exec jekyll serve --livereload
```

### Build Script

Gunakan script build untuk kompilasi cepat:

```bash
./rebuild.sh
```

## 📝 Menambah Konten

### Membuat Blog Post Baru

1. **Buat file di `_posts/`** dengan format: `YYYY-MM-DD-judul-post.md`

2. **Tambahkan front matter**:
   ```yaml
   ---
   layout: node--post
   title: "Judul Post Anda"
   date: 2025-11-22 10:00:00 +0700
   categories: [Kategori]
   tags: [tag1, tag2, tag3]
   author: Admin
   description: "Ringkasan singkat artikel (150-160 karakter)..."
   image: /assets/images/blog/gambar.jpg
   images:
     - /assets/images/blog/gambar-1.jpg
     - /assets/images/blog/gambar-2.jpg
   ---
   ```

3. **Tulis konten dalam Markdown**

4. **Related articles otomatis muncul** berdasarkan tanggal publikasi

### Membuat Product Baru

1. **Buat file di `_products/`**: `nama-produk.md`

2. **Tambahkan front matter**:
   ```yaml
   ---
   layout: node--product
   title: "Kayu Dolken Gelam Diameter X-Y cm"
   price: 25000
   description: "Deskripsi produk..."
   diameter: "X-Y cm"
   panjang: "4 meter"
   image: /assets/images/products/product.jpg
   images:
     - /assets/images/products/product-1.jpg
     - /assets/images/products/product-2.jpg
   ---
   ```

### Membuat Block Component Baru

1. **Buat file di `_includes/reusable/`**: `block--nama-block.html`

2. **Tambahkan header dokumentasi**:
   ```liquid
   {% comment %}
   ============================================================================
   Block Component: Nama Block
   ============================================================================

   @file        block--nama-block.html
   @path        _includes/reusable/block--nama-block.html
   @type        Block (reusable component)
   @description Deskripsi block

   Usage:
   {% include reusable/block--nama-block.html %}
   ============================================================================
   {% endcomment %}
   ```

3. **Implementasi HTML**

### Membuat Schema Component Baru

1. **Buat file di `_includes/schema/`**: `schema--nama-schema.html`

2. **Implementasi Schema.org JSON-LD**:
   ```liquid
   <script type="application/ld+json">
   {
     "@context": "https://schema.org",
     "@type": "TypeName",
     ...
   }
   </script>
   ```

## ⚙️ Configuration

### Update Business Info

Edit `_config.yml`:
```yaml
business:
  name: "Kayu Dolken Gelam"
  phone: "+62 813-1140-0177"
  whatsapp: "6281311400177"
  email: "info@example.com"
  address: "Alamat Lengkap"
  city: "Kota Serang"
  province: "Banten"
  postal_code: "42112"
```

### Update Site Metadata

Edit `_config.yml`:
```yaml
title: "Jual Kayu Dolken Gelam"
description: "Supplier kayu dolken gelam berkualitas..."
url: "https://jualkayudolkengelam.github.io"
baseurl: ""
lang: "id"
```

### Blog Pagination

Pagination sudah dikonfigurasi di `blog.html`:
```yaml
pagination:
  enabled: true
  per_page: 9
  permalink: '/page/:num/'
```

## 🎨 Customization

### Mengubah Warna Tema

Edit `assets/css/_partials/_variables.scss`:

```scss
:root {
  --wood-brown: #8B4513;      // Main brown color
  --wood-light: #D2691E;      // Lighter brown
  --wood-dark: #654321;       // Darker brown
  --wood-lightest: #DEB887;   // Lightest brown
}
```

### Menambah Menu Navigation

Edit `_includes/reusable/block--navigation.html`:

```html
<li class="nav-item">
  <a class="nav-link" href="/path">Menu Baru</a>
</li>
```

### Custom CSS untuk Component

Tambahkan di `assets/css/_partials/_components.scss`:

```scss
.component-name {
  // Styles here
}
```

## 📊 SEO Best Practices

### Setiap Page Harus Memiliki:

- ✅ Title yang descriptive (50-60 karakter)
- ✅ Description (150-160 karakter)
- ✅ Keywords yang relevan
- ✅ Schema.org structured data
- ✅ Open Graph meta tags
- ✅ Breadcrumb navigation
- ✅ Image dengan alt text
- ✅ Internal links

### Optimasi Images

Sebelum upload, optimasi gambar:
- Resize ke ukuran yang sesuai (max 1200px)
- Compress dengan TinyPNG atau similar
- Convert ke WebP untuk better performance
- Gunakan descriptive filenames
- Tambahkan alt text yang deskriptif

### Schema.org Implementation

Website sudah dilengkapi dengan:
- **WebSite** schema (site-wide)
- **Organization** schema (business info)
- **BreadcrumbList** schema (navigation)
- **Product** schema (product pages)
- **BlogPosting** schema (blog posts)
- **FAQPage** schema (FAQ sections)
- **ItemList** schema (product/blog listings)
- **ImageGallery** schema (image carousels)

## 🚢 Deployment

### GitHub Pages

1. **Push ke GitHub**:
   ```bash
   git add .
   git commit -m "Update website"
   git push origin main
   ```

2. **Auto-deployment**:
   - GitHub Pages akan otomatis build dan deploy
   - Lihat status di Actions tab

3. **Website live di**:
   ```
   https://jualkayudolkengelam.github.io
   ```

### Custom Domain (Optional)

1. Tambahkan file `CNAME` dengan domain Anda
2. Update DNS records di domain provider
3. Enable HTTPS di GitHub Pages settings

## 🔧 Troubleshooting

### Build Errors

Jika terjadi build error:
```bash
bundle exec jekyll build --trace
```

### Clear Cache

```bash
bundle exec jekyll clean
```

### Update Dependencies

```bash
bundle update
```

## 📈 Performance

Website sudah dioptimasi dengan:
- ✅ Compressed CSS (SASS)
- ✅ CDN untuk Bootstrap & Icons
- ✅ Lazy loading images
- ✅ Minimal JavaScript
- ✅ Sitemap untuk faster indexing
- ✅ Modular component loading
- ✅ Schema.org structured data

**Build Performance:**
- Build time: ~0.8-1.1 seconds
- Generated files: 215 files (44M)
- No build errors

## 📚 Documentation

- **CHANGELOG.md** - Version history
- **RELEASE_NOTES.md** - Detailed release notes for each version
- **TODO/** - Development tasks and planning
- **RELEASE/** - Archived release notes

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📝 Version History

- **v1.0.5** (Nov 22, 2025) - Major architecture refactoring
  - Schema reorganization to `_includes/schema/`
  - Block reorganization to `_includes/reusable/`
  - File naming consistency
  - Blog pagination

- **v1.0.4** (Nov 21, 2025) - Tutorial system and block architecture
- **v1.0.3** - Schema and template improvements
- **v1.0.2** - Block architecture foundation
- **v1.0.1** - Architecture planning
- **v1.0.0** - Production ready initial release

See [RELEASE_NOTES.md](RELEASE_NOTES.md) for detailed changes.

## 📄 License

© 2024-2025 Kayu Dolken Gelam - Amirudin Abdul Karim. All rights reserved.

---

**Built with Jekyll, Bootstrap 5, and ❤️**

**Maintained with Claude Code assistance**

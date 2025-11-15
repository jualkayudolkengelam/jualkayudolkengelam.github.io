# Kayu Dolken Gelam - Website

Website bisnis kayu dolken gelam menggunakan Jekyll dan GitHub Pages. Dirancang khusus untuk SEO, mobile-friendly, dan conversion-oriented.

## Features

- ✅ **Custom Jekyll Theme** dengan tema brown/wood
- ✅ **Responsive Design** menggunakan Bootstrap 5
- ✅ **SEO Optimized** dengan meta tags, Open Graph, Schema.org
- ✅ **Blog System** dengan related articles di dalam konten
- ✅ **Product Catalog** dengan pricing dan WhatsApp integration
- ✅ **WhatsApp Floating Button** untuk konversi maksimal
- ✅ **Sitemap.xml** otomatis untuk search engines
- ✅ **Mobile-First Design** untuk traffic WhatsApp

## Struktur File

```
.
├── _config.yml                 # Konfigurasi Jekyll utama
├── _layouts/                   # Layout templates
│   ├── default.html
│   ├── page.html
│   └── post.html
├── _includes/                  # Reusable components
│   ├── head.html              # Meta tags, SEO
│   ├── header.html            # Navigation
│   ├── footer.html
│   ├── related-articles.html  # Related posts block
│   └── whatsapp-button.html   # Floating WhatsApp
├── _posts/                     # Blog posts
│   └── YYYY-MM-DD-title.md
├── assets/
│   └── css/
│       └── main.scss          # Custom styling
├── index.html                  # Homepage
├── blog.html                   # Blog listing
├── product.html                 # Product page
├── tentang.html                # About page
├── kontak.html                 # Contact page
├── robots.txt
├── Gemfile
└── README.md
```

## Local Development

### Prerequisites

- Ruby (versi 2.7 atau lebih baru)
- Bundler

### Setup

1. **Clone repository**:
   ```bash
   git clone https://github.com/jualkayudolkengelam/jualkayudolkengelam.github.io.git
   cd jualkayudolkengelam.github.io
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

## Deployment ke GitHub Pages

### Setup GitHub Pages

1. **Push ke GitHub**:
   ```bash
   git add .
   git commit -m "Initial Jekyll site setup"
   git push origin main
   ```

2. **Enable GitHub Pages**:
   - Buka repository Settings
   - Pilih "Pages" di sidebar
   - Source: Deploy from branch
   - Branch: `main` / `root`
   - Save

3. **Website akan live di**:
   ```
   https://jualkayudolkengelam.github.io
   ```

### Custom Domain (Opsional)

Jika ingin menggunakan custom domain di masa depan:

1. Tambahkan file `CNAME` di root dengan isi nama domain
2. Update DNS records di domain provider
3. Enable HTTPS di GitHub Pages settings

## Menambah Konten

### Membuat Blog Post Baru

1. Buat file di `_posts/` dengan format: `YYYY-MM-DD-judul-post.md`

2. Tambahkan front matter:
   ```yaml
   ---
   layout: post
   title: "Judul Post Anda"
   date: 2024-06-10 10:00:00 +0700
   categories: [Kategori]
   tags: [tag1, tag2, tag3]
   author: Admin
   excerpt: "Ringkasan singkat artikel..."
   image: /assets/images/blog/gambar.jpg  # Opsional
   ---
   ```

3. Tulis konten dalam Markdown

4. Related articles akan otomatis muncul di dalam konten

### Mengupdate Harga Produk

Edit file yang relevan:
- `index.html` - Homepage product section
- `product.html` - Product page

Cari dan update harga:
```html
<div class="product-price mb-3">Rp XX.000</div>
```

### Mengupdate Kontak

Edit `_config.yml`:
```yaml
business:
  phone: "+62 813-1140-0177"
  whatsapp: "6281311400177"
  location: "Kota Serang, Banten"
```

## SEO Best Practices

### Setiap Blog Post Harus Memiliki:

- ✅ Title yang descriptive (50-60 karakter)
- ✅ Excerpt/description (150-160 karakter)
- ✅ Keywords yang relevan
- ✅ Image dengan alt text (jika ada)
- ✅ Internal links ke product/pages lain
- ✅ Related articles (otomatis)

### Optimasi Images

Sebelum upload, optimasi gambar:
- Resize ke ukuran yang sesuai (max width 1200px untuk blog images)
- Compress dengan tools seperti TinyPNG
- Gunakan format WebP jika memungkinkan
- Tambahkan descriptive alt text

## Related Articles System

Related articles block sudah ter-konfigurasi untuk menampilkan:

1. **3 Latest Posts** (terbaru, excluding current post)
2. **3 Older Posts** (posts dengan tanggal lebih lama dari current post)

Total: Up to 6 related articles ditampilkan **di dalam konten** (bukan sidebar) untuk SEO value maksimal.

Tidak perlu konfigurasi manual - otomatis muncul di semua blog posts.

## Customization

### Mengubah Warna Tema

Edit `assets/css/main.scss`:

```scss
:root {
  --wood-brown: #8B4513;      // Main brown color
  --wood-light: #D2691E;      // Lighter brown
  --wood-dark: #654321;       // Darker brown
  --wood-lightest: #DEB887;   // Lightest brown
}
```

### Menambah Menu Navigation

Edit `_includes/header.html`:

```html
<li class="nav-item">
  <a class="nav-link" href="/path">Menu Baru</a>
</li>
```

## Analytics & Tracking (Opsional)

Untuk menambahkan Google Analytics:

1. Edit `_includes/head.html`
2. Tambahkan Google Analytics tracking code sebelum closing `</head>`

## Performance

Website sudah dioptimasi dengan:
- ✅ Compressed CSS (SASS)
- ✅ CDN untuk Bootstrap & Icons
- ✅ Lazy loading images
- ✅ Minimal JavaScript
- ✅ Sitemap untuk faster indexing

## Support

Untuk pertanyaan atau issue:
- Buka GitHub Issues
- Atau hubungi developer

## License

© 2024 Kayu Dolken Gelam - Amirudin Abdul Karim. All rights reserved.

---

**Dibuat dengan Jekyll & Bootstrap 5**

# TODO: Image Management Workflow

**File:** TODO-1511-image-management-workflow.md
**Date:** 2025-11-15
**Category:** Asset Management
**Status:** ✅ Completed (Test 1)

---

## Overview

Dokumentasi standar workflow untuk mengelola gambar product dan konten agar:
- SEO-friendly dengan nama file deskriptif
- Tidak ada duplicate image
- Tracking yang jelas mana foto sudah dipakai
- Struktur folder yang rapi

---

## Folder Structure

```
public_html/
├── assets/
│   └── images/
│       ├── products/                    # Gambar product
│       │   ├── jual-kayu-dolken-gelam-2-3cm-001.jpeg
│       │   ├── jual-kayu-dolken-gelam-2-3cm-002.jpeg
│       │   ├── jual-kayu-dolken-gelam-4-6cm-001.jpeg
│       │   └── ...
│       └── posts/                       # Gambar untuk blog posts
│           └── [post-title-slug]/       # Folder per artikel
│               ├── [post-title-slug]-001.jpg
│               ├── [post-title-slug]-002.jpg
│               └── [post-title-slug]-video-001.mp4
└── TODO/                                # Dokumentasi workflow
    └── TODO-1511-image-management-workflow.md
```

---

## Naming Convention

### 1. Product Images
**Format:** `jual-kayu-dolken-gelam-[ukuran]-[nomor].jpeg`

**Contoh:**
- `jual-kayu-dolken-gelam-2-3cm-001.jpeg`
- `jual-kayu-dolken-gelam-4-6cm-001.jpeg`
- `jual-kayu-dolken-gelam-8-10cm-001.jpeg`

**Keuntungan:**
- SEO-friendly (keyword "jual kayu dolken gelam" + ukuran)
- Mudah diidentifikasi
- Support multiple images per product (001, 002, 003...)

### 2. Blog Post Images
**Format:** `[post-title-slug]-[nomor].[ext]`

**Contoh:**
Post title: "Keunggulan Kayu Dolken Gelam untuk Konstruksi"
- `keunggulan-kayu-dolken-gelam-untuk-konstruksi-001.jpg`
- `keunggulan-kayu-dolken-gelam-untuk-konstruksi-002.jpg`
- `keunggulan-kayu-dolken-gelam-untuk-konstruksi-video-001.mp4`

---

## Workflow Standard

### Step 1: Rename di Source Folder
**Tujuan:** Marking file sudah dipakai, hindari duplicate

**Source Location:**
```
/home/mkt01/Documents/ANDRI/Dolken/foto/WhatsApp Unknown 2025-08-10 at 06.51.00/
```

**Command:**
```bash
cd '/home/mkt01/Documents/ANDRI/Dolken/foto/WhatsApp Unknown 2025-08-10 at 06.51.00/'
mv 'WhatsApp Image 2025-08-09 at 10.01.21.jpeg' 'jual-kayu-dolken-gelam-2-3cm-001.jpeg'
```

**Result:**
- ✅ File di source sudah renamed
- ✅ Jelas sudah dipakai untuk konten apa
- ✅ Tidak akan duplicate saat copy lagi

### Step 2: Copy to Jekyll Folder
**Destination:**
- Product images: `public_html/assets/images/products/`
- Post images: `public_html/assets/images/posts/[post-slug]/`

**Command:**
```bash
cp '/home/mkt01/Documents/ANDRI/Dolken/foto/WhatsApp Unknown 2025-08-10 at 06.51.00/jual-kayu-dolken-gelam-2-3cm-001.jpeg' \
   /home/mkt01/Public/jualkayudolkengelam.github.io/public_html/assets/images/products/
```

### Step 3: Update Code References
**Locations to update:**

1. **Schema.org (index.html)** - Line ~35
```json
"image": "{{ site.url }}{{ site.baseurl }}/assets/images/products/jual-kayu-dolken-gelam-2-3cm-001.jpeg"
```

2. **Product cards (jika ada tampilan image di HTML)**
```html
<img src="{{ '/assets/images/products/jual-kayu-dolken-gelam-2-3cm-001.jpeg' | relative_url }}"
     alt="Jual kayu dolken gelam diameter 2-3 cm">
```

3. **Blog posts (markdown)**
```markdown
![Keunggulan kayu dolken gelam]({{ site.baseurl }}/assets/images/posts/keunggulan-kayu-dolken-gelam-untuk-konstruksi/keunggulan-kayu-dolken-gelam-untuk-konstruksi-001.jpg)
```

### Step 4: Rebuild & Test
```bash
cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html
./rebuild.sh
```

**Test URLs:**
- Local: `http://jualkayudolkengelam.github.io.local/assets/images/products/jual-kayu-dolken-gelam-2-3cm-001.jpeg`
- Production: `https://jualkayudolkengelam.github.io/assets/images/products/jual-kayu-dolken-gelam-2-3cm-001.jpeg`

---

## Completed Tasks

### Test 1: Product Image Diameter 2-3 cm
**Date:** 2025-11-15 09:53

- ✅ Created folder: `public_html/assets/images/products/`
- ✅ Source file renamed: `WhatsApp Image 2025-08-09 at 10.01.21.jpeg` → `jual-kayu-dolken-gelam-2-3cm-001.jpeg`
- ✅ Copied to: `public_html/assets/images/products/jual-kayu-dolken-gelam-2-3cm-001.jpeg` (245K)
- ✅ Updated Schema.org in `index.html` line 35
- ✅ Ready for rebuild

### Product Collection System Implementation
**Date:** 2025-11-15 10:36

#### All 5 Product Images Uploaded:
- ✅ `jual-kayu-dolken-gelam-2-3cm-001.jpeg` (245K) - Already uploaded
- ✅ `jual-kayu-dolken-gelam-4-6cm-001.jpeg` (362K) - WhatsApp Image 2025-08-09 at 09.58.14.jpeg → renamed & copied
- ✅ `jual-kayu-dolken-gelam-6-8cm-001.jpeg` (285K) - WhatsApp Image 2025-08-09 at 09.58.30.jpeg → renamed & copied
- ✅ `jual-kayu-dolken-gelam-8-10cm-001.jpeg` (451K) - WhatsApp Image 2025-08-09 at 10.01.16.jpeg → renamed & copied (POPULER)
- ✅ `jual-kayu-dolken-gelam-10-12cm-001.jpeg` (315K) - WhatsApp Image 2025-08-09 at 09.59.01.jpeg → renamed & copied

#### Product Collection Files Created:
- ✅ `_products/kayu-dolken-2-3cm.md` - Rp 15.000
- ✅ `_products/kayu-dolken-4-6cm.md` - Rp 35.000
- ✅ `_products/kayu-dolken-6-8cm.md` - Rp 60.000
- ✅ `_products/kayu-dolken-8-10cm.md` - Rp 85.000 (popular: true)
- ✅ `_products/kayu-dolken-10-12cm.md` - Rp 120.000

#### Product Layout & Features:
- ✅ Created `_layouts/product.html` with complete structure
- ✅ Featured image support with fallback
- ✅ Product specifications card
- ✅ Features list from front matter
- ✅ WhatsApp + Phone CTA buttons
- ✅ Product description section
- ✅ Related products (3 items)
- ✅ Individual page Schema.org Product markup
- ✅ Breadcrumb navigation

#### Homepage Integration:
- ✅ Updated all 5 product cards with featured images
- ✅ Added clickable links to individual product pages (/product/kayu-dolken-*-*cm/)
- ✅ Added "Lihat Detail" button to each card
- ✅ Maintained WhatsApp CTA on cards
- ✅ All cards now have image preview (200px height, object-fit: cover, lazy loading)

#### Build & Test:
- ✅ Jekyll build successful (30 files, 2.4M)
- ✅ All 5 product pages generated in `/product/` directory
- ✅ All images copied to `_site/assets/images/products/`
- ✅ URLs corrected from `/products/` to `/product/` (matching permalink in _config.yml)

---

### LocalBusiness Image Addition
**Date:** 2025-11-15 11:44

- ✅ Source file: `WhatsApp Image 2025-04-08 at 10.58.35 (1).jpeg`
- ✅ Copied to: `public_html/assets/images/jual-kayu-dolken-gelam-lokalbisnis-001.jpeg` (451K)
- ✅ Updated Schema.org LocalBusiness in `_includes/head.html` line 36
- ✅ Added `"image"` field to LocalBusiness schema
- ✅ Image URL: `https://jualkayudolkengelam.github.io/assets/images/jual-kayu-dolken-gelam-lokalbisnis-001.jpeg`
- ✅ Build successful (33 files, 2.9M)
- ✅ Image accessible via HTTP 200 OK
- ✅ Fixes Google Rich Results warning "Kolom 'image' tidak ada (opsional)"

---

### Product Image Gallery Implementation
**Date:** 2025-11-15 12:28

#### Product 2-3 cm Gallery (4 images total):
- ✅ `jual-kayu-dolken-gelam-2-3cm-001.jpeg` (245K) - Already uploaded
- ✅ `jual-kayu-dolken-gelam-2-3cm-002.jpeg` (355K) - WhatsApp Image 2025-08-25 at 10.16.56.jpeg → renamed & copied
- ✅ `jual-kayu-dolken-gelam-2-3cm-003.jpeg` (247K) - WhatsApp Image 2025-08-25 at 10.16.55 (2).jpeg → renamed & copied
- ✅ `jual-kayu-dolken-gelam-2-3cm-004.jpeg` (333K) - WhatsApp Image 2025-08-25 at 10.16.55 (1).jpeg → renamed & copied

#### Layout Enhancement:
- ✅ Updated `_layouts/product.html` with Bootstrap 5 Carousel
- ✅ Support for `images:` array in product front matter
- ✅ Auto-detect: if `images` array exists, show carousel; else show single image
- ✅ Carousel features:
  - Indicators (dots) for navigation
  - Previous/Next buttons
  - Auto-play support
  - Lazy loading for non-first images
  - Max height 500px with object-fit: cover
  - Responsive design

#### Product Front Matter Structure:
```yaml
---
image: /assets/images/products/jual-kayu-dolken-gelam-2-3cm-001.jpeg  # Primary image
images:  # Gallery array (optional)
  - /assets/images/products/jual-kayu-dolken-gelam-2-3cm-001.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-2-3cm-002.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-2-3cm-003.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-2-3cm-004.jpeg
---
```

#### Build Results:
- ✅ Jekyll build successful (36 files, 3.8M)
- ✅ Carousel with 4 slides generated for product 2-3 cm
- ✅ All images accessible in _site folder
- ✅ Backward compatible: products without `images` array still work with single `image`

---

### Product Page Featured Image
**Date:** 2025-11-15 14:02

- ✅ Source file: `WhatsApp Image 2025-10-11 at 16.52.03.jpeg`
- ✅ Renamed to: `jual-kayu-dolken-gelam-product-page-001.jpeg`
- ✅ Copied to: `public_html/assets/images/jual-kayu-dolken-gelam-product-page-001.jpeg` (263K)
- ✅ WebP converted: `jual-kayu-dolken-gelam-product-page-001.webp` (287K)
- ✅ Updated `product.html` front matter with `image:` field
- ✅ Open Graph meta tag generated with image URL
- ✅ Twitter Card meta tag generated with image URL
- ✅ Build successful (56 files, 9.8M)
- ✅ Featured image now shown when sharing `/product/` URL to WhatsApp, Facebook, Twitter, LinkedIn

**Featured Image URL:**
- Local: `http://jualkayudolkengelam.github.io.local/assets/images/jual-kayu-dolken-gelam-product-page-001.jpeg`
- Production: `https://jualkayudolkengelam.github.io/assets/images/jual-kayu-dolken-gelam-product-page-001.jpeg`

**Social Media Preview:**
- Shows image of kayu dolken gelam warehouse/storage
- Title: "Produk Kayu Dolken Gelam"
- Description: "Daftar lengkap kayu dolken gelam panjang 4 meter dengan berbagai ukuran diameter..."

---

## Pending Tasks

### Future Enhancements
- [ ] Create first blog post with images
- [ ] Test post image workflow
- [ ] Add image optimization (compress if needed)
- [x] Test Schema.org markup with Google Rich Results Test (LocalBusiness image added)
- [x] Add Open Graph images for social sharing - DONE 2025-11-15 (product page)
- [x] Implement product image gallery (multiple images per product) - DONE 2025-11-15

---

## SEO Benefits

### 1. Filename SEO
- ✅ Keyword-rich filenames
- ✅ Descriptive alt text potential
- ✅ Google Image Search optimization

### 2. Schema.org Integration
- ✅ Product schema includes image URL
- ✅ Rich snippets potential in Google Search
- ✅ Better product visibility

### 3. File Organization
- ✅ Clean structure
- ✅ Easy maintenance
- ✅ No duplicate files

---

## Notes

1. **Source files** di `/home/mkt01/Documents/ANDRI/Dolken/foto/` **HARUS** direname dulu sebelum copy
2. **Numbering** dimulai dari 001 untuk support multiple images per product/post
3. **Extension** preserve original (.jpeg, .jpg, .mp4, dll)
4. **Update gitignore** jika perlu (tapi images sebaiknya di-commit untuk GitHub Pages)

---

## References

- Schema.org Product: https://schema.org/Product
- Google Image SEO: https://developers.google.com/search/docs/appearance/google-images
- Jekyll Assets: https://jekyllrb.com/docs/assets/

---

**Last Updated:** 2025-11-15
**Next Review:** Before adding image #2 (diameter 4-6cm)

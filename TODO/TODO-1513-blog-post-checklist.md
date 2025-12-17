# TODO-1513: Checklist Membuat Blog Post dengan Product List

**Date:** 2025-11-15
**Time:** ~50-60 menit (termasuk riset lokasi)
**Type:** Standard Operating Procedure
**Target:** Blog post 2500-3000 kata dengan SEO optimal

---

## 📋 Quick Summary

**Output:** Blog post 2500-3000 kata dengan 12 section + product list + 4 foto carousel

**⚠️ STRATEGI 2 TAHAP PENGERJAAN:**

**Mengapa dibagi 2 tahap?**
Pembagian menjadi 2 tahap bertujuan agar AI bisa menghasilkan lebih banyak tulisan berkualitas di tahap kedua. Dengan menyelesaikan tahap 1 terlebih dahulu (section 1-7), context dan token yang tersedia di tahap 2 akan lebih banyak untuk menulis section 8-12 dengan lebih detail dan mencapai target 2500-3000 kata.

**TAHAP 1 (Section 1-7):**
1. Persiapan: Judul, slug, 4 foto, tanggal
2. Images: Rename → Move → Convert WebP (8 files total)
3. Buat file: Front matter
4. Content Section 1-2: Intro + Mengapa Memilih Kami + Product List
5. Content Section 3-4: Area Pengiriman + Keunggulan
6. Content Section 5-6: Aplikasi + Cara Pemesanan
7. Content Section 7: Studi Kasus (opsional, ~1,800-2,000 kata)

**TAHAP 2 (Section 8-12 + Deploy):**
8. Content Section 8: Testimoni Pelanggan
9. Content Section 9: Tips Memilih Ukuran
10. Content Section 10: FAQ Singkat
11. Content Section 11: Tentang [Lokasi] (WAJIB riset Wikipedia/WebSearch)
12. Content Section 12: CTA Final
13. Build & Test: Jekyll build + responsive check
14. Deploy: Git commit + push

**Estimasi Word Count:**
- Tahap 1: ~1,800-2,000 kata
- Tahap 2: +700-1,000 kata
- **Total: 2,500-3,000 kata**

**Kunci Sukses:**
- ✅ Keyword Jual Kayu Dolken [di kota tujuan jika terkait kota] muncul 8-10x
- ✅ Nomor 081311400177 muncul 8-10x
- ✅ Product list include setelah section 2
- ✅ Format markdown simple (NO HTML/CSS)
- ✅ Section 11: WAJIB riset Wikipedia/WebSearch
- ✅ Cek word count: target 2500-3000 kata

---

## Checklist Detail

### 1️⃣ Persiapan (5 menit)
- [ ] Tentukan judul: "Jual Kayu Dolken [Lokasi] - Hub 081311400177"
- [ ] Tentukan slug: `jual-kayu-dolken-[lokasi]`
- [ ] Siapkan 4 foto
- [ ] Tentukan tanggal: `YYYY-MM-DD`

### 2️⃣ Images (10 menit)

**Step 1: Rename di folder sumber (buat nama final)**
```bash
# pindah folder ke folder sumber foto
cd [FOLDER_SUMBER]

# Rename ke nama final yang akan dipakai
mv "WhatsApp Image 2025-08-30 at 15.35.22.jpeg" "[slug]-001.jpeg"
mv "WhatsApp Image 2025-08-30 at 15.35.12.jpeg" "[slug]-002.jpeg"
mv "WhatsApp Image 2025-08-30 at 15.35.01.jpeg" "[slug]-003.jpeg"
mv "WhatsApp Image 2025-08-30 at 15.34.53.jpeg" "[slug]-004.jpeg"
```

**Step 2: Masuk ke Jekyll folder & buat folder images**
```bash
cd /home/mkt01/Public/jualkayudolkengelam.net/public_html
mkdir -p assets/images/posts/[slug]
```

**Step 3: Move ke Jekyll (sekaligus hapus dari source)**
```bash
# Move (bukan copy) - file langsung pindah dari source ke Jekyll
mv [Folder sumber foto]/[folder-name]/[slug]-001.jpeg assets/images/posts/[slug]/[slug]-001.jpeg
mv [Folder sumber foto]/[folder-name]/[slug]-002.jpeg assets/images/posts/[slug]/[slug]-002.jpeg
mv [Folder sumber foto]/[folder-name]/[slug]-003.jpeg assets/images/posts/[slug]/[slug]-003.jpeg
mv [Folder sumber foto]/[folder-name]/[slug]-004.jpeg assets/images/posts/[slug]/[slug]-004.jpeg
```

**Step 4: Convert ke WebP**
```bash
cd assets/images/posts/[slug]
for img in *.jpeg; do cwebp -q 85 "$img" -o "${img%.jpeg}.webp"; done
cd /home/mkt01/Public/jualkayudolkengelam.net/public_html
```

**Checklist:**
- [ ] File di source sudah rename ke nama final ([slug]-001.jpeg, dll)
- [ ] File sudah move ke Jekyll folder (tidak ada lagi di source)
- [ ] 4 JPEG + 4 WebP = 8 files di Jekyll folder

### 3️⃣ Buat File (5 menit)
```bash
cd /home/mkt01/Public/jualkayudolkengelam.net/public_html
# Buat file: _posts/YYYY-MM-DD-[slug].md
```

**Front Matter:**
```yaml
---
layout: post-with-city
title: "Jual Kayu Dolken [Lokasi] - Hub 081311400177 - Gratis Ongkir"
description: "Jual kayu dolken [lokasi] harga terbaik. Gratis ongkir. Hub 081311400177."
date: YYYY-MM-DD
author: Admin
author_url: https://jualkayudolkengelam.net
image: /assets/images/posts/[slug]/[slug]-001.jpeg
images:
  - /assets/images/posts/[slug]/[slug]-001.jpeg
  - /assets/images/posts/[slug]/[slug]-002.jpeg
  - /assets/images/posts/[slug]/[slug]-003.jpeg
  - /assets/images/posts/[slug]/[slug]-004.jpeg
keywords: jual kayu dolken [lokasi], dolken gelam [lokasi], supplier dolken [lokasi]
url: /YYYY/MM/DD/[slug]/
show_products: true
---
```

**Note:**
- Kolom `url` opsional untuk schema.org Article - format: `/YYYY/MM/DD/slug/`
- Kolom `author_url` opsional untuk schema.org Author - default: homepage

### 3b️⃣ Schema.org: Like & Interaction (Opsional)

**Front Matter Fields untuk Like/Interaction:**
```yaml
# Opsional: Tambahkan di front matter untuk schema.org InteractionCounter
like_count: 42
comment_count: 15
share_count: 8
```

**Schema.org Types yang Relevan:**

1. **InteractionCounter** (untuk menampilkan jumlah like/comment/share)
   - Type: `InteractionCounterInteractionType`
   - Properties:
     - `@type`: "InteractionCounter"
     - `interactionType`: "https://schema.org/LikeAction" (atau CommentAction, ShareAction)
     - `userInteractionCount`: Jumlah like/comment/share

2. **UserInteraction** (untuk tracking engagement)
   - Type: `UserInteraction`
   - Properties:
     - `@type`: "LikeAction" (atau CommentAction, ShareAction)
     - `agent`: User yang melakukan action
     - `target`: URL artikel


**Checklist Schema.org Like:**
- [ ] Tambahkan `like_count`, `comment_count`, `share_count` di front matter (opsional)
- [ ] Update layout `post-with-products.html` untuk include InteractionCounter di schema.org
- [ ] Test dengan Google Rich Results Test: https://search.google.com/test/rich-results
- [ ] Verifikasi di browser: view source → cari `interactionStatistic`

**Manfaat SEO:**
- ✅ Google dapat menampilkan engagement metrics di search results
- ✅ Meningkatkan CTR dengan social proof (like/comment counts)
- ✅ Rich snippets lebih menarik di SERP
- ✅ Tracking engagement per artikel untuk analytics

**Note Penting:**
- Like/comment/share counts harus **real** atau **reasonable estimate** - jangan fake
- Update counts secara berkala (monthly) untuk akurasi
- Jika tidak ada interaction, **skip fields ini** - Google tidak penalize

### 4️⃣ Tulis Content (25-30 menit)

**Target: 2500-3000 kata untuk SEO optimal**

**Struktur Content (Urutan):**

- [ ] **1. Intro & Hook (150-200 kata)** - Cari kayu dolken di [Lokasi]? Hubungi 081311400177
- [ ] **2. Mengapa Memilih Kami (200-250 kata)** - 6 poin, format:
  ```
  ✅ **Judul Poin**

  Penjelasan singkat (1-2 kalimat)
  ```
- [ ] **2b. Include Product List** - Tambahkan setelah "Mengapa Memilih Kami":
  ```markdown
  ---

  ## 💰 Daftar Harga Kayu Dolken [Lokasi]

  Berikut daftar lengkap harga kayu dolken gelam untuk area [Lokasi] dengan pengiriman gratis:

  {% include product-list.html %}

  **📞 Hubungi 081311400177 untuk info harga terbaru dan penawaran khusus!**

  ---
  ```
- [ ] **3. Area Pengiriman Detail (300-400 kata)** - Format per kecamatan:
  ```
  **Nama Kecamatan**
  - Area 1, Area 2
  - Area 3, Area 4
  ```
- [ ] **4. Keunggulan Kayu Dolken Gelam (250-300 kata)** - 6 poin, format:
  ```
  🌳 **Judul Keunggulan**

  Penjelasan detail (1-2 kalimat)
  ```
- [ ] **5. Aplikasi & Penggunaan (300-350 kata)** - 4 kategori dengan format:
  ```
  **Konstruksi & Bangunan:**
  - Aplikasi 1
  - Aplikasi 2
  - Aplikasi 3

  **Dekorasi & Landscaping:**
  - Aplikasi 1
  - Aplikasi 2

  **Furniture & Lain-lain:**
  - Aplikasi 1

  **Proyek Komersial:**
  Paragraf tentang proyek yang sudah dikerjakan
  ```
- [ ] **6. Cara Pemesanan (200-250 kata)** - 6 langkah, format:
  ```
  **1. Judul Langkah**

  Penjelasan singkat

  **2. Judul Langkah**

  Penjelasan singkat
  ```
  Nomor 081311400177 muncul di langkah 2
- [ ] **7. Studi Kasus Proyek (OPSIONAL, 250-300 kata)** - 3-5 proyek real di lokasi:
  ```
  **Nama Proyek di [Area Spesifik] (Tahun)**

  Deskripsi proyek: ukuran, jumlah batang, diameter, hasil
  ```
  Contoh: Gazebo di Kelapa Gading, Pagar Villa di PIK, Cafe di Sunter
  Tutup dengan CTA: Hubungi 081311400177
- [ ] **8. Testimoni Pelanggan (150-200 kata)** - 3-5 testimoni dengan format:
  ```
  ⭐⭐⭐⭐⭐

  **"Review text"**

  *- Nama, Profesi/Area*

  ---
  ```
- [ ] **9. Tips Memilih Ukuran (200-250 kata)** - 3 kategori dengan format:
  ```
  **Untuk Dekorasi Ringan (Pagar, Taman):**
  - Pilih diameter 2-3 cm atau 4-6 cm
  - Lebih ekonomis dan mudah dipasang
  - Estetika lebih ringan dan elegan

  **Untuk Struktur Sedang (Gazebo, Pergola):**
  - Pilih diameter 6-8 cm
  - Balance antara kekuatan dan harga
  - Paling populer untuk residential

  **Untuk Struktur Berat (Tiang Utama, Pondasi):**
  - Pilih diameter 8-10 cm atau 10-12 cm
  - Kekuatan maksimal
  - Tahan beban berat jangka panjang

  ** Berikan variasi kata untuk bagian ini**

  **Butuh Konsultasi?** Hubungi **081311400177** - tim kami siap bantu hitung kebutuhan Anda!
  ```
- [ ] **10. FAQ Singkat (300-400 kata)** - 5 pertanyaan umum dengan format:
  ```
  **Pertanyaan?**

  Jawaban detail 2-3 kalimat dengan nomor 081311400177 jika relevan
  ```
  Topik FAQ: minimal order, perawatan, pengiriman, custom, cek kualitas
- [ ] **11. Tentang [Lokasi] (400-500 kata)** - Riset dari Wikipedia/WebSearch:
  **Cara riset:**
  ```
  WebSearch: "[Lokasi] sejarah wilayah kecamatan landmark"
  atau
  Wikipedia: "Kota Administrasi [Lokasi]"
  ```
  **Struktur konten:**
  - Paragraf intro: luas, populasi, jumlah kecamatan
  - Sub-heading: **Sejarah [Lokasi]** (150-200 kata)
  - Sub-heading: **[Landmark Utama]** (100-150 kata)
  - Sub-heading: **Pusat Bisnis & Komersial Modern** (100-150 kata)
  - Sub-heading: **Pembangunan & Infrastruktur** (50-100 kata)
  - Sub-heading: **Kenapa Kayu Dolken Penting untuk [Lokasi]?** (100-150 kata)
  - Tutup dengan: "Untuk kebutuhan kayu dolken gelam di [Lokasi], hubungi **081311400177**"
- [ ] **12. CTA Final (150-200 kata)** - Format lengkap:
  ```
  ## 📞 Hubungi Kami Sekarang!

  **Telepon / WhatsApp: 081311400177**

  Siap memesan kayu dolken untuk proyek di [Lokasi]? Hubungi **081311400177** sekarang juga untuk:

  ✅ Konsultasi gratis kebutuhan proyek Anda

  ✅ Cek ketersediaan stok real-time

  ✅ Info harga terbaru dan penawaran khusus

  ✅ Jadwal pengiriman gratis [Lokasi]

  ✅ Rekomendasi ukuran sesuai kebutuhan

  ✅ Harga nego untuk pembelian partai besar

  ** item checklist ini tidak selalu harus sama, agar tidak banyak duplicate content**

  **Jam Operasional:** Senin - Sabtu, 08:00 - 17:00 WIB (WhatsApp 24/7)

  💼 **Melayani Semua Kebutuhan:**
  - Proyek komersial (hotel, cafe, restoran, mall)
  - Kontraktor & developer properti
  - Arsitek & interior designer
  - Perorangan / retail / homeowner
  - Pembelian partai besar (harga spesial & nego)

  🚚 **Pengiriman Gratis [Lokasi] - COD Tersedia - Stok Ready!**

  **Jangan ragu untuk bertanya - konsultasi gratis tanpa biaya! Hubungi 081311400177 sekarang!**
  ```

**Poin Penting:**
- Nomor **081311400177** muncul minimal 8-10x (tersebar merata)
- **Total target 2500-3000 kata** (untuk ranking Google optimal)
- **Cek word count** menggunakan Free Word Counter atau tool online setelah selesai
- **Product list manual include** setelah section 2 (Mengapa Memilih Kami)
- **TIDAK PERLU** menulis section "Harga" manual - sudah ada di product list
- **JANGAN gunakan HTML list/CSS inline** - gunakan format markdown sederhana untuk mobile
- Format: Emoji/Icon → Bold Title (baris terpisah) → Penjelasan (baris terpisah)
- Setiap section punya H3 heading (### Judul Section) untuk struktur SEO
- Sisipkan keyword naturally di setiap section
- Section 7 (Studi Kasus): OPSIONAL, tambahkan jika perlu boost word count ke 2500-3000 kata
- Section 11 (Tentang Lokasi): WAJIB riset di Wikipedia atau WebSearch untuk sejarah & fakta wilayah

**Estimasi Word Count per Section:**
- Section 1-6: ~1,200 kata
- Section 7 (opsional): +250 kata
- Section 8-10: ~600 kata
- Section 11: +450 kata
- Section 12: +200 kata
- **Total: ~2,500-2,700 kata**

### 5️⃣ Build & Test (5 menit)
```bash
cd /home/mkt01/Public/jualkayudolkengelam.net/public_html
bundle exec jekyll build
```
- [ ] Build success
- [ ] Gambar load (carousel 4 foto)
- [ ] Product list muncul setelah section "Mengapa Memilih Kami"
- [ ] Test mobile responsive (testimoni, tips, FAQ)
- [ ] **Verifikasi Schema.org (jika pakai like/interaction):**
  ```bash
  # Cek schema.org di generated HTML
  grep -A 20 '"interactionStatistic"' _site/YYYY/MM/DD/[slug]/index.html

  # Atau view di browser
  curl -s http://localhost:4000/YYYY/MM/DD/[slug]/ | grep -A 20 'interactionStatistic'
  ```
- [ ] Test schema.org dengan Google Rich Results Test:
  - URL: https://search.google.com/test/rich-results
  - Paste URL artikel atau paste HTML source
  - Verify: BlogPosting, InteractionCounter muncul tanpa error

### 6️⃣ Deploy (5 menit)
```bash
git add .
git commit -m "Add blog: Jual Kayu Dolken [Lokasi]"
git push origin main
```
- [ ] Push ke GitHub
- [ ] Test live URL

---

## Template Product List Include

**WAJIB:** Product list harus di-include manual setelah section "Mengapa Memilih Kami"

Template yang digunakan di section 2b:
```markdown
---

## 💰 Daftar Harga Kayu Dolken [Lokasi]

Berikut daftar lengkap harga kayu dolken gelam untuk area [Lokasi] dengan pengiriman gratis:

{% include product-list.html %}

**📞 Hubungi 081311400177 untuk info harga terbaru dan penawaran khusus!**

---
```

**Catatan:**
- Layout `post-with-products` TIDAK lagi auto-include product list
- Product list HANYA muncul jika manual include seperti template di atas
- Format responsive: Desktop (table 5 kolom), Mobile (card view)

---

## Keyword Formula

```
Primary: jual kayu dolken [lokasi]
2nd: dolken gelam [lokasi]
3rd: supplier kayu dolken [lokasi]
4th-6th: kayu dolken [sub-area1], dolken [sub-area2], [sub-area3]
```

---

## Quick Reference: Common Areas

**Jakarta Utara:** Kelapa Gading, Ancol, Pademangan, Sunter, Pluit
**Jakarta Selatan:** Kebayoran, Cilandak, Jagakarsa, Pasar Minggu
**Jakarta Barat:** Cengkareng, Kebon Jeruk, Grogol, Kembangan
**Jakarta Timur:** Cakung, Cipayung, Kramat Jati, Jatinegara
**Tangerang:** BSD, Serpong, Alam Sutera, Ciledug, Karawaci
**Bekasi:** Bekasi Timur, Bekasi Barat, Bekasi Selatan
**Bogor:** Bogor Kota, Cibinong, Cileungsi, Sentul

---

## Quick Reference: Schema.org Types

### Blog Post (BlogPosting)
**Required Fields:**
- `@type`: "BlogPosting"
- `headline`: Judul artikel
- `image`: Featured image URL
- `datePublished`: Tanggal publish (ISO 8601)
- `dateModified`: Tanggal update terakhir
- `author`: Object Person/Organization
- `publisher`: Object Organization (nama site)
- `mainEntityOfPage`: URL artikel

**Optional but Recommended:**
- `description`: Meta description
- `articleBody`: Full text content
- `keywords`: Keyword array/string
- `wordCount`: Jumlah kata
- `url`: Canonical URL
- `interactionStatistic`: Array InteractionCounter (like/comment/share)

### Interaction Types (InteractionCounter)
**Like Action:**
```json
{
  "@type": "InteractionCounter",
  "interactionType": "https://schema.org/LikeAction",
  "userInteractionCount": 42
}
```

**Comment Action:**
```json
{
  "@type": "InteractionCounter",
  "interactionType": "https://schema.org/CommentAction",
  "userInteractionCount": 15
}
```

**Share Action:**
```json
{
  "@type": "InteractionCounter",
  "interactionType": "https://schema.org/ShareAction",
  "userInteractionCount": 8
}
```

### Product (Schema.org Product)
**Required Fields:**
- `@type`: "Product"
- `name`: Nama produk
- `image`: Product image URL
- `description`: Deskripsi produk
- `sku`: SKU/kode produk
- `offers`: Object Offer (price, availability, etc.)

**For Product Rating (AggregateRating):**
```json
{
  "@type": "AggregateRating",
  "ratingValue": "4.8",
  "reviewCount": "91",
  "bestRating": "5",
  "worstRating": "1"
}
```

**Front Matter Fields:**
- `rating`: Rating value (e.g., 4.8)
- `review_count`: Total review count (e.g., 91)
- Default fallback: `rating: 4.5`, `review_count: 45`

### Local Business (LocalBusiness)
**For Homepage/Contact Page:**
```json
{
  "@type": "LocalBusiness",
  "name": "Jual Kayu Dolken Gelam",
  "image": "logo URL",
  "telephone": "081311400177",
  "address": {
    "@type": "PostalAddress",
    "addressLocality": "Jakarta",
    "addressCountry": "ID"
  },
  "geo": {
    "@type": "GeoCoordinates",
    "latitude": -6.2088,
    "longitude": 106.8456
  },
  "openingHoursSpecification": {
    "@type": "OpeningHoursSpecification",
    "dayOfWeek": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
    "opens": "08:00",
    "closes": "17:00"
  }
}
```

### Useful Links
- **Google Rich Results Test:** https://search.google.com/test/rich-results
- **Schema.org Documentation:** https://schema.org/
- **Google Search Central:** https://developers.google.com/search/docs/appearance/structured-data
- **Validator JSON-LD:** https://validator.schema.org/

---

**Status:** ✅ Ready
**Next:** Gunakan checklist ini untuk setiap blog post baru

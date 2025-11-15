# TODO-1513: Checklist Membuat Blog Post dengan Product List

**Date:** 2025-11-15
**Time:** ~45 menit
**Type:** Standard Operating Procedure

---

## Checklist Singkat

### 1️⃣ Persiapan (5 menit)
- [ ] Tentukan judul: "Jual Kayu Dolken [Lokasi] - Hub 081311400177"
- [ ] Tentukan slug: `jual-kayu-dolken-[lokasi]`
- [ ] Siapkan 4 foto
- [ ] Tentukan tanggal: `YYYY-MM-DD`

### 2️⃣ Images (10 menit)

**Step 1: Rename di folder sumber (buat nama final)**
```bash
cd /path/to/source/folder

# Rename ke nama final yang akan dipakai
mv "source1.jpeg" "[slug]-001.jpeg"
mv "source2.jpeg" "[slug]-002.jpeg"
mv "source3.jpeg" "[slug]-003.jpeg"
mv "source4.jpeg" "[slug]-004.jpeg"
```

**Step 2: Buat folder di Jekyll**
```bash
mkdir -p assets/images/posts/[slug]
```

**Step 3: Move ke Jekyll (sekaligus hapus dari source)**
```bash
# Move (bukan copy) - file langsung pindah dari source ke Jekyll
mv /path/to/source/[slug]-001.jpeg assets/images/posts/[slug]/[slug]-001.jpeg
mv /path/to/source/[slug]-002.jpeg assets/images/posts/[slug]/[slug]-002.jpeg
mv /path/to/source/[slug]-003.jpeg assets/images/posts/[slug]/[slug]-003.jpeg
mv /path/to/source/[slug]-004.jpeg assets/images/posts/[slug]/[slug]-004.jpeg
```

**Step 4: Convert ke WebP**
```bash
cd assets/images/posts/[slug]
for img in *.jpeg; do cwebp -q 85 "$img" -o "${img%.jpeg}.webp"; done
```

**Checklist:**
- [ ] File di source sudah rename ke nama final ([slug]-001.jpeg, dll)
- [ ] File sudah move ke Jekyll folder (tidak ada lagi di source)
- [ ] 4 JPEG + 4 WebP = 8 files di Jekyll folder

### 3️⃣ Buat File (5 menit)
```bash
# Buat file: _posts/YYYY-MM-DD-[slug].md
```

**Front Matter:**
```yaml
---
layout: post-with-products
title: "Jual Kayu Dolken [Lokasi] - Hub 081311400177 - Gratis Ongkir"
description: "Jual kayu dolken [lokasi] harga terbaik. Gratis ongkir. Hub 081311400177."
date: YYYY-MM-DD
author: Admin
image: /assets/images/posts/[slug]/[slug]-001.jpeg
images:
  - /assets/images/posts/[slug]/[slug]-001.jpeg
  - /assets/images/posts/[slug]/[slug]-002.jpeg
  - /assets/images/posts/[slug]/[slug]-003.jpeg
  - /assets/images/posts/[slug]/[slug]-004.jpeg
keywords: jual kayu dolken [lokasi], dolken gelam [lokasi], supplier dolken [lokasi]
show_products: true
---
```

### 4️⃣ Tulis Content (20-25 menit)

**Target: 2500+ kata untuk SEO optimal**

**Struktur Content (Urutan):**

- [ ] **1. Intro & Hook (150-200 kata)** - Cari kayu dolken di [Lokasi]? Hubungi 081311400177
- [ ] **2. Mengapa Memilih Kami (200-250 kata)** - 6 poin dengan HTML `<ul>` dan emoji ✅
- [ ] **3. Area Pengiriman Detail (300-400 kata)** - Kecamatan, kelurahan, landmark terkenal
- [ ] **4. Keunggulan Kayu Dolken Gelam (250-300 kata)** - 6 poin dengan emoji 🌳, jelaskan detail
- [ ] **5. Aplikasi & Penggunaan (300-350 kata)** - Konstruksi, dekorasi, furniture, proyek komersial
- [ ] **6. Cara Pemesanan (200-250 kata)** - 6 langkah detail dengan nomor 081311400177
- [ ] **7. Daftar Harga (150-200 kata)** - List semua ukuran dengan harga dan deskripsi
- [ ] **8. Testimoni Pelanggan (150-200 kata)** - 3-5 testimoni dengan rating ⭐
- [ ] **9. Tips Memilih Ukuran (200-250 kata)** - Panduan praktis untuk customer
- [ ] **10. FAQ Singkat (200-250 kata)** - 3-5 pertanyaan umum
- [ ] **11. Informasi Tambahan Lokasi (200-300 kata)** - Info unik tentang area/kota
- [ ] **12. CTA Final (150-200 kata)** - Hubungi 081311400177 dengan 6 poin benefit

**Poin Penting:**
- Nomor **081311400177** muncul minimal 8-10x (tersebar merata)
- **Total minimal 2500 kata** (untuk ranking Google lebih baik)
- Gunakan HTML list dengan style inline (mobile-friendly)
- Setiap section punya H3 heading (untuk struktur SEO)
- Sisipkan keyword naturally di setiap section

### 5️⃣ Build & Test (5 menit)
```bash
bundle exec jekyll build
```
- [ ] Build success
- [ ] Gambar load (carousel 4 foto)
- [ ] Product list muncul di bawah
- [ ] Test mobile responsive

### 6️⃣ Deploy (5 menit)
```bash
git add .
git commit -m "Add blog: Jual Kayu Dolken [Lokasi]"
git push origin main
```
- [ ] Push ke GitHub
- [ ] Test live URL

---

## Template HTML List (Copy-Paste)

```html
<ul style="list-style: none; padding-left: 0;">
  <li style="margin-bottom: 0.8rem;"><span style="color: #28a745; font-size: 1.2em;">✅</span> <strong>Point 1</strong> - Deskripsi</li>
  <li style="margin-bottom: 0.8rem;"><span style="color: #28a745; font-size: 1.2em;">✅</span> <strong>Point 2</strong> - Deskripsi</li>
</ul>
```

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

**Status:** ✅ Ready
**Next:** Gunakan checklist ini untuk setiap blog post baru

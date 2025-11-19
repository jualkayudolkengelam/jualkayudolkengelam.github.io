# Panduan Membuat Post with Product

Dokumentasi lengkap untuk membuat artikel dengan tipe `post_with_product` yang konsisten.

## 📋 Daftar Isi

1. [Quick Start](#quick-start)
2. [Struktur Frontmatter](#struktur-frontmatter)
3. [Field Reference](#field-reference)
4. [Checklist Before Publish](#checklist-before-publish)
5. [Common Mistakes](#common-mistakes)

---

## 🚀 Quick Start

### Langkah-langkah Membuat Artikel Baru:

1. **Copy template**
   ```bash
   cp TEMPLATE--post-with-product.md _post_with_product/2025-11-15-jual-kayu-dolken-{kota}.md
   ```

2. **Ganti semua placeholder `{NAMA_KOTA}` dan `{kota}`**
   - Contoh: `{NAMA_KOTA}` → `Semarang`
   - Contoh: `{kota}` → `semarang`

3. **Isi semua section REQUIRED**
   - Lihat [Field Reference](#field-reference) untuk detail

4. **Test build**
   ```bash
   ./rebuild.sh
   ```

5. **Verifikasi tampilan** di browser

6. **Commit & push**

---

## 📊 Struktur Frontmatter

### Hierarki Section (Urutan yang Benar):

```yaml
---
# 1. META INFORMATION (REQUIRED)
layout, title, description, date, author, images, keywords, nama_kota

# 2. AREA PENGIRIMAN (REQUIRED)
area_pengiriman (simple list)

# 3. KEUNGGULAN (REQUIRED)
keunggulan_produk, keunggulan_layanan

# 4. AREA PENGIRIMAN DETAIL (REQUIRED)
area_pengiriman_detail:
  - judul & deskripsi texts
  - wilayah_pusat
  - wilayah_utara_selatan (optional)
  - wilayah_pengembangan
  - kecamatan_lainnya (optional)
  - landmark_wisata
  - landmark_fasilitas

# 5. KEUNGGULAN PRODUK DETAIL (OPTIONAL)
keunggulan_durabilitas, keunggulan_nilai, keunggulan_kayu_dolken

# 6. APLIKASI (OPTIONAL but recommended)
aplikasi_kayu_dolken

# 7. PROSES PEMESANAN (REQUIRED)
proses_awal_pemesanan, finalisasi_pengiriman

# 8. STUDI KASUS (REQUIRED)
studi_kasus_proyek: proyek_komersial, proyek_residensial, proyek_publik

# 9. TESTIMONI (REQUIRED)
testimoni_residential, testimoni_komersial

# 10. TIPS UKURAN (REQUIRED)
tips_ukuran

# 11. FAQ (REQUIRED)
faq_pemesanan, faq_produk, faq_pengiriman

# 12. RELEVANSI (REQUIRED)
relevansi_kayu_dolken

# 13. TENTANG KOTA (REQUIRED)
tentang_kota: tagline, overview, sejarah_ekonomi, kehidupan_modern

# 14. SOCIAL METRICS (REQUIRED)
like_count, comment_count, share_count
---
```

---

## 📖 Field Reference

### ✅ REQUIRED FIELDS (Wajib Ada)

#### 1. META INFORMATION
- `layout: node--post-with-product` ← JANGAN DIUBAH
- `title` - Format: "Jual Kayu Dolken {KOTA} - Hub 081311400177 - Gratis Ongkir"
- `description` - Ringkasan untuk SEO (150-160 karakter)
- `date` - Format: YYYY-MM-DD
- `nama_kota` - Nama kota (digunakan di seluruh template)
- `show_products: true` ← JANGAN DIUBAH
- `images` - Minimal 4 gambar

#### 2. AREA PENGIRIMAN
- `area_pengiriman` - Array 5-10 area utama
- `area_pengiriman_detail` - Harus ada minimal:
  - `wilayah_pusat` (min 3 items)
  - `wilayah_pengembangan` (min 2 items)
  - `landmark_wisata` (min 3 items)
  - `landmark_fasilitas` (min 3 items)

#### 3. TENTANG KOTA
- `tentang_kota.sejarah_ekonomi` - HARUS 2 cards
- `tentang_kota.kehidupan_modern` - HARUS 2 cards

**❌ SALAH:**
```yaml
sejarah_ekonomi:
  - judul: "Sejarah Kota"  # Hanya 1 card
```

**✅ BENAR:**
```yaml
sejarah_ekonomi:
  - judul: "Sejarah Kota"  # Card 1
    icon: "bi-clock-history"
    subjudul: "..."
    fakta: [...]
  - judul: "Pelabuhan/Ekonomi"  # Card 2
    icon: "bi-shop"
    subjudul: "..."
    fakta: [...]
```

---

### 🔧 OPTIONAL FIELDS (Boleh Dikosongkan)

- `wilayah_utara_selatan` - Hanya untuk kota dengan pembagian jelas utara/selatan
- `kecamatan_lainnya` - Untuk kecamatan tambahan yang tidak masuk kategori lain
- `proyek_publik` - Studi kasus proyek publik (jika ada)
- `testimoni_komersial` - Testimoni dari bisnis/komersial
- `keunggulan_kayu_dolken` - Versi array (jika tidak pakai keunggulan_durabilitas)

---

## 🎯 Checklist Before Publish

### Pre-Build Checklist:

- [ ] Semua `{PLACEHOLDER}` sudah diganti
- [ ] Nama file format: `YYYY-MM-DD-jual-kayu-dolken-{kota}.md`
- [ ] `nama_kota` konsisten di semua tempat
- [ ] Minimal 4 gambar di `/assets/images/posts/jual-kayu-dolken-{kota}/`
- [ ] `sejarah_ekonomi` ada 2 cards
- [ ] `kehidupan_modern` ada 2 cards
- [ ] `wilayah_pusat` minimal 3 kecamatan
- [ ] `landmark_wisata` minimal 3 items
- [ ] `landmark_fasilitas` minimal 3 items
- [ ] Social metrics (like_count, comment_count, share_count) diisi
- [ ] Content section (HTML blocks) TIDAK DIUBAH

### Build & Test:

```bash
# 1. Test build
./rebuild.sh

# 2. Check for errors
# Jika ada error, cek struktur YAML dengan online YAML validator

# 3. Open in browser
# http://localhost:4000/2025/11/15/jual-kayu-dolken-{kota}/

# 4. Verify sections:
# - Hero section tampil
# - Area Pengiriman tampil dengan card kecamatan
# - Tentang Kota tampil dengan 4 cards (2 sejarah + 2 modern)
# - Semua block lain tampil normal
```

---

## ⚠️ Common Mistakes

### 1. **Struktur YAML Tidak Konsisten**

❌ **SALAH:**
```yaml
area_pengiriman_detail:
  kecamatan:  # ← SALAH! Harus "wilayah_pusat"
    - nama: "Kelapa Gading"
```

✅ **BENAR:**
```yaml
area_pengiriman_detail:
  wilayah_pusat:  # ← BENAR!
    - nama: "Kelapa Gading"
```

### 2. **Tentang Kota Kurang Cards**

❌ **SALAH:**
```yaml
tentang_kota:
  sejarah_ekonomi:
    - judul: "Sejarah"  # Hanya 1 card
  kehidupan_modern:
    - judul: "Modern"   # Hanya 1 card
```

✅ **BENAR:**
```yaml
tentang_kota:
  sejarah_ekonomi:
    - judul: "Sejarah"     # Card 1
    - judul: "Pelabuhan"   # Card 2
  kehidupan_modern:
    - judul: "Landmark"    # Card 1
    - judul: "Pendidikan"  # Card 2
```

### 3. **Lupa Ganti Placeholder**

❌ **SALAH:**
```yaml
title: "Jual Kayu Dolken {NAMA_KOTA} - Hub 081311400177"
```

✅ **BENAR:**
```yaml
title: "Jual Kayu Dolken Semarang - Hub 081311400177"
```

### 4. **Inconsistent nama_kota**

❌ **SALAH:**
```yaml
nama_kota: Semarang
# ...
relevansi_kayu_dolken:
  karakteristik_iklim: "... di Jakarta Utara ..."  # ← SALAH!
```

✅ **BENAR:**
```yaml
nama_kota: Semarang
# ...
relevansi_kayu_dolken:
  karakteristik_iklim: "... di Semarang ..."  # ← BENAR!
```

### 5. **Indentasi YAML Salah**

❌ **SALAH:**
```yaml
area_pengiriman_detail:
wilayah_pusat:  # ← Kurang indent
  - nama: "Kec"
```

✅ **BENAR:**
```yaml
area_pengiriman_detail:
  wilayah_pusat:  # ← Indent 2 spaces
    - nama: "Kec"
```

---

## 🔍 Validation

### Manual Check:

1. **Copy frontmatter Anda ke YAML validator online:**
   - https://www.yamllint.com/
   - https://yamlchecker.com/

2. **Check struktur dengan template:**
   ```bash
   diff TEMPLATE--post-with-product.md _post_with_product/your-file.md
   ```

### Visual Check After Build:

Buka halaman di browser dan pastikan:

✅ **Section yang HARUS tampil:**
1. Hero dengan nama kota
2. Mengapa Memilih Kami (6 cards)
3. **Area Pengiriman dengan cards kecamatan**
4. Keunggulan Kayu Dolken
5. Aplikasi Kayu Dolken
6. Cara Pemesanan
7. Studi Kasus Proyek
8. Testimoni Pelanggan
9. Tips Memilih Ukuran
10. FAQ (3 sections)
11. **Tentang Kota dengan 4 cards**
12. Relevansi Kayu Dolken
13. Hubungi Kami
14. Related Products

---

## 💡 Tips & Best Practices

### 1. **Gunakan Nama Kota yang Konsisten**
```yaml
# Di awal file:
nama_kota: Semarang

# Di semua tempat lain, reference dengan variabel:
"... di area {{ page.nama_kota }} ..."
```

### 2. **Sesuaikan Karakteristik Kota**

Untuk kota pesisir:
```yaml
relevansi_kayu_dolken:
  karakteristik_iklim: "kota pesisir dengan kelembaban tinggi"
```

Untuk kota dataran tinggi:
```yaml
relevansi_kayu_dolken:
  karakteristik_iklim: "kota dataran tinggi dengan cuaca sejuk"
```

### 3. **Studi Kasus yang Spesifik**

Gunakan lokasi nyata di kota tersebut:
```yaml
studi_kasus_proyek:
  proyek_komersial:
    - judul: "Gazebo Cafe di Kota Lama"  # ← Lokasi spesifik Semarang
```

### 4. **Testimoni yang Natural**

Gunakan nama area yang ada:
```yaml
testimoni_residential:
  - nama: "Pak Agus"
    lokasi: "Tembalang"  # ← Area nyata di Semarang
```

---

## 📞 Troubleshooting

### Build Error: "Invalid YAML"

**Penyebab:** Syntax YAML salah (biasanya indentasi atau quote)

**Solusi:**
1. Copy frontmatter ke YAML validator
2. Cek line yang error
3. Perbaiki indentasi atau tambahkan quote

### Section Tidak Tampil

**Penyebab:** Struktur frontmatter tidak sesuai dengan block

**Solusi:**
1. Bandingkan dengan Semarang atau Jakarta Utara
2. Pastikan nama field PERSIS sama
3. Pastikan minimal items terpenuhi

### Gambar Tidak Tampil

**Penyebab:** Path gambar salah atau file tidak ada

**Solusi:**
1. Cek folder `/assets/images/posts/jual-kayu-dolken-{kota}/`
2. Pastikan ada minimal 4 gambar: `-001.jpeg`, `-002.jpeg`, dst
3. Pastikan path di frontmatter PERSIS sama dengan nama file

---

## 📚 Resources

- **Template File:** `TEMPLATE--post-with-product.md`
- **Contoh Lengkap:**
  - `_post_with_product/2025-11-15-jual-kayu-dolken-semarang.md`
  - `_post_with_product/2025-11-15-jual-kayu-dolken-jakarta-utara.md`
- **Blocks Documentation:** `_includes/block--*.html` (lihat comment di header)

---

## ✨ Quick Reference: Minimal Required Structure

```yaml
---
layout: node--post-with-product
title: "Jual Kayu Dolken {KOTA} - Hub 081311400177 - Gratis Ongkir"
nama_kota: {KOTA}
show_products: true

area_pengiriman: [...]
keunggulan_produk: [3 items]
keunggulan_layanan: [3 items]

area_pengiriman_detail:
  judul_jangkauan: "..."
  deskripsi_jangkauan: "..."
  wilayah_pusat: [min 3 items]
  wilayah_pengembangan: [min 2 items]
  landmark_wisata: [min 3 items]
  landmark_fasilitas: [min 3 items]

proses_awal_pemesanan: {...}
finalisasi_pengiriman: {...}

studi_kasus_proyek:
  proyek_komersial: [min 2 items]
  proyek_residensial: [min 2 items]

testimoni_residential: [min 3 items]
tips_ukuran: [3 items]

faq_pemesanan: [min 2 items]
faq_produk: [min 2 items]
faq_pengiriman: [min 1 item]

relevansi_kayu_dolken: {...}

tentang_kota:
  sejarah_ekonomi: [exactly 2 items]
  kehidupan_modern: [exactly 2 items]

like_count: 0
comment_count: 0
share_count: 0
---
```

---

**Last Updated:** 2025-11-19
**Version:** 1.0.0
**Maintainer:** jualkayudolkengelam team

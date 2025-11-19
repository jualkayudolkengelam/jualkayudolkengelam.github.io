# Post with Product - Consistency Tools

Tools dan dokumentasi untuk memastikan semua artikel `post_with_product` menggunakan frontmatter yang konsisten.

## 📁 File yang Tersedia

### 1. **TEMPLATE--post-with-product.md** (Template Utama)
File template lengkap dengan semua field required dan optional.

**Cara Pakai:**
```bash
# Copy template untuk kota baru
cp TEMPLATE--post-with-product.md _post_with_product/2025-11-15-jual-kayu-dolken-{kota}.md

# Edit dan ganti semua {PLACEHOLDER}
```

**Kapan Digunakan:**
- Setiap kali membuat artikel baru
- Sebagai reference struktur frontmatter

---

### 2. **DOCS--post-with-product-guide.md** (Dokumentasi Lengkap)
Panduan lengkap dengan:
- Quick Start Guide
- Struktur Frontmatter Detail
- Field Reference (Required vs Optional)
- Common Mistakes & Solutions
- Troubleshooting Tips

**Kapan Digunakan:**
- Pertama kali membuat artikel
- Ketika ada error/section tidak tampil
- Ketika lupa struktur yang benar

---

### 3. **checklist-post.md** (Checklist Praktis)
Checklist yang bisa di-print atau dibuka side-by-side saat membuat artikel.

**Kapan Digunakan:**
- Before commit
- Saat review artikel
- Untuk memastikan tidak ada yang terlewat

---

### 4. **validate-post.sh** (Validation Script) - OPTIONAL
Script bash untuk basic validation (masih dalam development, mungkin tidak sempurna).

**Cara Pakai:**
```bash
chmod +x validate-post.sh
./validate-post.sh _post_with_product/your-file.md
```

**Note:** Script ini masih beta, lebih baik gunakan manual checklist.

---

## 🚀 Quick Workflow

### Untuk Artikel Baru:

```bash
# 1. Copy template
cp TEMPLATE--post-with-product.md _post_with_product/2025-11-20-jual-kayu-dolken-bandung.md

# 2. Edit file
# - Ganti semua {PLACEHOLDER}
# - Isi semua section REQUIRED
# - Reference DOCS jika perlu

# 3. Buka checklist
# Open checklist-post.md di browser/editor lain

# 4. Build & test
./rebuild.sh

# 5. Check di browser
# Pastikan semua section tampil dengan benar

# 6. Review dengan checklist
# Centang semua item di checklist-post.md

# 7. Commit & push
git add .
git commit -m "feat: Add Bandung article"
git push
```

---

## ✅ Struktur Frontmatter yang Benar

### ⚠️ Yang HARUS Ada (REQUIRED):

```yaml
---
# META
layout: node--post-with-product
title, description, nama_kota, show_products

# AREA PENGIRIMAN
area_pengiriman (list)
area_pengiriman_detail:
  - Text fields (judul, deskripsi)
  - wilayah_pusat (min 3)
  - wilayah_pengembangan (min 2)
  - landmark_wisata (min 3)
  - landmark_fasilitas (min 3)

# KEUNGGULAN
keunggulan_produk (3 items)
keunggulan_layanan (3 items)

# PROSES
proses_awal_pemesanan
finalisasi_pengiriman

# STUDI KASUS
studi_kasus_proyek:
  proyek_komersial (min 2)
  proyek_residensial (min 2)

# TESTIMONI
testimoni_residential (min 3)

# TIPS
tips_ukuran (3 items)

# FAQ
faq_pemesanan (min 2)
faq_produk (min 2)
faq_pengiriman (min 1)

# RELEVANSI
relevansi_kayu_dolken

# TENTANG KOTA ⚠️ PENTING!
tentang_kota:
  tentang_kota_1 (EXACTLY 2 cards - topik bebas)
  tentang_kota_2 (EXACTLY 2 cards - topik bebas)

# METRICS
like_count, comment_count, share_count
---
```

---

## 🎯 Struktur Khusus yang Sering Salah

### 1. **Area Pengiriman Detail**

✅ **BENAR:**
```yaml
area_pengiriman_detail:
  wilayah_pusat:
    - nama: "..."
  wilayah_pengembangan:
    - nama: "..."
  landmark_wisata:
    - nama: "..."
  landmark_fasilitas:
    - nama: "..."
```

❌ **SALAH (Struktur Lama):**
```yaml
area_pengiriman_detail:
  kecamatan:  # ← SALAH!
    - nama: "..."
  area_populer:  # ← SALAH!
    - "..."
  landmark:  # ← SALAH!
    - nama: "..."
```

### 2. **Tentang Kota**

✅ **BENAR:**
```yaml
tentang_kota:
  tagline: "..."
  deskripsi_singkat: "..."
  overview: "..."
  tentang_kota_1:  # HARUS 2 items (topik bebas)
    - judul: "Sejarah/Budaya/Kuliner/dll"  # Bebas topik!
      icon: "bi-clock-history"
      subjudul: "..."
      icon_subjudul: "bi-book"
      deskripsi: "..."
      fakta: [...]  # 3 items
    - judul: "Ekonomi/Landmark/dll"  # Bebas topik!
      icon: "bi-shop"
      subjudul: "..."
      icon_subjudul: "bi-graph-up"
      deskripsi: "..."
      fakta: [...]  # 3 items
  tentang_kota_2:  # HARUS 2 items (topik bebas)
    - judul: "Landmark/Wisata/dll"  # Bebas topik!
      icon: "bi-building"
      subjudul: "..."
      icon_subjudul: "bi-pin-map"
      deskripsi: "..."
      list_item: [...]  # Min 2 items
    - judul: "Pendidikan/Infrastruktur/dll"  # Bebas topik!
      icon: "bi-mortarboard"
      subjudul: "..."
      icon_subjudul: "bi-globe"
      deskripsi: "..."
      list_item: [...]  # Min 2 items
```

❌ **SALAH (Struktur Lama atau Kurang Items):**
```yaml
tentang_kota:
  nama: "Jakarta"  # ← SALAH! Tidak dipakai
  statistik: {...}  # ← SALAH! Tidak dipakai
  tentang_kota_1:  # ← SALAH! Cuma 1 item (harus 2)
    - judul: "Sejarah"
```

---

## 🔍 Contoh Referensi

Lihat artikel yang sudah benar:

1. **Semarang** - `_post_with_product/2025-11-15-jual-kayu-dolken-semarang.md`
   - Struktur lengkap dengan semua section
   - Punya wilayah_utara_selatan (optional)
   - Tentang kota dengan 2+2 cards

2. **Jakarta Utara** - `_post_with_product/2025-11-15-jual-kayu-dolken-jakarta-utara.md`
   - Struktur konsisten dengan Semarang
   - Tidak punya wilayah_utara_selatan (karena optional)
   - Tentang kota dengan 2+2 cards

---

## 🐛 Troubleshooting

### "Build Error: Invalid YAML"
1. Copy frontmatter ke https://www.yamllint.com/
2. Fix error yang muncul (biasanya indentasi)

### "Section Area Pengiriman Tidak Tampil"
1. Pastikan pakai `wilayah_pusat`, bukan `kecamatan`
2. Pastikan pakai `landmark_wisata` dan `landmark_fasilitas`, bukan `landmark`
3. Bandingkan dengan Semarang/Jakarta Utara

### "Section Tentang Kota Tidak Tampil"
1. Pastikan `tentang_kota_1` punya exactly 2 items
2. Pastikan `tentang_kota_2` punya exactly 2 items
3. Pastikan setiap item punya `judul`, `icon`, `subjudul`, `icon_subjudul`, `deskripsi`, `fakta`/`list_item`

### "Gambar Tidak Tampil"
1. Cek folder `/assets/images/posts/jual-kayu-dolken-{kota}/`
2. Pastikan nama file persis: `jual-kayu-dolken-{kota}-001.jpeg` (bukan .jpg)
3. Pastikan path di frontmatter sama dengan nama file

---

## 📞 Support

Jika masih ada masalah:
1. Baca `DOCS--post-with-product-guide.md` untuk detail lengkap
2. Bandingkan dengan artikel Semarang atau Jakarta Utara
3. Check semua item di `checklist-post.md`

---

## 📚 File Structure

```
public_html/
├── TEMPLATE--post-with-product.md       # Template utama
├── DOCS--post-with-product-guide.md     # Dokumentasi lengkap
├── checklist-post.md                    # Checklist praktis
├── README--post-with-product.md         # File ini
├── validate-post.sh                     # Validation script (optional)
│
├── _post_with_product/                  # Folder artikel
│   ├── 2025-11-15-jual-kayu-dolken-semarang.md
│   ├── 2025-11-15-jual-kayu-dolken-jakarta-utara.md
│   └── [artikel baru]
│
└── _includes/                           # Folder blocks
    ├── block--area-pengiriman-kayu-dolken.html
    ├── block--tentang-kota-kami.html
    └── [block lainnya]
```

---

**Version:** 1.0.0
**Last Updated:** 2025-11-19
**Maintainer:** jualkayudolkengelam team

# Checklist: Membuat Artikel Post with Product

Gunakan checklist ini sebelum publish artikel baru.

## ✅ Pre-Creation Checklist

- [ ] Sudah membaca `DOCS--post-with-product-guide.md`
- [ ] Sudah copy `TEMPLATE--post-with-product.md`
- [ ] File name sudah benar: `YYYY-MM-DD-jual-kayu-dolken-{kota}.md`
- [ ] Folder gambar sudah dibuat: `/assets/images/posts/jual-kayu-dolken-{kota}/`
- [ ] Minimal 4 gambar sudah diupload

## ✅ Frontmatter Checklist

### Meta Information
- [ ] `layout: node--post-with-product` (JANGAN UBAH)
- [ ] `title` sudah diganti dari placeholder
- [ ] `description` sudah diisi (150-160 karakter)
- [ ] `date` sudah diisi dengan format YYYY-MM-DD
- [ ] `nama_kota` sudah diisi
- [ ] `show_products: true` (JANGAN UBAH)
- [ ] `images` path sudah benar (4 gambar)
- [ ] `keywords` sudah disesuaikan dengan kota

### Area Pengiriman
- [ ] `area_pengiriman` diisi 5-10 area
- [ ] `area_pengiriman_detail.judul_jangkauan` diisi
- [ ] `area_pengiriman_detail.deskripsi_jangkauan` diisi
- [ ] `area_pengiriman_detail.judul_pusat` diisi
- [ ] `area_pengiriman_detail.deskripsi_pusat` diisi
- [ ] `area_pengiriman_detail.judul_pengembangan` diisi
- [ ] `area_pengiriman_detail.deskripsi_pengembangan` diisi
- [ ] `area_pengiriman_detail.judul_landmark` diisi
- [ ] `area_pengiriman_detail.deskripsi_landmark` diisi
- [ ] `area_pengiriman_detail.judul_wisata` diisi
- [ ] `area_pengiriman_detail.deskripsi_wisata` diisi
- [ ] `area_pengiriman_detail.judul_fasilitas` diisi
- [ ] `area_pengiriman_detail.deskripsi_fasilitas` diisi

###Wilayah
- [ ] `wilayah_pusat` minimal 3 kecamatan
- [ ] `wilayah_pengembangan` minimal 2 kecamatan
- [ ] `landmark_wisata` minimal 3 items
- [ ] `landmark_fasilitas` minimal 3 items

### Keunggulan
- [ ] `keunggulan_produk` 3 items dengan icon & warna
- [ ] `keunggulan_layanan` 3 items dengan icon & warna

### Proses Pemesanan
- [ ] `proses_awal_pemesanan` lengkap (pilih_ukuran, hubungi, konsultasi_gratis)
- [ ] `finalisasi_pengiriman` lengkap (konfirmasi_pesanan, pengiriman_gratis, bayar_cod)

### Studi Kasus
- [ ] `studi_kasus_proyek.proyek_komersial` minimal 2 items
- [ ] `studi_kasus_proyek.proyek_residensial` minimal 2 items
- [ ] Setiap proyek punya: judul, tahun, deskripsi, jumlah, diameter, hasil, warna, icon

### Testimoni
- [ ] `testimoni_residential` minimal 3 items
- [ ] Setiap testimoni punya: nama, lokasi, rating, judul, komentar, warna

### FAQ
- [ ] `faq_pemesanan` minimal 2 items
- [ ] `faq_produk` minimal 2 items
- [ ] `faq_pengiriman` minimal 1 item
- [ ] Setiap FAQ punya: pertanyaan, jawaban, icon

### Tips Ukuran
- [ ] `tips_ukuran` 3 items (Dekorasi Ringan, Struktur Sedang, Struktur Berat)
- [ ] Setiap tips punya: kategori, aplikasi, diameter, keunggulan, warna, icon

### Relevansi
- [ ] `relevansi_kayu_dolken.karakteristik_iklim` disesuaikan dengan kota
- [ ] `relevansi_kayu_dolken.keunggulan_lokal` diisi
- [ ] `relevansi_kayu_dolken.aplikasi_lokal` minimal 4 items dengan lokasi spesifik kota

### Tentang Kota ⚠️ PENTING
- [ ] `tentang_kota.tagline` diisi
- [ ] `tentang_kota.deskripsi_singkat` diisi
- [ ] `tentang_kota.overview` lengkap dengan statistik kota
- [ ] `tentang_kota.tentang_kota_1` **EXACTLY 2 cards** (topik bebas)
  - [ ] Card 1 punya: judul, icon, subjudul, icon_subjudul, deskripsi, fakta (array 3 items)
  - [ ] Card 2 punya: judul, icon, subjudul, icon_subjudul, deskripsi, fakta (array 3 items)
- [ ] `tentang_kota.tentang_kota_2` **EXACTLY 2 cards** (topik bebas)
  - [ ] Card 1 punya: judul, icon, subjudul, icon_subjudul, deskripsi, list_item (array min 2 items)
  - [ ] Card 2 punya: judul, icon, subjudul, icon_subjudul, deskripsi, list_item (array min 2 items)

### Social Metrics
- [ ] `like_count` diisi (default 0)
- [ ] `comment_count` diisi (default 0)
- [ ] `share_count` diisi (default 0)

## ✅ Content Checklist

- [ ] Content section (HTML blocks) TIDAK DIUBAH dari template
- [ ] Semua `{% include block--... %}` masih ada
- [ ] Parameter `nama_kota` di block--jual-kayu-dolken-terdekat.html sudah diganti

## ✅ Quality Checklist

### Tidak Ada Placeholder
- [ ] Tidak ada `{NAMA_KOTA}` tersisa
- [ ] Tidak ada `{kota}` tersisa
- [ ] Tidak ada `{KOTA}` tersisa
- [ ] Tidak ada `{Area ...}` tersisa
- [ ] Tidak ada `{Kecamatan ...}` tersisa
- [ ] Tidak ada `{Nama ...}` tersisa
- [ ] Tidak ada `{Landmark ...}` tersisa

### Konsistensi nama_kota
- [ ] Nilai `nama_kota` konsisten di semua text
- [ ] Nama kota di title sama dengan `nama_kota`
- [ ] Nama kota di description sama dengan `nama_kota`

### Konten Spesifik Kota
- [ ] Studi kasus menggunakan lokasi nyata di kota
- [ ] Testimoni menggunakan nama area yang ada
- [ ] FAQ mention karakteristik kota yang sesuai
- [ ] Relevansi disesuaikan dengan iklim/kondisi kota

## ✅ Build & Test Checklist

- [ ] Run `./rebuild.sh` - SUKSES tanpa error
- [ ] Buka halaman di browser
- [ ] **Section "Area Pengiriman" tampil dengan card kecamatan** ⚠️
- [ ] **Section "Tentang Kota" tampil dengan 4 cards (2 sejarah + 2 modern)** ⚠️
- [ ] Hero section tampil dengan nama kota yang benar
- [ ] Semua gambar tampil
- [ ] Tidak ada text "{PLACEHOLDER}" di halaman
- [ ] Navigation berfungsi
- [ ] Related products tampil

## ✅ Before Commit

- [ ] Review seluruh halaman sekali lagi
- [ ] Check typo dan grammar
- [ ] Pastikan no link yang broken
- [ ] Pastikan gambar load dengan baik
- [ ] Test di mobile view (inspect element → responsive)

## 🚨 Common Issues

Jika section tidak tampil:

**Area Pengiriman tidak tampil?**
- Cek apakah `wilayah_pusat`, `wilayah_pengembangan`, `landmark_wisata`, `landmark_fasilitas` ada
- Jangan pakai `kecamatan`, `area_populer`, `landmark` (struktur lama)

**Tentang Kota tidak tampil?**
- Cek apakah `tentang_kota_1` punya exactly 2 items
- Cek apakah `tentang_kota_2` punya exactly 2 items
- Pastikan struktur sesuai: judul, icon, subjudul, icon_subjudul, deskripsi, fakta/list_item

**Gambar tidak tampil?**
- Cek path: `/assets/images/posts/jual-kayu-dolken-{kota}/jual-kayu-dolken-{kota}-001.jpeg`
- Pastikan nama file PERSIS sama (case-sensitive)
- Pastikan extensi `.jpeg` bukan `.jpg`

---

✅ **Artikel siap publish jika semua checklist tercentang!**

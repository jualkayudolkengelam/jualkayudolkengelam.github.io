---
# ============================================================================
# TEMPLATE: POST TUTORIAL (Format Instruksi)
# ============================================================================
# File: TEMPLATE--post-tutorial.md
# Purpose: Template untuk artikel tutorial/how-to dengan step-by-step guide
# Version: 2.1.0 (Block HTML Sudah Dibuat - Isi Frontmatter Saja!)
# Date: 2025-11-20
# Last Update: 2025-11-20 (Klarifikasi: Block sudah ada, tidak perlu dibuat)
# Example: Cara Menghitung Kebutuhan Kayu Dolken, Tutorial Pemasangan Pagar
#
# CARA PENGGUNAAN:
#
# RULE UTAMA:
# 1. Folder foto user → RENAME semua foto sesuai slug artikel!
# 2. Title → Slug HARUS LENGKAP, jangan dipotong!
# 3. HTML ID (kebab-case) → Frontmatter (snake_case) HARUS SAMA!
#
# INFORMASI BLOCK (SUDAH DIBUAT - JANGAN BUAT LAGI!):
# ⚠️ PENTING: Block HTML sudah dibuat dan siap pakai!
# ⚠️ ANDA HANYA PERLU mengisi data di frontmatter, TIDAK perlu membuat block baru!
#
# Pola yang sudah ada:
# HTML Section ID: <section id="intro">
# Block File:      block--intro.html (sudah ada di _includes/posts/tutorial/)
# Frontmatter:     intro: (isi data di sini)
#
# HTML Section ID: <section id="tips-praktis">
# Block File:      block--tips-praktis.html (sudah ada di _includes/posts/tutorial/)
# Frontmatter:     tips_praktis: (isi data di sini)
#
# LANGKAH PENGGUNAAN TEMPLATE:
# 1. Tentukan JUDUL artikel LENGKAP (dari user atau tentukan sendiri)
#    Contoh: "Cara Memasang Pagar Dolken untuk Rumah Minimalis"
#
# 2. Buat SLUG dari judul LENGKAP (lowercase, spasi jadi dash)
#    SLUG = seluruh kata di title, jangan potong!
#
#    ✅ BENAR:
#    Title: "Cara Memasang Pagar Dolken untuk Rumah Minimalis"
#    Slug:  "cara-memasang-pagar-dolken-untuk-rumah-minimalis"
#
#    ❌ SALAH (terpotong):
#    Slug:  "cara-memasang-pagar-dolken" ← kata "untuk-rumah-minimalis" hilang!
#
# 3. SLUG LENGKAP ini HARUS KONSISTEN di 3 tempat:
#    a. Nama file markdown: _posts/YYYY-MM-DD-{slug-lengkap}.md
#    b. Folder image: assets/images/posts/{slug-lengkap}/
#    c. URL hasil: /YYYY/MM/DD/{slug-lengkap}/
#
#    Contoh konsisten:
#    - File: _posts/2024-11-20-cara-memasang-pagar-dolken-untuk-rumah-minimalis.md
#    - Folder: assets/images/posts/cara-memasang-pagar-dolken-untuk-rumah-minimalis/
#    - URL: /2024/11/20/cara-memasang-pagar-dolken-untuk-rumah-minimalis/
#
# 4. Copy template ini → buat file baru di _posts/YYYY-MM-DD-{slug-lengkap}.md
#
# 5. Isi SEMUA frontmatter yang ada label "isi ..." atau "tulis ..."
#    ⚠️ JANGAN buat block HTML! Block sudah ada dan akan otomatis render data frontmatter
#
# 6. Proses foto (RENAME dari folder asalnya):
#    PENTING: {slug-lengkap} = slug LENGKAP yang sama dengan nama file & folder!
#
#    mkdir -p assets/images/posts/{slug-lengkap}/
#    cp /path/asli/apapun-nama-folder/foto-001.jpeg assets/images/posts/{slug-lengkap}/{slug-lengkap}-001.jpeg
#    cp /path/asli/apapun-nama-folder/foto-002.jpeg assets/images/posts/{slug-lengkap}/{slug-lengkap}-002.jpeg
#    cp /path/asli/apapun-nama-folder/foto-003.jpeg assets/images/posts/{slug-lengkap}/{slug-lengkap}-003.jpeg
#    cp /path/asli/apapun-nama-folder/foto-004.jpeg assets/images/posts/{slug-lengkap}/{slug-lengkap}-004.jpeg
#    cd assets/images/posts/{slug-lengkap}/
#    for file in *.jpeg; do cwebp -q 85 "$file" -o "${file%.jpeg}.webp"; done
#    rm *.jpeg
#    chmod 644 *.webp
#
# 7. Test: rebuild.sh
# 8. Commit jika build sukses
#
# CATATAN PENTING:
# - Field dengan "isi ..." atau "tulis ..." = HARUS DITULIS MANUAL
# - Field dengan teks lengkap = boleh pakai langsung
# - TIDAK BOLEH pakai loop di frontmatter! Pakai card_1, card_2, card_3
# - TIDAK BOLEH pakai array! Pakai object keys dengan angka
# - Semua section REQUIRED kecuali yang diberi label OPTIONAL
# - PENTING: Semua foto HARUS dalam format WebP untuk optimasi performa
#
# ⚠️ PERINGATAN BLOCK HTML:
# - Block HTML (block--intro.html, block--tips-praktis.html) SUDAH DIBUAT
# - JANGAN PERNAH membuat atau mengedit block HTML kecuali diminta user
# - Block akan OTOMATIS membaca data dari frontmatter yang Anda isi
# - Tugas Anda HANYA mengisi data di frontmatter section di atas
# ============================================================================

# ============================================================================
# META INFORMATION (REQUIRED)
# ============================================================================
layout: node--post
title: "isi title yang menarik, SEO-friendly (50-60 karakter)"
description: "isi meta description untuk SEO (150-160 karakter), mention topik utama, benefit, dan CTA"
date: YYYY-MM-DD  # Ganti dengan tanggal publikasi, format: 2025-11-20
category: Tutorial  # Options: Tutorial, Comparison, Guide, Tips, Review
tags:
  - "isi tag #1 (misal: kayu dolken)"
  - "isi tag #2 (misal: konstruksi)"
  - "isi tag #3 (misal: panduan)"
  - "isi tag #4 (opsional)"
author: Admin
author_url: https://jualkayudolkengelam.github.io
image: /assets/images/posts/{slug-lengkap}/{slug-lengkap}-001.webp
images:
  - /assets/images/posts/{slug-lengkap}/{slug-lengkap}-001.webp
  - /assets/images/posts/{slug-lengkap}/{slug-lengkap}-002.webp
  - /assets/images/posts/{slug-lengkap}/{slug-lengkap}-003.webp
  - /assets/images/posts/{slug-lengkap}/{slug-lengkap}-004.webp
keywords: "isi 6-8 keywords untuk SEO, pisahkan dengan koma"

# ============================================================================
# TUTORIAL META (OPTIONAL - tapi recommended untuk tutorial)
# ============================================================================
# Instruksi: Info tambahan untuk artikel tutorial
tutorial_meta_section:
  difficulty: "Pemula"  # Options: Pemula, Menengah, Lanjut
  estimated_time: "30 menit"  # Estimasi waktu mengerjakan tutorial
  tools_needed:
    - "isi alat yang dibutuhkan #1 (misal: Meteran)"
    - "isi alat yang dibutuhkan #2 (misal: Kalkulator)"
    - "isi alat yang dibutuhkan #3 (opsional)"

# ============================================================================
# SOCIAL METRICS (REQUIRED)
# ============================================================================
like_count: 0
comment_count: 0
share_count: 0

# ============================================================================
# INTRO SECTION (REQUIRED)
# ============================================================================
# Instruksi: Section pembuka artikel, jelaskan overview dan highlight points
# NOTE: Nama key "intro" sesuai dengan HTML id="intro"
intro:
  headline: "isi headline catchy untuk intro section (1 kalimat singkat)"
  deskripsi: "isi deskripsi pembuka artikel (2-3 kalimat), jelaskan apa yang akan dipelajari pembaca"
  highlight_title: "isi judul section highlight (OPTIONAL - hapus jika tidak perlu, default: Yang Akan Anda Pelajari:)"
  highlight_points:
    - "isi highlight point #1 (benefit atau key takeaway)"
    - "isi highlight point #2"
    - "isi highlight point #3"
    - "isi highlight point #4 (opsional)"

# ============================================================================
# TIPS PRAKTIS SECTION (REQUIRED) - HARDCODED, NO LOOP!
# ============================================================================
# Instruksi: Section tips praktis dengan 3 cards hardcoded
# NOTE: Nama key "tips_praktis" sesuai dengan HTML id="tips-praktis"
tips_praktis:
  # H2: Main Section Header
  title: "isi judul H2 section tips praktis (misal: Tips Praktis yang Perlu Diketahui)"
  subtitle: "isi subtitle di bawah title (OPTIONAL - hapus jika tidak perlu, misal: Panduan praktis untuk hasil maksimal)"
  intro: "isi 1-2 paragraf intro untuk section tips praktis, jelaskan mengapa tips ini penting"
  icon: "bi-lightbulb"  # Bootstrap icon
  gradient: "warning"  # Options: primary, info, warning, success, danger, wood

  # H3 Overview (OPTIONAL - hapus jika tidak perlu)
  overview_title: "isi judul H3 overview (misal: Poin-Poin Penting)"
  overview_subtitle: "isi subtitle singkat untuk overview"
  overview_icon: "bi-check-circle-fill"
  overview_color: "warning"

  # CARD 1 - HARDCODED
  card_1:
    title: "isi judul H3 card #1 (misal: Persiapan Sebelum Memulai)"
    icon: "bi-clipboard-check-fill"
    color: "primary"

    # 2 Paragraphs per card
    paragraph_1: "isi paragraf 1 di bawah H3 card #1, jelaskan tip pertama secara umum"
    paragraph_2: "isi paragraf 2 di bawah H3 card #1, lanjutkan penjelasan atau tambahkan konteks"

    # 3 Details per card - HARDCODED
    detail_1:
      h4: "isi judul H4 detail #1 (misal: Cek Kondisi Material)"
      paragraph: "isi 1 paragraf konten untuk detail #1, jelaskan secara spesifik"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Siapkan Alat yang Tepat)"
      paragraph: "isi 1 paragraf konten untuk detail #2, berikan tips spesifik"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Ukur dengan Teliti)"
      paragraph: "isi 1 paragraf konten untuk detail #3, tambahkan tips praktis"

  # CARD 2 - HARDCODED
  card_2:
    title: "isi judul H3 card #2 (misal: Kesalahan yang Harus Dihindari)"
    icon: "bi-exclamation-triangle-fill"
    color: "danger"

    paragraph_1: "isi paragraf 1 card #2, jelaskan kesalahan umum yang sering terjadi"
    paragraph_2: "isi paragraf 2 card #2, jelaskan dampak dari kesalahan tersebut"

    detail_1:
      h4: "isi judul H4 detail #1 (misal: Mengabaikan Ukuran)"
      paragraph: "isi konten detail #1, jelaskan kesalahan spesifik dan solusinya"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Tidak Mengecek Kualitas)"
      paragraph: "isi konten detail #2, jelaskan kesalahan dan cara menghindarinya"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Skip Tahap Persiapan)"
      paragraph: "isi konten detail #3, jelaskan dampak dan solusi"

  # CARD 3 - HARDCODED
  card_3:
    title: "isi judul H3 card #3 (misal: Tips Menghemat Budget)"
    icon: "bi-piggy-bank-fill"
    color: "success"

    paragraph_1: "isi paragraf 1 card #3, jelaskan cara menghemat biaya"
    paragraph_2: "isi paragraf 2 card #3, berikan tips tambahan untuk efisiensi"

    detail_1:
      h4: "isi judul H4 detail #1 (misal: Hitung Kebutuhan Akurat)"
      paragraph: "isi konten detail #1, jelaskan cara menghitung dengan tepat"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Beli dalam Jumlah Optimal)"
      paragraph: "isi konten detail #2, jelaskan strategi pembelian"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Manfaatkan Promo dan Diskon)"
      paragraph: "isi konten detail #3, berikan tips mendapatkan harga terbaik"

# ============================================================================
# MENGENAL UKURAN SECTION (OPTIONAL) - HARDCODED, NO LOOP!
# ============================================================================
# Instruksi: Section mengenal ukuran dengan 5 cards hardcoded
# NOTE: Nama key "mengenal_ukuran" sesuai dengan HTML id="mengenal-ukuran"
# Layout: 4 cards (col-lg-6) + 1 card (col-lg-12)
mengenal_ukuran:
  # H2: Main Section Header
  title: "isi judul H2 section mengenal ukuran (misal: Mengenal Ukuran Kayu Dolken)"
  subtitle: "isi subtitle di bawah title (OPTIONAL - hapus jika tidak perlu, misal: Pilih ukuran yang sesuai kebutuhan proyek Anda)"
  intro: "isi 1-2 paragraf intro untuk section mengenal ukuran, jelaskan pentingnya memilih ukuran yang tepat"
  icon: "bi-rulers"  # Bootstrap icon
  gradient: "primary"  # Options: primary, info, warning, success, danger, wood

  # H3 Overview (OPTIONAL - hapus jika tidak perlu)
  overview_title: "isi judul H3 overview (misal: Variasi Ukuran yang Tersedia)"
  overview_subtitle: "isi subtitle singkat untuk overview"
  overview_icon: "bi-info-circle-fill"
  overview_color: "primary"

  # CARD 1 - HARDCODED (col-lg-6)
  card_1:
    title: "isi judul H3 card #1 (misal: Dolken Diameter 2-3 cm)"
    icon: "bi-rulers"
    color: "primary"

    # 2 Paragraphs per card
    paragraph_1: "isi paragraf 1 di bawah H3 card #1, jelaskan karakteristik ukuran ini"
    paragraph_2: "isi paragraf 2 di bawah H3 card #1, lanjutkan penjelasan atau tambahkan konteks"

    # 3 Details per card - HARDCODED
    detail_1:
      h4: "isi judul H4 detail #1 (misal: Kegunaan Utama)"
      paragraph: "isi 1 paragraf konten untuk detail #1, jelaskan untuk apa ukuran ini digunakan"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Kelebihan)"
      paragraph: "isi 1 paragraf konten untuk detail #2, jelaskan keunggulan ukuran ini"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Rekomendasi Proyek)"
      paragraph: "isi 1 paragraf konten untuk detail #3, berikan rekomendasi proyek yang cocok"

  # CARD 2 - HARDCODED (col-lg-6)
  card_2:
    title: "isi judul H3 card #2 (misal: Dolken Diameter 4-6 cm)"
    icon: "bi-rulers"
    color: "info"

    # 2 Paragraphs per card
    paragraph_1: "isi paragraf 1 card #2, jelaskan karakteristik ukuran 4-6 cm"
    paragraph_2: "isi paragraf 2 card #2, lanjutkan penjelasan tentang ukuran ini"

    detail_1:
      h4: "isi judul H4 detail #1 (misal: Kegunaan Utama)"
      paragraph: "isi konten detail #1, jelaskan penggunaan ukuran ini"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Kelebihan)"
      paragraph: "isi konten detail #2, jelaskan keunggulan ukuran ini"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Rekomendasi Proyek)"
      paragraph: "isi konten detail #3, berikan rekomendasi proyek"

  # CARD 3 - HARDCODED (col-lg-6)
  card_3:
    title: "isi judul H3 card #3 (misal: Dolken Diameter 6-8 cm)"
    icon: "bi-rulers"
    color: "success"

    # 2 Paragraphs per card
    paragraph_1: "isi paragraf 1 card #3, jelaskan karakteristik ukuran 6-8 cm"
    paragraph_2: "isi paragraf 2 card #3, lanjutkan penjelasan tentang ukuran ini"

    detail_1:
      h4: "isi judul H4 detail #1 (misal: Kegunaan Utama)"
      paragraph: "isi konten detail #1, jelaskan penggunaan ukuran ini"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Kelebihan)"
      paragraph: "isi konten detail #2, jelaskan keunggulan ukuran ini"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Rekomendasi Proyek)"
      paragraph: "isi konten detail #3, berikan rekomendasi proyek"

  # CARD 4 - HARDCODED (col-lg-6)
  card_4:
    title: "isi judul H3 card #4 (misal: Dolken Diameter 8-10 cm)"
    icon: "bi-rulers"
    color: "warning"

    # 2 Paragraphs per card
    paragraph_1: "isi paragraf 1 card #4, jelaskan karakteristik ukuran 8-10 cm"
    paragraph_2: "isi paragraf 2 card #4, lanjutkan penjelasan tentang ukuran ini"

    detail_1:
      h4: "isi judul H4 detail #1 (misal: Kegunaan Utama)"
      paragraph: "isi konten detail #1, jelaskan penggunaan ukuran ini"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Kelebihan)"
      paragraph: "isi konten detail #2, jelaskan keunggulan ukuran ini"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Rekomendasi Proyek)"
      paragraph: "isi konten detail #3, berikan rekomendasi proyek"

  # CARD 5 - HARDCODED (col-lg-12 FULL WIDTH)
  card_5:
    title: "isi judul H3 card #5 (misal: Dolken Diameter 10-12 cm)"
    icon: "bi-rulers"
    color: "danger"

    # 2 Paragraphs per card
    paragraph_1: "isi paragraf 1 card #5, jelaskan karakteristik ukuran 10-12 cm (ukuran terbesar)"
    paragraph_2: "isi paragraf 2 card #5, lanjutkan penjelasan tentang ukuran premium ini"

    detail_1:
      h4: "isi judul H4 detail #1 (misal: Kegunaan Utama)"
      paragraph: "isi konten detail #1, jelaskan penggunaan ukuran terbesar ini"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Kelebihan)"
      paragraph: "isi konten detail #2, jelaskan keunggulan ukuran premium ini"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Rekomendasi Proyek)"
      paragraph: "isi konten detail #3, berikan rekomendasi proyek yang cocok untuk ukuran besar"

# ============================================================================
# PANDUAN PEMILIHAN SECTION (OPTIONAL) - HARDCODED, NO LOOP!
# ============================================================================
# Instruksi: Section panduan pemilihan dengan 5 cards hardcoded
# NOTE: Nama key "panduan_pemilihan" sesuai dengan HTML id="panduan-pemilihan"
# Layout: 4 cards (col-lg-6) + 1 card (col-lg-12)
# Format berbeda: menggunakan list aplikasi, keuntungan, dan tips
panduan_pemilihan:
  # H2: Main Section Header
  title: "isi judul H2 section panduan pemilihan (misal: Panduan Memilih Ukuran yang Tepat)"
  subtitle: "isi subtitle di bawah title (OPTIONAL - hapus jika tidak perlu, misal: Sesuaikan dengan kebutuhan proyek Anda)"
  intro: "isi 1-2 paragraf intro untuk section panduan pemilihan, jelaskan pentingnya memilih ukuran yang tepat untuk proyek"
  icon: "bi-compass"  # Bootstrap icon
  gradient: "primary"  # Options: primary, info, warning, success, danger, wood

  # H3 Overview (OPTIONAL - hapus jika tidak perlu)
  overview_title: "isi judul H3 overview (misal: Pilih Berdasarkan Kebutuhan)"
  overview_subtitle: "isi subtitle singkat untuk overview"
  overview_icon: "bi-info-circle-fill"
  overview_color: "primary"

  # CARD 1 - HARDCODED (col-lg-6)
  card_1:
    ukuran: "isi ukuran (misal: 2-3 cm)"
    kategori: "isi kategori H3 (misal: Untuk Dekorasi)"
    subtitle: "isi subtitle card (misal: Aplikasi Dekoratif)"
    warna: "info"  # Options: info, primary, success, warning, danger

    # List aplikasi (4 items dengan nama dan deskripsi)
    aplikasi:
      - nama: "isi nama aplikasi #1 (misal: Interior Hotel & Cafe)"
        deskripsi: "isi deskripsi aplikasi #1 (1 kalimat singkat)"
      - nama: "isi nama aplikasi #2 (misal: Wall Decor)"
        deskripsi: "isi deskripsi aplikasi #2"
      - nama: "isi nama aplikasi #3 (misal: Hiasan Taman)"
        deskripsi: "isi deskripsi aplikasi #3"
      - nama: "isi nama aplikasi #4 (misal: Art Installation)"
        deskripsi: "isi deskripsi aplikasi #4"

    # Keuntungan dan Tips
    keuntungan: "isi keuntungan utama ukuran ini (1 kalimat, misal: Ringan, mudah dipasang, harga terjangkau)"
    tips: "isi tips praktis untuk ukuran ini (1-2 kalimat, misal: Cocok dikombinasikan dengan elemen dekorasi lain)"

  # CARD 2 - HARDCODED (col-lg-6)
  card_2:
    ukuran: "isi ukuran (misal: 4-6 cm)"
    kategori: "isi kategori H3 (misal: Untuk Pagar & Pembatas)"
    subtitle: "isi subtitle card (misal: Fungsi Pagar dan Pembatas)"
    warna: "primary"

    aplikasi:
      - nama: "isi nama aplikasi #1 (misal: Pagar Taman Rumah)"
        deskripsi: "isi deskripsi aplikasi #1"
      - nama: "isi nama aplikasi #2 (misal: Pembatas Area)"
        deskripsi: "isi deskripsi aplikasi #2"
      - nama: "isi nama aplikasi #3 (misal: Trellis Tanaman)"
        deskripsi: "isi deskripsi aplikasi #3"
      - nama: "isi nama aplikasi #4 (misal: Dekorasi Outdoor)"
        deskripsi: "isi deskripsi aplikasi #4"

    keuntungan: "isi keuntungan utama ukuran ini (1 kalimat)"
    tips: "isi tips praktis untuk ukuran ini (1-2 kalimat)"

  # CARD 3 - HARDCODED (col-lg-6)
  card_3:
    ukuran: "isi ukuran (misal: 6-8 cm)"
    kategori: "isi kategori H3 (misal: Untuk Konstruksi Ringan)"
    subtitle: "isi subtitle card (misal: Struktur Ringan)"
    warna: "success"

    aplikasi:
      - nama: "isi nama aplikasi #1 (misal: Tiang Pergola)"
        deskripsi: "isi deskripsi aplikasi #1"
      - nama: "isi nama aplikasi #2 (misal: Gazebo Kecil)"
        deskripsi: "isi deskripsi aplikasi #2"
      - nama: "isi nama aplikasi #3 (misal: Pagar Utama)"
        deskripsi: "isi deskripsi aplikasi #3"
      - nama: "isi nama aplikasi #4 (misal: Tiang Penyangga Atap)"
        deskripsi: "isi deskripsi aplikasi #4"

    keuntungan: "isi keuntungan utama ukuran ini (1 kalimat)"
    tips: "isi tips praktis untuk ukuran ini (1-2 kalimat)"

  # CARD 4 - HARDCODED (col-lg-6)
  card_4:
    ukuran: "isi ukuran (misal: 8-10 cm)"
    kategori: "isi kategori H3 (misal: Untuk Konstruksi Sedang)"
    subtitle: "isi subtitle card (misal: Konstruksi Medium)"
    warna: "warning"

    aplikasi:
      - nama: "isi nama aplikasi #1 (misal: Pondasi Ringan)"
        deskripsi: "isi deskripsi aplikasi #1"
      - nama: "isi nama aplikasi #2 (misal: Tiang Utama Gazebo)"
        deskripsi: "isi deskripsi aplikasi #2"
      - nama: "isi nama aplikasi #3 (misal: Bridge Taman)"
        deskripsi: "isi deskripsi aplikasi #3"
      - nama: "isi nama aplikasi #4 (misal: Scaffolding)"
        deskripsi: "isi deskripsi aplikasi #4"

    keuntungan: "isi keuntungan utama ukuran ini (1 kalimat)"
    tips: "isi tips praktis untuk ukuran ini (1-2 kalimat)"

  # CARD 5 - HARDCODED (col-lg-12 FULL WIDTH)
  card_5:
    ukuran: "isi ukuran (misal: 10-12 cm)"
    kategori: "isi kategori H3 (misal: Untuk Konstruksi Berat)"
    subtitle: "isi subtitle card (misal: Proyek Skala Besar)"
    warna: "danger"

    aplikasi:
      - nama: "isi nama aplikasi #1 (misal: Pondasi Utama)"
        deskripsi: "isi deskripsi aplikasi #1"
      - nama: "isi nama aplikasi #2 (misal: Tiang Struktur Besar)"
        deskripsi: "isi deskripsi aplikasi #2"
      - nama: "isi nama aplikasi #3 (misal: Dermaga & Pier)"
        deskripsi: "isi deskripsi aplikasi #3"
      - nama: "isi nama aplikasi #4 (misal: Proyek Infrastruktur)"
        deskripsi: "isi deskripsi aplikasi #4"

    keuntungan: "isi keuntungan utama ukuran ini (1 kalimat)"
    tips: "isi tips praktis untuk ukuran ini (1-2 kalimat)"

# ============================================================================
# CARA PEMASANGAN SECTION (OPTIONAL) - HARDCODED, NO LOOP!
# ============================================================================
# Instruksi: Section cara pemasangan dengan 2 cards hardcoded
# NOTE: Nama key "cara_pemasangan" sesuai dengan HTML id="cara-pemasangan"
# Layout: 2 cards (col-lg-6 side by side)
# Format: 2 H3 (Persiapan + Instalasi), masing-masing 4 details
cara_pemasangan:
  # H2: Main Section Header
  title: "isi judul H2 section cara pemasangan (misal: Cara Memasang Kayu Dolken dengan Benar)"
  subtitle: "isi subtitle di bawah title (OPTIONAL - hapus jika tidak perlu, misal: Panduan step-by-step instalasi yang tepat)"
  intro: "isi 1-2 paragraf intro untuk section cara pemasangan, jelaskan pentingnya pemasangan yang benar"
  icon: "bi-tools"  # Bootstrap icon
  gradient: "success"  # Options: primary, info, warning, success, danger, wood

  # H3 Overview (OPTIONAL - hapus jika tidak perlu)
  overview_title: "isi judul H3 overview (misal: Tahapan Pemasangan)"
  overview_subtitle: "isi subtitle singkat untuk overview"
  overview_icon: "bi-check-circle-fill"
  overview_color: "success"

  # CARD 1: PERSIAPAN - HARDCODED (col-lg-6)
  persiapan:
    title: "isi judul H3 card persiapan (misal: Persiapan Sebelum Pemasangan)"
    icon: "bi-clipboard-check"
    color: "primary"

    # 2 Paragraphs per card
    paragraph_1: "isi paragraf 1 di bawah H3, jelaskan pentingnya persiapan yang matang"
    paragraph_2: "isi paragraf 2, lanjutkan penjelasan atau tambahkan konteks"

    # 4 Details - HARDCODED
    detail_1:
      h4: "isi judul H4 detail #1 (misal: Cek dan Sortir Material)"
      paragraph: "isi 1 paragraf konten untuk detail #1, jelaskan cara cek kualitas dan sortir dolken"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Siapkan Alat dan Perlengkapan)"
      paragraph: "isi 1 paragraf konten untuk detail #2, list alat yang dibutuhkan dan fungsinya"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Ukur dan Tandai Area Pemasangan)"
      paragraph: "isi 1 paragraf konten untuk detail #3, jelaskan teknik pengukuran yang akurat"

    detail_4:
      h4: "isi judul H4 detail #4 (misal: Persiapan Pondasi dan Base)"
      paragraph: "isi 1 paragraf konten untuk detail #4, jelaskan persiapan foundation yang kuat"

  # CARD 2: INSTALASI - HARDCODED (col-lg-6)
  instalasi:
    title: "isi judul H3 card instalasi (misal: Proses Instalasi Step-by-Step)"
    icon: "bi-hammer"
    color: "success"

    # 2 Paragraphs per card
    paragraph_1: "isi paragraf 1 di bawah H3, jelaskan overview proses instalasi"
    paragraph_2: "isi paragraf 2, tekankan pentingnya mengikuti urutan yang benar"

    # 4 Details - HARDCODED
    detail_1:
      h4: "isi judul H4 detail #1 (misal: Pasang Tiang/Dolken Pertama sebagai Base Point)"
      paragraph: "isi 1 paragraf konten untuk detail #1, jelaskan cara menentukan dan pasang tiang pertama"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Setting Jarak dan Alignment)"
      paragraph: "isi 1 paragraf konten untuk detail #2, jelaskan teknik mengatur jarak dan kelurusan"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Pengikatan dan Penguatan Struktur)"
      paragraph: "isi 1 paragraf konten untuk detail #3, jelaskan cara mengikat dolken dengan kawat atau material lain"

    detail_4:
      h4: "isi judul H4 detail #4 (misal: Finishing dan Quality Check)"
      paragraph: "isi 1 paragraf konten untuk detail #4, jelaskan tahap akhir dan cara cek kualitas hasil"

# ============================================================================
# SECTION 6: CARA MERAWAT
# ============================================================================
# Section tentang cara merawat dan memelihara kayu dolken
# Structure:
# - 1 H2 (title)
# - 4 H3 cards (card_1, card_2, card_3, card_4)
# - Each card: 2 paragraphs + 3 details (H4 + paragraph)
# ============================================================================
cara_merawat:
  title: "isi judul H2 section cara merawat (misal: Cara Merawat Kayu Dolken untuk Ketahanan Maksimal)"
  subtitle: "isi subtitle (OPTIONAL, misal: Panduan perawatan lengkap agar dolken awet bertahun-tahun)"
  intro: "isi 1-2 paragraf intro tentang pentingnya perawatan kayu dolken, manfaat perawatan rutin, dan overview aspek-aspek perawatan"
  icon: "bi-wrench-adjustable"
  gradient: "info"  # Options: primary, info, warning, success, danger, wood

  # Optional H3 Overview
  overview_title: "isi judul H3 overview (OPTIONAL, misal: Empat Aspek Perawatan Penting)"
  overview_subtitle: "isi subtitle overview (OPTIONAL)"
  overview_icon: "bi-check-circle-fill"  # OPTIONAL
  overview_color: "info"  # OPTIONAL

  # Card 1: [Tema perawatan pertama, misal: Perawatan Rutin]
  card_1:
    title: "isi judul H3 card #1 (misal: Perawatan Rutin Berkala)"
    icon: "bi-calendar-check"
    color: "primary"
    paragraph_1: "isi paragraf 1 untuk card #1, jelaskan tentang perawatan rutin yang perlu dilakukan"
    paragraph_2: "isi paragraf 2 untuk card #1, tambahkan penjelasan lebih detail atau manfaat dari perawatan rutin"

    detail_1:
      h4: "isi judul H4 detail #1 (misal: Inspeksi Visual Bulanan)"
      paragraph: "isi 1 paragraf konten untuk detail #1, jelaskan cara melakukan inspeksi visual"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Pembersihan Permukaan)"
      paragraph: "isi 1 paragraf konten untuk detail #2, jelaskan cara membersihkan permukaan dolken"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Pengecekan Kelembaban)"
      paragraph: "isi 1 paragraf konten untuk detail #3, jelaskan cara mengecek tingkat kelembaban"

  # Card 2: [Tema perawatan kedua, misal: Perlindungan dari Cuaca]
  card_2:
    title: "isi judul H3 card #2 (misal: Perlindungan dari Cuaca Ekstrem)"
    icon: "bi-cloud-rain"
    color: "success"
    paragraph_1: "isi paragraf 1 untuk card #2, jelaskan pentingnya perlindungan dari cuaca"
    paragraph_2: "isi paragraf 2 untuk card #2, tambahkan penjelasan tentang dampak cuaca pada dolken"

    detail_1:
      h4: "isi judul H4 detail #1 (misal: Coating Pelindung)"
      paragraph: "isi 1 paragraf konten untuk detail #1, jelaskan jenis coating yang cocok"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Drainase yang Baik)"
      paragraph: "isi 1 paragraf konten untuk detail #2, jelaskan pentingnya sistem drainase"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Perawatan Pasca Hujan)"
      paragraph: "isi 1 paragraf konten untuk detail #3, jelaskan langkah setelah hujan deras"

  # Card 3: [Tema perawatan ketiga, misal: Pencegahan Hama]
  card_3:
    title: "isi judul H3 card #3 (misal: Pencegahan dan Pengendalian Hama)"
    icon: "bi-bug"
    color: "warning"
    paragraph_1: "isi paragraf 1 untuk card #3, jelaskan risiko serangan hama pada dolken"
    paragraph_2: "isi paragraf 2 untuk card #3, tambahkan penjelasan tentang jenis-jenis hama yang umum"

    detail_1:
      h4: "isi judul H4 detail #1 (misal: Deteksi Dini Rayap)"
      paragraph: "isi 1 paragraf konten untuk detail #1, jelaskan cara mendeteksi rayap"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Treatment Anti-Hama)"
      paragraph: "isi 1 paragraf konten untuk detail #2, jelaskan metode treatment yang aman"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Pencegahan Alami)"
      paragraph: "isi 1 paragraf konten untuk detail #3, jelaskan metode pencegahan organik"

  # Card 4: [Tema perawatan keempat, misal: Perbaikan dan Penggantian]
  card_4:
    title: "isi judul H3 card #4 (misal: Perbaikan dan Penggantian Tepat Waktu)"
    icon: "bi-hammer"
    color: "danger"
    paragraph_1: "isi paragraf 1 untuk card #4, jelaskan kapan perlu dilakukan perbaikan atau penggantian"
    paragraph_2: "isi paragraf 2 untuk card #4, tambahkan penjelasan tentang tanda-tanda dolken perlu diganti"

    detail_1:
      h4: "isi judul H4 detail #1 (misal: Perbaikan Minor)"
      paragraph: "isi 1 paragraf konten untuk detail #1, jelaskan cara memperbaiki kerusakan kecil"

    detail_2:
      h4: "isi judul H4 detail #2 (misal: Kriteria Penggantian)"
      paragraph: "isi 1 paragraf konten untuk detail #2, jelaskan kriteria dolken yang harus diganti"

    detail_3:
      h4: "isi judul H4 detail #3 (misal: Proses Penggantian)"
      paragraph: "isi 1 paragraf konten untuk detail #3, jelaskan langkah-langkah mengganti dolken rusak"

---

<!-- Intro Section -->
<section id="intro">
  {% include posts/tutorial/block--intro.html %}
</section>

<!-- Tips Praktis Section -->
<section id="tips-praktis">
  {% include posts/tutorial/block--tips-praktis.html %}
</section>

<!-- Mengenal Ukuran Section -->
<section id="mengenal-ukuran">
  {% include posts/tutorial/block--mengenal-ukuran.html %}
</section>

<!-- Panduan Pemilihan Section -->
<section id="panduan-pemilihan">
  {% include posts/tutorial/block--panduan-pemilihan.html %}
</section>

<!-- Cara Pemasangan Section -->
<section id="cara-pemasangan">
  {% include posts/tutorial/block--cara-pemasangan.html %}
</section>

<!-- Cara Merawat Section -->
<section id="cara-merawat">
  {% include posts/tutorial/block--cara-merawat.html %}
</section>

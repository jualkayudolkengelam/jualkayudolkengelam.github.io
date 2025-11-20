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

---

<!-- Intro Section -->
<section id="intro">
  {% include posts/tutorial/block--intro.html %}
</section>

<!-- Tips Praktis Section -->
<section id="tips-praktis">
  {% include posts/tutorial/block--tips-praktis.html %}
</section>

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
author_url: https://jualkayudolkengelam.net
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

---

<!-- Intro Section -->
<section id="intro">
  {% include components/tutorial/block--intro.html %}
</section>

<!-- Tips Praktis Section -->
<section id="tips-praktis">
  {% include components/tutorial/block--tips-praktis.html %}
</section>

<!-- Mengenal Ukuran Section -->
<section id="mengenal-ukuran">
  {% include components/tutorial/block--mengenal-ukuran.html %}
</section>

<!-- Panduan Pemilihan Section -->
<section id="panduan-pemilihan">
  {% include components/tutorial/block--panduan-pemilihan.html %}
</section>

<!-- Cara Pemasangan Section -->
<section id="cara-pemasangan">
  {% include components/tutorial/block--cara-pemasangan.html %}
</section>

<!-- Cara Merawat Section -->
<section id="cara-merawat">
  {% include components/tutorial/block--cara-merawat.html %}
</section>

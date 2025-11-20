---
# ============================================================================
# TEMPLATE: POST TUTORIAL (Format Instruksi)
# ============================================================================
# File: TEMPLATE--post-tutorial.md
# Purpose: Template untuk artikel tutorial/how-to dengan step-by-step guide
# Version: 2.0.0 (Hardcoded Structure - No Loops!)
# Date: 2025-11-20
# Example: Cara Menghitung Kebutuhan Kayu Dolken, Tutorial Pemasangan Pagar
#
# CARA PENGGUNAAN:
#
# RULE UTAMA:
# 1. Folder foto user → RENAME semua foto sesuai slug artikel!
# 2. Title → Slug HARUS LENGKAP, jangan dipotong!
# 3. HTML ID (kebab-case) → Frontmatter (snake_case) HARUS SAMA!
#
# POLA PENAMAAN (WAJIB DIIKUTI):
# HTML Section ID: <section id="intro-section">
# Block File:      block--intro-section.html
# Frontmatter:     intro_section:
#
# HTML Section ID: <section id="section-1">
# Block File:      block--section-1.html
# Frontmatter:     section_1:
#
# LANGKAH:
# 1. Tentukan JUDUL artikel (dari user atau tentukan sendiri)
# 2. Buat SLUG dari judul LENGKAP (lowercase, spasi jadi dash)
#    Contoh: "Cara Memasang Pagar Dolken untuk Rumah Minimalis"
#         → "cara-memasang-pagar-dolken-untuk-rumah-minimalis"
#    JANGAN POTONG: "cara-memasang-pagar-dolken" ❌ SALAH!
# 3. Tulis konten artikel sesuai topik di judul
# 4. Proses foto (RENAME dari folder asalnya):
#    mkdir -p assets/images/posts/{slug}/
#    cp /path/asli/apapun-nama-folder/foto-001.jpeg assets/images/posts/{slug}/{slug}-001.jpeg
#    cp /path/asli/apapun-nama-folder/foto-002.jpeg assets/images/posts/{slug}/{slug}-002.jpeg
#    cp /path/asli/apapun-nama-folder/foto-003.jpeg assets/images/posts/{slug}/{slug}-003.jpeg
#    cp /path/asli/apapun-nama-folder/foto-004.jpeg assets/images/posts/{slug}/{slug}-004.jpeg
#    cd assets/images/posts/{slug}/
#    for file in *.jpeg; do cwebp -q 85 "$file" -o "${file%.jpeg}.webp"; done
#    rm *.jpeg
#    chmod 644 *.webp
# 5. Test: rebuild.sh
# 6. Commit jika build sukses
#
# CATATAN PENTING:
# - Field dengan "isi ..." atau "tulis ..." = HARUS DITULIS MANUAL
# - Field dengan teks lengkap = boleh pakai langsung
# - TIDAK BOLEH pakai loop di frontmatter! Pakai card_1, card_2, card_3
# - TIDAK BOLEH pakai array! Pakai object keys dengan angka
# - Semua section REQUIRED kecuali yang diberi label OPTIONAL
# - PENTING: Semua foto HARUS dalam format WebP untuk optimasi performa
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
image: /assets/images/posts/{slug}/{slug}-001.webp
images:
  - /assets/images/posts/{slug}/{slug}-001.webp
  - /assets/images/posts/{slug}/{slug}-002.webp
  - /assets/images/posts/{slug}/{slug}-003.webp
  - /assets/images/posts/{slug}/{slug}-004.webp
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
# NOTE: Nama key "intro_section" sesuai dengan HTML id="intro-section"
intro_section:
  headline: "isi headline catchy untuk intro section (1 kalimat singkat)"
  deskripsi: "isi deskripsi pembuka artikel (2-3 kalimat), jelaskan apa yang akan dipelajari pembaca"
  highlight_points:
    - "isi highlight point #1 (benefit atau key takeaway)"
    - "isi highlight point #2"
    - "isi highlight point #3"
    - "isi highlight point #4 (opsional)"

# ============================================================================
# SECTION 1 (REQUIRED) - HARDCODED, NO LOOP!
# ============================================================================
# Instruksi: Section utama pertama dengan 3 cards hardcoded
# NOTE: Nama key "section_1" sesuai dengan HTML id="section-1"
section_1:
  # H2: Main Section Header
  title: "isi judul H2 section #1 (misal: Panduan Memilih Diameter)"
  intro: "isi 1 paragraf intro untuk section ini"
  icon: "bi-lightbulb-fill"  # Bootstrap icon
  gradient: "primary"  # Options: primary, info, warning, success, danger, wood

  # H3 Overview (OPTIONAL - hapus jika tidak perlu)
  overview_title: "isi judul H3 overview (misal: Poin-Poin Penting)"
  overview_subtitle: "isi subtitle singkat"
  overview_icon: "bi-stars"
  overview_color: "primary"

  # CARD 1 - HARDCODED
  card_1:
    title: "isi judul H3 card #1"
    icon: "bi-award-fill"
    color: "warning"

    # 2 Paragraphs per card
    paragraph_1: "isi paragraf 1 di bawah H3 card #1"
    paragraph_2: "isi paragraf 2 di bawah H3 card #1"

    # 3 Details per card - HARDCODED
    detail_1:
      h4: "isi judul H4 detail #1"
      paragraph: "isi 1 paragraf konten untuk detail #1"

    detail_2:
      h4: "isi judul H4 detail #2"
      paragraph: "isi 1 paragraf konten untuk detail #2"

    detail_3:
      h4: "isi judul H4 detail #3"
      paragraph: "isi 1 paragraf konten untuk detail #3"

  # CARD 2 - HARDCODED
  card_2:
    title: "isi judul H3 card #2"
    icon: "bi-check-circle-fill"
    color: "success"

    paragraph_1: "isi paragraf 1 card #2"
    paragraph_2: "isi paragraf 2 card #2"

    detail_1:
      h4: "isi judul H4 detail #1"
      paragraph: "isi konten detail #1"

    detail_2:
      h4: "isi judul H4 detail #2"
      paragraph: "isi konten detail #2"

    detail_3:
      h4: "isi judul H4 detail #3"
      paragraph: "isi konten detail #3"

  # CARD 3 - HARDCODED
  card_3:
    title: "isi judul H3 card #3"
    icon: "bi-lightbulb-fill"
    color: "info"

    paragraph_1: "isi paragraf 1 card #3"
    paragraph_2: "isi paragraf 2 card #3"

    detail_1:
      h4: "isi judul H4 detail #1"
      paragraph: "isi konten detail #1"

    detail_2:
      h4: "isi judul H4 detail #2"
      paragraph: "isi konten detail #2"

    detail_3:
      h4: "isi judul H4 detail #3"
      paragraph: "isi konten detail #3"

# ============================================================================
# SECTION 2 (REQUIRED) - HARDCODED, NO LOOP!
# ============================================================================
# NOTE: Nama key "section_2" sesuai dengan HTML id="section-2"
section_2:
  title: "isi judul H2 section #2"
  intro: "isi 1 paragraf intro untuk section #2"
  icon: "bi-gear-fill"
  gradient: "info"

  overview_title: "isi judul H3 overview"
  overview_subtitle: "isi subtitle overview"
  overview_icon: "bi-list-check"
  overview_color: "info"

  # CARD 1
  card_1:
    title: "isi judul H3 card #1"
    icon: "bi-tools"
    color: "primary"
    paragraph_1: "isi paragraf 1"
    paragraph_2: "isi paragraf 2"
    detail_1:
      h4: "isi H4 detail #1"
      paragraph: "isi konten"
    detail_2:
      h4: "isi H4 detail #2"
      paragraph: "isi konten"
    detail_3:
      h4: "isi H4 detail #3"
      paragraph: "isi konten"

  # CARD 2
  card_2:
    title: "isi judul H3 card #2"
    icon: "bi-clipboard-check"
    color: "success"
    paragraph_1: "isi paragraf 1"
    paragraph_2: "isi paragraf 2"
    detail_1:
      h4: "isi H4 detail #1"
      paragraph: "isi konten"
    detail_2:
      h4: "isi H4 detail #2"
      paragraph: "isi konten"
    detail_3:
      h4: "isi H4 detail #3"
      paragraph: "isi konten"

  # CARD 3
  card_3:
    title: "isi judul H3 card #3"
    icon: "bi-star-fill"
    color: "warning"
    paragraph_1: "isi paragraf 1"
    paragraph_2: "isi paragraf 2"
    detail_1:
      h4: "isi H4 detail #1"
      paragraph: "isi konten"
    detail_2:
      h4: "isi H4 detail #2"
      paragraph: "isi konten"
    detail_3:
      h4: "isi H4 detail #3"
      paragraph: "isi konten"

# ============================================================================
# SECTION 3 (RECOMMENDED) - HARDCODED, NO LOOP!
# ============================================================================
# NOTE: Nama key "section_3" sesuai dengan HTML id="section-3"
section_3:
  title: "isi judul H2 section #3"
  intro: "isi 1 paragraf intro untuk section #3"
  icon: "bi-trophy-fill"
  gradient: "success"

  overview_title: "isi judul H3 overview"
  overview_subtitle: "isi subtitle overview"
  overview_icon: "bi-bookmark-star"
  overview_color: "success"

  # CARD 1
  card_1:
    title: "isi judul H3 card #1"
    icon: "bi-patch-check-fill"
    color: "success"
    paragraph_1: "isi paragraf 1"
    paragraph_2: "isi paragraf 2"
    detail_1:
      h4: "isi H4 detail #1"
      paragraph: "isi konten"
    detail_2:
      h4: "isi H4 detail #2"
      paragraph: "isi konten"
    detail_3:
      h4: "isi H4 detail #3"
      paragraph: "isi konten"

  # CARD 2
  card_2:
    title: "isi judul H3 card #2"
    icon: "bi-heart-fill"
    color: "danger"
    paragraph_1: "isi paragraf 1"
    paragraph_2: "isi paragraf 2"
    detail_1:
      h4: "isi H4 detail #1"
      paragraph: "isi konten"
    detail_2:
      h4: "isi H4 detail #2"
      paragraph: "isi konten"
    detail_3:
      h4: "isi H4 detail #3"
      paragraph: "isi konten"

  # CARD 3
  card_3:
    title: "isi judul H3 card #3"
    icon: "bi-diagram-3-fill"
    color: "info"
    paragraph_1: "isi paragraf 1"
    paragraph_2: "isi paragraf 2"
    detail_1:
      h4: "isi H4 detail #1"
      paragraph: "isi konten"
    detail_2:
      h4: "isi H4 detail #2"
      paragraph: "isi konten"
    detail_3:
      h4: "isi H4 detail #3"
      paragraph: "isi konten"

# ============================================================================
# TIPS SECTION (OPTIONAL - recommended untuk tutorial)
# ============================================================================
# Instruksi: Tips praktis untuk hasil optimal
# NOTE: Nama key "tips_section" sesuai dengan HTML id="tips-section"
tips_section:
  - judul: "isi judul tip #1 (misal: Ukur Dua Kali, Potong Sekali)"
    deskripsi: "isi penjelasan tip #1, berikan advice praktis"
    icon: "bi-lightbulb-fill"
    color: "warning"

  - judul: "isi judul tip #2"
    deskripsi: "isi penjelasan tip #2"
    icon: "bi-star-fill"
    color: "success"

  - judul: "isi judul tip #3 (opsional)"
    deskripsi: "isi penjelasan tip #3"
    icon: "bi-award-fill"
    color: "info"

# ============================================================================
# COMMON MISTAKES (OPTIONAL - recommended untuk tutorial)
# ============================================================================
# Instruksi: Kesalahan umum dan cara menghindarinya
# NOTE: Nama key "common_mistakes_section" sesuai dengan HTML id="common-mistakes-section"
# Note: Gunakan 4 items untuk tampilan seimbang (2 rows × 2 columns)
common_mistakes_section:
  - mistake: "isi kesalahan umum #1 (misal: Tidak Menambahkan Buffer)"
    solution: "isi solusi untuk kesalahan #1, jelaskan cara yang benar"
    severity: "danger"

  - mistake: "isi kesalahan umum #2"
    solution: "isi solusi untuk kesalahan #2"
    severity: "warning"

  - mistake: "isi kesalahan umum #3"
    solution: "isi solusi untuk kesalahan #3"
    severity: "info"

  - mistake: "isi kesalahan umum #4"
    solution: "isi solusi untuk kesalahan #4"
    severity: "warning"

# ============================================================================
# CALCULATOR TOOL (OPTIONAL - jika ada kalkulator interaktif)
# ============================================================================
# Instruksi: Konfigurasi untuk kalkulator tool (jika ada)
# NOTE: Nama key "calculator_section" sesuai dengan HTML id="calculator-section"
calculator_section:
  show: false  # true untuk menampilkan kalkulator
  title: "Kalkulator Kebutuhan Kayu Dolken"
  description: "Hitung kebutuhan kayu dolken untuk proyek Anda secara otomatis"
  inputs:
    - name: "panjang"
      label: "Panjang Area (meter)"
      type: "number"
      placeholder: "10"
    - name: "jarak"
      label: "Jarak Antar Dolken (cm)"
      type: "number"
      placeholder: "15"
  formula: "(panjang * 100) / jarak"
  result_label: "Jumlah Batang Dibutuhkan"

# ============================================================================
# KESIMPULAN SECTION (REQUIRED)
# ============================================================================
# Instruksi: Rangkuman akhir artikel dengan key takeaways dan CTA
# NOTE: Nama key "kesimpulan_section" sesuai dengan HTML id="kesimpulan-section"
kesimpulan_section:
  ringkasan: "isi ringkasan akhir artikel (2-3 kalimat), recap poin-poin utama"
  key_takeaways:
    - "isi key takeaway #1 (poin penting yang harus diingat pembaca)"
    - "isi key takeaway #2"
    - "isi key takeaway #3"
    - "isi key takeaway #4 (opsional)"
  cta: "isi call-to-action (1 kalimat), ajak pembaca untuk bertindak atau hubungi 081311400177"

# ============================================================================
# FAQ SECTION (OPTIONAL - tapi recommended untuk SEO)
# ============================================================================
# Instruksi: Pertanyaan umum terkait topik artikel
# NOTE: Nama key "faq_section" sesuai dengan HTML id="faq-section"
faq_section:
  - pertanyaan: "isi pertanyaan umum #1 yang relevan dengan topik artikel?"
    jawaban: "isi jawaban lengkap untuk pertanyaan #1, bisa 2-3 kalimat"
    icon: "bi-question-circle"

  - pertanyaan: "isi pertanyaan umum #2?"
    jawaban: "isi jawaban lengkap untuk pertanyaan #2"
    icon: "bi-chat-dots"

  - pertanyaan: "isi pertanyaan umum #3?"
    jawaban: "isi jawaban lengkap untuk pertanyaan #3"
    icon: "bi-info-circle"

# ============================================================================
# RELATED PRODUCTS (OPTIONAL)
# ============================================================================
# Instruksi: Link ke produk terkait, bisa dihapus jika tidak relevan
# NOTE: Nama key "related_products_section" sesuai dengan HTML id="related-products-section"
related_products_section:
  show: true  # true atau false
  title: "Produk Terkait"
  products:
    - title: "Kayu Dolken Gelam Diameter 2-3 cm"
      url: "/kayu-dolken-gelam-diameter-2-3-cm"
      image: "/assets/images/products/2-3cm/thumbnail.webp"
    - title: "Kayu Dolken Gelam Diameter 8-10 cm"
      url: "/kayu-dolken-gelam-diameter-8-10-cm"
      image: "/assets/images/products/8-10cm/thumbnail.webp"

# ============================================================================
# CALL TO ACTION (OPTIONAL)
# ============================================================================
# Instruksi: CTA khusus di akhir artikel
# NOTE: Nama key "cta_box_section" sesuai dengan HTML id="cta-box-section"
cta_box_section:
  show: true
  title: "Butuh Konsultasi?"
  description: "Hubungi kami untuk konsultasi gratis seputar kebutuhan kayu dolken Anda"
  button_text: "Hubungi Sekarang"
  button_url: "https://wa.me/6281311400177"
  icon: "bi-whatsapp"
  color: "success"

---

<!-- ========================================================================
     CONTENT SECTION - TUTORIAL BLOCKS
     Bagian ini adalah template untuk artikel tutorial
     Block-block HARDCODED, TIDAK PAKAI LOOP!
     ======================================================================== -->

<!-- Intro Section -->
<section id="intro-section">
  {% include posts/tutorial/block--intro-section.html %}
</section>

<!-- Tutorial Meta (difficulty, time, tools) -->
{% if page.tutorial_meta_section %}
<section id="tutorial-meta-section">
  {% include posts/tutorial/block--tutorial-meta.html %}
</section>
{% endif %}

<!-- Section 1 - HARDCODED -->
<section id="section-1" class="content-section">
  {% include posts/tutorial/block--section-1.html %}
</section>

<!-- Section 2 - HARDCODED -->
<section id="section-2" class="content-section">
  {% include posts/tutorial/block--section-2.html %}
</section>

<!-- Section 3 - HARDCODED -->
<section id="section-3" class="content-section">
  {% include posts/tutorial/block--section-3.html %}
</section>

<!-- Tips Section (Tutorial specific) -->
{% if page.tips_section %}
<section id="tips-section">
  {% include posts/tutorial/block--tips-list.html %}
</section>
{% endif %}

<!-- Common Mistakes Section (Tutorial specific) -->
{% if page.common_mistakes_section %}
<section id="common-mistakes-section">
  {% include posts/tutorial/block--common-mistakes.html %}
</section>
{% endif %}

<!-- Calculator Tool (Tutorial specific) -->
{% if page.calculator_section.show %}
<section id="calculator-section">
  {% include posts/tutorial/block--calculator-tool.html %}
</section>
{% endif %}

<!-- Image Carousel (if multiple images) -->
{% if page.images.size > 1 %}
<section id="image-carousel-section">
  {% include posts/tutorial/block--image-carousel.html %}
</section>
{% endif %}

<!-- Kesimpulan Section -->
<section id="kesimpulan-section">
  {% include posts/tutorial/block--kesimpulan.html %}
</section>

<!-- FAQ Section -->
{% if page.faq_section %}
<section id="faq-section">
  {% include posts/tutorial/block--faq.html %}
</section>
{% endif %}

<!-- Related Products -->
{% if page.related_products_section.show %}
<section id="related-products-section">
  {% include posts/tutorial/block--related-products.html %}
</section>
{% endif %}

<!-- CTA Box -->
{% if page.cta_box_section.show %}
<section id="cta-box-section">
  {% include posts/tutorial/block--cta-box.html %}
</section>
{% endif %}

<!-- Social Sharing -->
<section id="social-sharing-section">
  {% include posts/tutorial/block--social-sharing.html %}
</section>

---
# ============================================================================
# TEMPLATE: POST TUTORIAL (Format Instruksi)
# ============================================================================
# File: TEMPLATE--post-tutorial.md
# Purpose: Template untuk artikel tutorial/how-to dengan step-by-step guide
# Version: 1.0.0 (Tutorial Template)
# Date: 2025-11-20
# Example: Cara Menghitung Kebutuhan Kayu Dolken, Tutorial Pemasangan Pagar
#
# CARA PENGGUNAAN:
#
# RULE UTAMA:
# APAPUN nama folder foto user, APAPUN nama file asal → RENAME sesuai slug artikel!
#
# LANGKAH:
# 1. Tentukan JUDUL artikel (dari user atau tentukan sendiri)
# 2. Buat SLUG dari judul (lowercase, spasi jadi dash)
#    Contoh: "Cara Memasang Pagar Dolken" → "cara-memasang-pagar-dolken"
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
# CONTOH:
# User kasih: /Documents/FOTO/gambar1.jpg, gambar2.jpg
# Judul artikel: "Cara Memasang Pagar Dolken"
# Slug: "cara-memasang-pagar-dolken"
# Hasil: assets/images/posts/cara-memasang-pagar-dolken/cara-memasang-pagar-dolken-001.webp
#
# CATATAN PENTING:
# - Field dengan "isi ..." atau "tulis ..." atau "berikan ..." = HARUS DITULIS MANUAL
# - Field dengan teks lengkap = boleh pakai langsung
# - Jangan ubah struktur frontmatter (nama field, hierarki, indentasi)
# - Semua section REQUIRED kecuali yang diberi label OPTIONAL
# - PENTING: Semua foto HARUS dalam format WebP untuk optimasi performa
# - STRICT: Setiap section HARUS punya exactly 3 cards, setiap card punya 3 details
# ============================================================================

# ============================================================================
# META INFORMATION (REQUIRED)
# ============================================================================
layout: node--post
title: "tulis title yang menarik, SEO-friendly (50-60 karakter)"
description: "tulis meta description untuk SEO (150-160 karakter), mention topik utama, benefit, dan CTA"
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
keywords: "tulis 6-8 keywords untuk SEO, pisahkan dengan koma"

# ============================================================================
# TUTORIAL META (OPTIONAL - tapi recommended untuk tutorial)
# ============================================================================
# Instruksi: Info tambahan untuk artikel tutorial
tutorial_meta:
  difficulty: "Pemula"  # Options: Pemula, Menengah, Lanjut
  estimated_time: "30 menit"  # Estimasi waktu mengerjakan tutorial
  tools_needed:
    - "tulis alat yang dibutuhkan #1 (misal: Meteran)"
    - "tulis alat yang dibutuhkan #2 (misal: Kalkulator)"
    - "tulis alat yang dibutuhkan #3 (opsional)"

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
intro:
  headline: "tulis headline catchy untuk intro section (1 kalimat singkat)"
  deskripsi: "tulis deskripsi pembuka artikel (2-3 kalimat), jelaskan apa yang akan dipelajari pembaca"
  highlight_points:
    - "tulis highlight point #1 (benefit atau key takeaway)"
    - "tulis highlight point #2"
    - "tulis highlight point #3"
    - "tulis highlight point #4 (opsional)"

# ============================================================================
# CONTENT SECTIONS (REQUIRED - min 1 section, recommend 3-5 sections)
# ============================================================================
# Instruksi:
# - Setiap section mengikuti strict hierarchy: H2 → 3×H3 cards → 3×H4 details
# - WAJIB: exactly 3 cards per section
# - WAJIB: exactly 3 details per card
# - WAJIB: 2 paragraphs per card
# - CSS selectors (id, css_class) OPTIONAL tapi recommended untuk styling

sections:
  # ========================================================================
  # SECTION #1 (REQUIRED)
  # ========================================================================
  - section:
      # CSS Selectors (OPTIONAL - for custom styling)
      id: "isi-id-unik-section-ini"  # Format: kebab-case, contoh: "keunggulan-utama"
      css_class: "isi-css-class"     # Opsional: "section-premium" atau "featured-section"

      # H2: Main Section Header (REQUIRED)
      title: "tulis judul H2 section #1 (misal: Keunggulan Utama, Panduan Lengkap)"
      intro: "tulis 1 paragraf intro untuk section ini, jelaskan overview section"
      icon: "bi-lightbulb-fill"  # Bootstrap icon, pilih yang sesuai konteks
      gradient: "primary"  # Options: primary, info, warning, success, danger, wood

      # H3: Overview Header (OPTIONAL - bisa dihapus jika tidak perlu)
      overview:
        id: "overview-section-1"      # OPTIONAL
        css_class: "overview-highlight" # OPTIONAL
        title: "tulis judul H3 overview (misal: Poin-Poin Penting)"
        subtitle: "tulis subtitle singkat untuk overview"
        icon: "bi-stars"
        color: "primary"  # Options: primary, info, warning, success, danger, wood

      # Cards: EXACTLY 3 cards (REQUIRED)
      cards:
        # CARD #1 (REQUIRED)
        - id: "card-1-section-1"           # OPTIONAL: Format kebab-case
          css_class: "feature-card"        # OPTIONAL: Custom classes
          title: "tulis judul H3 card #1 (misal: Poin Pertama, Langkah Awal)"
          icon: "bi-award-fill"
          color: "warning"

          # Paragraphs: EXACTLY 2 (REQUIRED)
          paragraphs:
            - "tulis paragraf 1 di bawah H3 card #1 (jelaskan poin utama)"
            - "tulis paragraf 2 di bawah H3 card #1 (detail tambahan atau contoh)"

          # Details: EXACTLY 3 H4 items (REQUIRED)
          details:
            - id: "detail-1-card-1"        # OPTIONAL
              css_class: "detail-highlight" # OPTIONAL
              h4: "tulis judul H4 detail #1 (misal: Aspek Pertama, Sub-poin A)"
              paragraph: "tulis 1 paragraf konten untuk detail #1"

            - h4: "tulis judul H4 detail #2"
              paragraph: "tulis 1 paragraf konten untuk detail #2"

            - h4: "tulis judul H4 detail #3"
              paragraph: "tulis 1 paragraf konten untuk detail #3"

        # CARD #2 (REQUIRED)
        - id: "card-2-section-1"
          css_class: "feature-card"
          title: "tulis judul H3 card #2"
          icon: "bi-check-circle-fill"
          color: "success"

          paragraphs:
            - "tulis paragraf 1 card #2"
            - "tulis paragraf 2 card #2"

          details:
            - h4: "tulis judul H4 detail #1"
              paragraph: "tulis 1 paragraf konten"
            - h4: "tulis judul H4 detail #2"
              paragraph: "tulis 1 paragraf konten"
            - h4: "tulis judul H4 detail #3"
              paragraph: "tulis 1 paragraf konten"

        # CARD #3 (REQUIRED)
        - id: "card-3-section-1"
          css_class: "feature-card"
          title: "tulis judul H3 card #3"
          icon: "bi-lightbulb-fill"
          color: "info"

          paragraphs:
            - "tulis paragraf 1 card #3"
            - "tulis paragraf 2 card #3"

          details:
            - h4: "tulis judul H4 detail #1"
              paragraph: "tulis 1 paragraf konten"
            - h4: "tulis judul H4 detail #2"
              paragraph: "tulis 1 paragraf konten"
            - h4: "tulis judul H4 detail #3"
              paragraph: "tulis 1 paragraf konten"

  # ========================================================================
  # SECTION #2 (REQUIRED)
  # ========================================================================
  - section:
      id: "isi-id-section-2"
      css_class: "isi-css-class-section-2"

      title: "tulis judul H2 section #2"
      intro: "tulis 1 paragraf intro untuk section #2"
      icon: "bi-gear-fill"
      gradient: "info"

      overview:
        title: "tulis judul H3 overview section #2"
        subtitle: "tulis subtitle overview"
        icon: "bi-list-check"
        color: "info"

      cards:
        - title: "tulis judul H3 card #1 section #2"
          icon: "bi-tools"
          color: "primary"
          paragraphs:
            - "tulis paragraf 1"
            - "tulis paragraf 2"
          details:
            - h4: "tulis H4 detail #1"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #2"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #3"
              paragraph: "tulis konten"

        - title: "tulis judul H3 card #2 section #2"
          icon: "bi-clipboard-check"
          color: "success"
          paragraphs:
            - "tulis paragraf 1"
            - "tulis paragraf 2"
          details:
            - h4: "tulis H4 detail #1"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #2"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #3"
              paragraph: "tulis konten"

        - title: "tulis judul H3 card #3 section #2"
          icon: "bi-star-fill"
          color: "warning"
          paragraphs:
            - "tulis paragraf 1"
            - "tulis paragraf 2"
          details:
            - h4: "tulis H4 detail #1"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #2"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #3"
              paragraph: "tulis konten"

  # ========================================================================
  # SECTION #3 (RECOMMENDED)
  # ========================================================================
  - section:
      id: "isi-id-section-3"
      title: "tulis judul H2 section #3"
      intro: "tulis 1 paragraf intro untuk section #3"
      icon: "bi-trophy-fill"
      gradient: "success"

      overview:
        title: "tulis judul H3 overview section #3"
        subtitle: "tulis subtitle overview"
        icon: "bi-bookmark-star"
        color: "success"

      cards:
        - title: "tulis judul H3 card #1 section #3"
          icon: "bi-patch-check-fill"
          color: "success"
          paragraphs:
            - "tulis paragraf 1"
            - "tulis paragraf 2"
          details:
            - h4: "tulis H4 detail #1"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #2"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #3"
              paragraph: "tulis konten"

        - title: "tulis judul H3 card #2 section #3"
          icon: "bi-heart-fill"
          color: "danger"
          paragraphs:
            - "tulis paragraf 1"
            - "tulis paragraf 2"
          details:
            - h4: "tulis H4 detail #1"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #2"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #3"
              paragraph: "tulis konten"

        - title: "tulis judul H3 card #3 section #3"
          icon: "bi-diagram-3-fill"
          color: "info"
          paragraphs:
            - "tulis paragraf 1"
            - "tulis paragraf 2"
          details:
            - h4: "tulis H4 detail #1"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #2"
              paragraph: "tulis konten"
            - h4: "tulis H4 detail #3"
              paragraph: "tulis konten"

  # TAMBAHKAN SECTION LAIN JIKA PERLU (hingga 5-7 sections total recommended)

# ============================================================================
# TIPS SECTION (OPTIONAL - recommended untuk tutorial)
# ============================================================================
# Instruksi: Tips praktis untuk hasil optimal
tips:
  - judul: "tulis judul tip #1 (misal: Ukur Dua Kali, Potong Sekali)"
    deskripsi: "tulis penjelasan tip #1, berikan advice praktis"
    icon: "bi-lightbulb-fill"
    color: "warning"

  - judul: "tulis judul tip #2"
    deskripsi: "tulis penjelasan tip #2"
    icon: "bi-star-fill"
    color: "success"

  - judul: "tulis judul tip #3 (opsional)"
    deskripsi: "tulis penjelasan tip #3"
    icon: "bi-award-fill"
    color: "info"

# ============================================================================
# COMMON MISTAKES (OPTIONAL - recommended untuk tutorial)
# ============================================================================
# Instruksi: Kesalahan umum dan cara menghindarinya
# Note: Gunakan 4 items untuk tampilan seimbang (2 rows × 2 columns)
common_mistakes:
  - mistake: "tulis kesalahan umum #1 (misal: Tidak Menambahkan Buffer)"
    solution: "tulis solusi untuk kesalahan #1, jelaskan cara yang benar"
    severity: "danger"

  - mistake: "tulis kesalahan umum #2"
    solution: "tulis solusi untuk kesalahan #2"
    severity: "warning"

  - mistake: "tulis kesalahan umum #3"
    solution: "tulis solusi untuk kesalahan #3"
    severity: "info"

  - mistake: "tulis kesalahan umum #4"
    solution: "tulis solusi untuk kesalahan #4"
    severity: "warning"

# ============================================================================
# CALCULATOR TOOL (OPTIONAL - jika ada kalkulator interaktif)
# ============================================================================
# Instruksi: Konfigurasi untuk kalkulator tool (jika ada)
calculator:
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
kesimpulan:
  ringkasan: "tulis ringkasan akhir artikel (2-3 kalimat), recap poin-poin utama"
  key_takeaways:
    - "tulis key takeaway #1 (poin penting yang harus diingat pembaca)"
    - "tulis key takeaway #2"
    - "tulis key takeaway #3"
    - "tulis key takeaway #4 (opsional)"
  cta: "tulis call-to-action (1 kalimat), ajak pembaca untuk bertindak atau hubungi 081311400177"

# ============================================================================
# FAQ SECTION (OPTIONAL - tapi recommended untuk SEO)
# ============================================================================
# Instruksi: Pertanyaan umum terkait topik artikel
faq:
  - pertanyaan: "tulis pertanyaan umum #1 yang relevan dengan topik artikel?"
    jawaban: "tulis jawaban lengkap untuk pertanyaan #1, bisa 2-3 kalimat"
    icon: "bi-question-circle"

  - pertanyaan: "tulis pertanyaan umum #2?"
    jawaban: "tulis jawaban lengkap untuk pertanyaan #2"
    icon: "bi-chat-dots"

  - pertanyaan: "tulis pertanyaan umum #3?"
    jawaban: "tulis jawaban lengkap untuk pertanyaan #3"
    icon: "bi-info-circle"

# ============================================================================
# RELATED PRODUCTS (OPTIONAL)
# ============================================================================
# Instruksi: Link ke produk terkait, bisa dihapus jika tidak relevan
related_products:
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
cta_box:
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
     Block-block akan di-generate dari frontmatter data
     ======================================================================== -->

<!-- Intro Section -->
<section id="intro-section">
  {% include posts/tutorial/block--intro-section.html %}
</section>

<!-- Tutorial Meta (difficulty, time, tools) -->
{% if page.tutorial_meta %}
<section id="tutorial-meta">
  {% include posts/tutorial/block--tutorial-meta.html %}
</section>
{% endif %}

<!-- Main Content Sections (Loop through all sections) -->
{% for item in page.sections %}
<section id="{{ item.section.id | default: 'section' }}"
         class="content-section {{ item.section.css_class | default: '' }}">
  {% include posts/tutorial/block--content-section.html section=item.section %}
</section>
{% endfor %}

<!-- Tips Section (Tutorial specific) -->
{% if page.tips %}
<section id="tips-section">
  {% include posts/tutorial/block--tips-list.html %}
</section>
{% endif %}

<!-- Common Mistakes Section (Tutorial specific) -->
{% if page.common_mistakes %}
<section id="common-mistakes-section">
  {% include posts/tutorial/block--common-mistakes.html %}
</section>
{% endif %}

<!-- Calculator Tool (Tutorial specific) -->
{% if page.calculator.show %}
<section id="calculator-section">
  {% include posts/tutorial/block--calculator-tool.html %}
</section>
{% endif %}

<!-- Image Carousel (if multiple images) -->
{% if page.images.size > 1 %}
<section id="image-carousel">
  {% include posts/tutorial/block--image-carousel.html %}
</section>
{% endif %}

<!-- Kesimpulan Section -->
<section id="kesimpulan-section">
  {% include posts/tutorial/block--kesimpulan.html %}
</section>

<!-- FAQ Section -->
{% if page.faq %}
<section id="faq-section">
  {% include posts/tutorial/block--faq.html %}
</section>
{% endif %}

<!-- Related Products -->
{% if page.related_products.show %}
<section id="related-products">
  {% include posts/tutorial/block--related-products.html %}
</section>
{% endif %}

<!-- CTA Box -->
{% if page.cta_box.show %}
<section id="cta-box">
  {% include posts/tutorial/block--cta-box.html %}
</section>
{% endif %}

<!-- Social Sharing -->
<section id="social-sharing">
  {% include posts/tutorial/block--social-sharing.html %}
</section>

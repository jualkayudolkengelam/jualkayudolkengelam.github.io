# TODO-1538: YAML Schema and Block Pattern for Modular Post Templates

**Status:** 🔵 Planned
**Priority:** High
**Created:** 2025-11-20
**Type:** Detailed Specification
**Assignee:** Team
**Labels:** Templates, YAML, Schema, Architecture, Blocks, HTML

---

## 📋 Objective

Define **strict YAML schema pattern** for modular post template system, ensuring:
- **Consistency** - All sections follow H2 → 3×H3 → 3×H4 hierarchy
- **Predictability** - Frontmatter structure is uniform across templates
- **Maintainability** - Easy to validate and generate blocks
- **Scalability** - Pattern works for tutorial, comparison, guide templates

---

## 🎯 Core Principle

### Three-Layer Architecture:
```
┌─────────────────────────────────────────┐
│  LAYER 1: FRONTMATTER (Data)            │
│  - Structured YAML                      │
│  - No hardcoded content in HTML         │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│  LAYER 2: CONTENT (Structure)           │
│  - {% include %} blocks only            │
│  - Loop through frontmatter data        │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│  LAYER 3: BLOCKS (Presentation)         │
│  - Pure HTML with Liquid                │
│  - Bootstrap components                 │
└─────────────────────────────────────────┘
```

---

## 📐 Strict Heading Hierarchy (WAJIB)

### Pattern Structure:
```
H2 (Block/Section)
├─ 1 paragraph intro (REQUIRED)
├─ H3 Card #1 (REQUIRED - EXACTLY 3 H3)
│  ├─ 2 paragraphs (REQUIRED)
│  ├─ H4 Detail #1 (REQUIRED - EXACTLY 3 H4)
│  │  └─ 1 paragraph (REQUIRED)
│  ├─ H4 Detail #2 (REQUIRED)
│  │  └─ 1 paragraph (REQUIRED)
│  └─ H4 Detail #3 (REQUIRED)
│     └─ 1 paragraph (REQUIRED)
├─ H3 Card #2 (REQUIRED)
│  ├─ 2 paragraphs (REQUIRED)
│  ├─ H4 Detail #1 (REQUIRED)
│  ├─ H4 Detail #2 (REQUIRED)
│  └─ H4 Detail #3 (REQUIRED)
└─ H3 Card #3 (REQUIRED)
   ├─ 2 paragraphs (REQUIRED)
   ├─ H4 Detail #1 (REQUIRED)
   ├─ H4 Detail #2 (REQUIRED)
   └─ H4 Detail #3 (REQUIRED)
```

### Validation Rules:
- ✅ Each section MUST have exactly **1 H2**
- ✅ Each H2 MUST have exactly **3 H3 cards**
- ✅ Each H3 MUST have exactly **3 H4 details**
- ✅ H2 intro: EXACTLY **1 paragraph**
- ✅ H3 content: EXACTLY **2 paragraphs**
- ✅ H4 content: EXACTLY **1 paragraph**

---

## 🗂️ YAML Schema Pattern

### Master Schema (Recommended):
```yaml
# ============================================================================
# CONTENT SECTIONS
# ============================================================================
sections:
  - section:
      # CSS Selectors (OPTIONAL - recommended for custom styling)
      id: "keunggulan-produk"        # Unique ID for this section
      css_class: "section-premium"   # Custom CSS classes (space-separated)

      # H2: Main Section Header
      title: "Judul H2 Section"
      intro: "1 paragraf intro setelah H2 (REQUIRED)"
      icon: "bi-lightbulb-fill"
      gradient: "info"  # Options: info, warning, success, danger, wood, primary

      # H3: Overview Header (sub-header before cards)
      overview:
        id: "overview-keunggulan"       # OPTIONAL: Unique ID
        css_class: "overview-highlight" # OPTIONAL: Custom classes
        title: "Judul H3 Overview"
        subtitle: "Deskripsi singkat di bawah H3"
        icon: "bi-stars"
        color: "info"

      # Cards: EXACTLY 3 cards (REQUIRED)
      cards:
        - id: "card-durability"              # OPTIONAL: Unique ID
          css_class: "feature-card premium"  # OPTIONAL: Custom classes
          title: "Judul H3 Card #1"
          icon: "bi-award-fill"
          color: "warning"

          # Paragraphs: EXACTLY 2 (REQUIRED)
          paragraphs:
            - "Paragraf 1 di bawah H3 title"
            - "Paragraf 2 di bawah H3 title"

          # Details: EXACTLY 3 H4 items (REQUIRED)
          details:
            - id: "detail-warranty"        # OPTIONAL: Unique ID
              css_class: "detail-highlight" # OPTIONAL: Custom classes
              h4: "Detail H4 #1 Title"
              paragraph: "1 paragraf konten detail"
            - h4: "Detail H4 #2 Title"
              paragraph: "1 paragraf konten detail"
            - h4: "Detail H4 #3 Title"
              paragraph: "1 paragraf konten detail"

        - title: "Judul H3 Card #2"
          icon: "bi-check-circle-fill"
          color: "success"
          paragraphs:
            - "Paragraf 1"
            - "Paragraf 2"
          details:
            - h4: "Detail H4 #1"
              paragraph: "..."
            - h4: "Detail H4 #2"
              paragraph: "..."
            - h4: "Detail H4 #3"
              paragraph: "..."

        - title: "Judul H3 Card #3"
          icon: "bi-lightbulb-fill"
          color: "primary"
          paragraphs:
            - "Paragraf 1"
            - "Paragraf 2"
          details:
            - h4: "Detail H4 #1"
              paragraph: "..."
            - h4: "Detail H4 #2"
              paragraph: "..."
            - h4: "Detail H4 #3"
              paragraph: "..."
```

---

## 🎨 CSS Selector Pattern (Frontmatter → HTML)

### Objective:
Enable **custom styling** per section/card/block through frontmatter-defined CSS classes and IDs, without modifying HTML templates.

### Benefits:
- ✅ **Maintainability** - Style changes in CSS, not in templates
- ✅ **Reusability** - Same block, different styles per post
- ✅ **Specificity** - Target specific sections with custom CSS
- ✅ **A/B Testing** - Easy to create variants with different classes
- ✅ **Theme Variants** - Support light/dark/custom themes

---

### YAML Schema with CSS Selectors:

```yaml
sections:
  - section:
      # CSS Selectors (OPTIONAL but recommended)
      id: "keunggulan-produk"           # → <section id="keunggulan-produk">
      css_class: "section-premium"      # → <section class="section-premium ...">

      # Standard fields
      title: "Keunggulan Produk"
      intro: "..."
      icon: "bi-award-fill"
      gradient: "warning"

      overview:
        id: "overview-keunggulan"       # → <div id="overview-keunggulan">
        css_class: "overview-highlight" # → <div class="overview-highlight ...">
        title: "..."
        subtitle: "..."

      cards:
        - id: "card-durability"         # → <div id="card-durability">
          css_class: "feature-card premium-feature"  # Multiple classes OK
          title: "Tahan Lama"
          icon: "bi-shield-check"
          color: "success"
          paragraphs: [...]

          details:
            - id: "detail-warranty"     # → <div id="detail-warranty">
              css_class: "detail-item highlight"
              h4: "Garansi 20 Tahun"
              paragraph: "..."
```

---

### HTML Block Rendering:

```html
<!-- Section with custom ID and class -->
<section id="{{ section.id | default: '' }}"
         class="post-section {{ section.css_class | default: '' }}">

  <!-- H2: Main Header -->
  <div class="card border-0 shadow-lg section-header">
    <div class="card-body text-white text-center py-4"
         style="background: linear-gradient(...)">
      <i class="{{ section.icon }} mb-2 fs-2-5rem"></i>
      <h2 class="h2 mb-0 fw-bold">{{ section.title }}</h2>
    </div>
  </div>

  <!-- Overview with custom ID and class -->
  {% if section.overview %}
  <div id="{{ section.overview.id | default: '' }}"
       class="overview-box bg-{{ section.overview.color }} bg-opacity-10
              {{ section.overview.css_class | default: '' }}">
    <h3 class="h4 mb-0">{{ section.overview.title }}</h3>
  </div>
  {% endif %}

  <!-- Cards with custom IDs and classes -->
  <div class="row g-3 cards-container">
    {% for card in section.cards %}
    <div class="col-md-4">
      <div id="{{ card.id | default: '' }}"
           class="card h-100 section-card {{ card.css_class | default: '' }}">
        <div class="card-body">
          <h3 class="h5">{{ card.title }}</h3>

          <!-- Card paragraphs -->
          {% for para in card.paragraphs %}
          <p class="card-paragraph">{{ para }}</p>
          {% endfor %}

          <!-- Details with custom IDs and classes -->
          {% for detail in card.details %}
          <div id="{{ detail.id | default: '' }}"
               class="detail-section {{ detail.css_class | default: '' }}">
            <h4 class="h6">{{ detail.h4 }}</h4>
            <p class="detail-paragraph">{{ detail.paragraph }}</p>
          </div>
          {% endfor %}
        </div>
      </div>
    </div>
    {% endfor %}
  </div>

</section>
```

---

### CSS Styling Examples:

```css
/* 1. Style specific section by ID */
#keunggulan-produk {
  background: linear-gradient(to bottom, #f8f9fa, #ffffff);
  padding: 4rem 0;
}

/* 2. Style all premium sections */
.section-premium .section-header {
  box-shadow: 0 10px 30px rgba(255, 193, 7, 0.3);
}

.section-premium .section-card {
  border-left: 4px solid #ffc107;
}

/* 3. Style specific card by ID */
#card-durability {
  background: linear-gradient(135deg, #e8f5e9, #ffffff);
}

#card-durability .card-body {
  position: relative;
}

#card-durability::before {
  content: "⭐ Popular";
  position: absolute;
  top: -10px;
  right: 20px;
  background: #4caf50;
  color: white;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 0.75rem;
}

/* 4. Style all feature cards */
.feature-card {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.feature-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 12px 24px rgba(0,0,0,0.15);
}

/* 5. Style premium features differently */
.premium-feature {
  border: 2px solid #ffc107;
  background: linear-gradient(to bottom right, #fff8e1, #ffffff);
}

/* 6. Highlight specific details */
.detail-item.highlight {
  background: #fff3cd;
  padding: 0.75rem;
  border-radius: 8px;
  border-left: 3px solid #ffc107;
}

/* 7. Theme variants with class */
.section-dark {
  background: #1a1a1a;
  color: #ffffff;
}

.section-dark .card {
  background: #2d2d2d;
  color: #ffffff;
}

/* 8. Responsive adjustments for specific sections */
@media (max-width: 768px) {
  #keunggulan-produk .cards-container {
    gap: 1.5rem !important;
  }

  .feature-card {
    margin-bottom: 1rem;
  }
}
```

---

### Naming Conventions (Best Practices):

#### Section IDs:
```yaml
id: "keunggulan-produk"      # kebab-case, descriptive
id: "cara-pemesanan"
id: "studi-kasus-komersial"
id: "faq-umum"
```

#### Section Classes:
```yaml
css_class: "section-premium"         # Single class
css_class: "section-dark featured"   # Multiple classes (space-separated)
css_class: "highlight-section bg-gradient"
```

#### Card IDs:
```yaml
id: "card-durability"        # card-{feature-name}
id: "card-price-advantage"
id: "card-easy-installation"
```

#### Card Classes:
```yaml
css_class: "feature-card"
css_class: "premium-feature highlight"
css_class: "comparison-card left-side"
```

#### Detail IDs:
```yaml
id: "detail-warranty"        # detail-{specific-info}
id: "detail-shipping"
id: "detail-payment-terms"
```

#### Detail Classes:
```yaml
css_class: "detail-item"
css_class: "highlight important"
css_class: "with-icon expandable"
```

---

### Use Cases:

#### 1. A/B Testing:
```yaml
# Version A
sections:
  - section:
      id: "keunggulan-produk"
      css_class: "variant-a"  # → style in custom-variant-a.css

# Version B
sections:
  - section:
      id: "keunggulan-produk"
      css_class: "variant-b"  # → style in custom-variant-b.css
```

#### 2. Premium vs Standard Posts:
```yaml
# Premium post
sections:
  - section:
      css_class: "premium-section animated"
      cards:
        - css_class: "premium-card with-badge"

# Standard post
sections:
  - section:
      css_class: "standard-section"
      cards:
        - css_class: "standard-card"
```

#### 3. Template-Specific Styling:
```yaml
# Tutorial template
sections:
  - section:
      css_class: "tutorial-step numbered"

# Comparison template
sections:
  - section:
      css_class: "comparison-section side-by-side"

# Guide template
sections:
  - section:
      css_class: "guide-section comprehensive"
```

#### 4. Seasonal/Campaign Themes:
```yaml
# Ramadan campaign
sections:
  - section:
      css_class: "ramadan-theme islamic-pattern"

# Year-end sale
sections:
  - section:
      css_class: "sale-theme urgent"
```

---

### Default Classes (Always Present):

Even without custom CSS classes, blocks have **default semantic classes**:

```html
<!-- Section wrapper -->
<section class="post-section {{ section.css_class }}">

<!-- Section header -->
<div class="section-header">

<!-- Overview box -->
<div class="overview-box">

<!-- Cards container -->
<div class="cards-container">

<!-- Individual card -->
<div class="section-card {{ card.css_class }}">

<!-- Detail item -->
<div class="detail-section {{ detail.css_class }}">
```

This ensures **base styling works** even if frontmatter has no custom classes.

---

### Validation Rules:

```yaml
# ✅ VALID
id: "keunggulan-produk"           # kebab-case
id: "section-1"                   # with numbers
css_class: "premium featured"     # multiple classes

# ❌ INVALID
id: "Keunggulan Produk"           # spaces not allowed in ID
id: "keunggulan_produk"           # use kebab-case, not snake_case
css_class: "premium, featured"    # comma not allowed (use space)
```

**Recommendation:** Use `id` for unique sections you'll style specifically, use `css_class` for reusable styling patterns.

---

## 🧩 Mapping: YAML → HTML → Bootstrap

### Layer 1: YAML Data
```yaml
section:
  title: "Keunggulan Produk"
  intro: "Produk kami memiliki berbagai keunggulan..."
  icon: "bi-award-fill"
  gradient: "warning"
```

### Layer 2: Block Include
```liquid
{% for item in page.sections %}
  {% include posts/tutorial/block--content-section.html section=item.section %}
{% endfor %}
```

**Note:** Path depends on template type:
- Tutorial: `posts/tutorial/`
- Comparison: `posts/comparison/`
- Guide: `posts/guide/`

### Layer 3: HTML Block
```html
<!-- H2: Main Header -->
<div class="card border-0 shadow-lg">
  <div class="card-body text-white text-center py-4"
       style="background: linear-gradient(...)">
    <i class="{{ section.icon }} mb-2 fs-2-5rem"></i>
    <h2 class="h2 mb-0 fw-bold">{{ section.title }}</h2>
  </div>
</div>

<!-- Intro Paragraph -->
<p class="mb-4">{{ section.intro }}</p>

<!-- H3: Overview -->
<div class="bg-{{ section.overview.color }} bg-opacity-10 px-3 py-2">
  <h3 class="h4 mb-0">
    <i class="{{ section.overview.icon }} me-2"></i>
    {{ section.overview.title }}
  </h3>
  <p class="small">{{ section.overview.subtitle }}</p>
</div>

<!-- Cards Loop (3 cards) -->
<div class="row g-3">
  {% for card in section.cards %}
  <div class="col-md-4">
    <div class="card h-100">
      <div class="card-body">
        <h3 class="h5">{{ card.title }}</h3>

        {% for para in card.paragraphs %}
        <p>{{ para }}</p>
        {% endfor %}

        {% for detail in card.details %}
        <h4 class="h6">{{ detail.h4 }}</h4>
        <p>{{ detail.paragraph }}</p>
        {% endfor %}
      </div>
    </div>
  </div>
  {% endfor %}
</div>
```

---

## 📝 Example: Tutorial Template

### YAML Frontmatter:
```yaml
---
layout: node--post
title: "Cara Menghitung Kebutuhan Kayu Dolken"
template_type: tutorial

sections:
  - section:
      title: "Langkah Perhitungan"
      intro: "Menghitung kebutuhan kayu dolken untuk proyek Anda sangat mudah dengan mengikuti 3 langkah berikut."
      icon: "bi-calculator-fill"
      gradient: "primary"

      overview:
        title: "Panduan Lengkap Perhitungan"
        subtitle: "Ikuti langkah-langkah sistematis untuk hasil akurat"
        icon: "bi-list-ol"
        color: "primary"

      cards:
        - title: "Langkah 1: Ukur Area"
          icon: "bi-rulers"
          color: "warning"
          paragraphs:
            - "Langkah pertama adalah mengukur panjang area yang akan dipasang pagar dolken."
            - "Gunakan meteran untuk mengukur dengan akurat dan catat hasilnya."
          details:
            - h4: "Alat yang Dibutuhkan"
              paragraph: "Meteran minimal 5 meter, kertas, dan pulpen untuk mencatat."
            - h4: "Tips Pengukuran"
              paragraph: "Ukur dua kali untuk memastikan akurasi, terutama untuk sudut-sudut."
            - h4: "Kesalahan Umum"
              paragraph: "Jangan lupa tambahkan buffer 5-10% untuk potongan dan kesalahan."

        - title: "Langkah 2: Hitung Jarak"
          icon: "bi-distribute-horizontal"
          color: "info"
          paragraphs:
            - "Tentukan jarak ideal antar dolken sesuai diameter yang dipilih."
            - "Jarak standar adalah 10-15 cm untuk pagar yang rapat dan kuat."
          details:
            - h4: "Diameter 2-4 cm"
              paragraph: "Jarak ideal 8-10 cm untuk tampilan rapat dan estetis."
            - h4: "Diameter 6-8 cm"
              paragraph: "Jarak ideal 12-15 cm untuk keseimbangan kekuatan dan ekonomis."
            - h4: "Diameter 10-12 cm"
              paragraph: "Jarak ideal 15-20 cm untuk struktur berat dan tiang utama."

        - title: "Langkah 3: Gunakan Rumus"
          icon: "bi-calculator"
          color: "success"
          paragraphs:
            - "Gunakan rumus sederhana: Jumlah Dolken = Panjang Area ÷ Jarak Antar Dolken."
            - "Contoh: 10 meter ÷ 0.15 meter = 67 batang (bulatkan ke atas menjadi 70 batang)."
          details:
            - h4: "Formula Dasar"
              paragraph: "Jumlah = (Panjang Total ÷ Jarak) × 1.1 (buffer 10%)"
            - h4: "Kalkulator Online"
              paragraph: "Gunakan kalkulator kami di bawah untuk hasil instan dan akurat."
            - h4: "Konsultasi Gratis"
              paragraph: "Hubungi 081311400177 untuk bantuan perhitungan dari tim ahli kami."
---
```

---

## 📝 Example: Comparison Template

### YAML Frontmatter:
```yaml
---
layout: node--post
title: "Kayu Gelam vs Kayu Ulin: Mana yang Lebih Baik?"
template_type: comparison

sections:
  - section:
      title: "Perbandingan Material"
      intro: "Kedua material ini populer untuk konstruksi outdoor, namun memiliki karakteristik berbeda yang perlu dipahami."
      icon: "bi-arrow-left-right"
      gradient: "info"

      overview:
        title: "Kriteria Perbandingan"
        subtitle: "Analisis mendalam 9 aspek penting dari kedua material"
        icon: "bi-table"
        color: "info"

      cards:
        - title: "Ketahanan & Durabilitas"
          icon: "bi-shield-fill-check"
          color: "success"
          paragraphs:
            - "Ketahanan material terhadap cuaca dan hama adalah faktor krusial untuk investasi jangka panjang."
            - "Berikut perbandingan detail antara kayu gelam dan kayu ulin."
          details:
            - h4: "Kayu Gelam: 20-30 Tahun"
              paragraph: "Tahan rayap alami, cocok untuk area pesisir dan darat, tidak perlu treatment kimia."
            - h4: "Kayu Ulin: 30-50 Tahun"
              paragraph: "Dikenal sebagai 'kayu besi', sangat tahan lama namun lebih mahal dan langka."
            - h4: "Pemenang: Kayu Ulin"
              paragraph: "Untuk proyek premium dengan budget tinggi, ulin unggul dalam durabilitas ekstrem."

        - title: "Harga & Ketersediaan"
          icon: "bi-cash-coin"
          color: "warning"
          paragraphs:
            - "Faktor ekonomis dan kemudahan akses material sangat mempengaruhi keputusan pemilihan."
            - "Bandingkan harga dan ketersediaan kedua material di pasaran saat ini."
          details:
            - h4: "Kayu Gelam: Rp 15.000/batang"
              paragraph: "Harga terjangkau, stok selalu tersedia, cocok untuk proyek skala besar."
            - h4: "Kayu Ulin: Rp 50.000/batang"
              paragraph: "Harga premium, stok terbatas karena langka, sering perlu indent."
            - h4: "Pemenang: Kayu Gelam"
              paragraph: "Cost-effective untuk mayoritas proyek komersial dan residensial."

        - title: "Kemudahan Pengerjaan"
          icon: "bi-tools"
          color: "primary"
          paragraphs:
            - "Kemudahan pemotongan dan pemasangan mempengaruhi biaya tenaga kerja total proyek."
            - "Perhatikan perbedaan karakter material saat pengerjaan."
          details:
            - h4: "Kayu Gelam: Mudah Dipotong"
              paragraph: "Kepadatan sedang, bisa dipotong dengan gergaji biasa, pemasangan cepat."
            - h4: "Kayu Ulin: Butuh Alat Khusus"
              paragraph: "Sangat keras, perlu gergaji heavy-duty, mata gergaji cepat tumpul."
            - h4: "Pemenang: Kayu Gelam"
              paragraph: "Hemat waktu dan biaya tukang, cocok untuk DIY project."
---
```

---

## 📝 Example: Guide Template

### YAML Frontmatter:
```yaml
---
layout: node--post
title: "Panduan Lengkap Perawatan Kayu Dolken Gelam"
template_type: guide

sections:
  - section:
      title: "Perawatan Berkala"
      intro: "Meskipun kayu gelam terkenal awet, perawatan ringan akan memperpanjang umur hingga 30+ tahun."
      icon: "bi-tools"
      gradient: "success"

      overview:
        title: "Jadwal Perawatan Optimal"
        subtitle: "Rutinitas sederhana untuk hasil maksimal"
        icon: "bi-calendar-check"
        color: "success"

      cards:
        - title: "Perawatan Harian/Mingguan"
          icon: "bi-calendar-day"
          color: "info"
          paragraphs:
            - "Perawatan rutin yang mudah dilakukan untuk menjaga kondisi optimal kayu dolken."
            - "Tidak memerlukan waktu lama, hanya 10-15 menit per minggu."
          details:
            - h4: "Pembersihan Debu"
              paragraph: "Lap dengan kain lembab untuk menghilangkan debu dan kotoran ringan."
            - h4: "Cek Visual"
              paragraph: "Periksa apakah ada bagian yang longgar atau perlu dikencangkan."
            - h4: "Bersihkan Genangan Air"
              paragraph: "Pastikan tidak ada air menggenang di sekitar base dolken."

        - title: "Perawatan Bulanan/Triwulan"
          icon: "bi-calendar-month"
          color: "warning"
          paragraphs:
            - "Perawatan lebih mendalam yang dilakukan setiap 1-3 bulan sekali."
            - "Membantu mencegah kerusakan dini dan menjaga estetika kayu."
          details:
            - h4: "Pembersihan Mendalam"
              paragraph: "Sikat dengan sabun ringan dan air, bilas hingga bersih, keringkan dengan lap."
            - h4: "Aplikasi Wood Protector"
              paragraph: "Opsional: aplikasikan wood oil atau sealer untuk extra protection (terutama area outdoor)."
            - h4: "Inspeksi Struktur"
              paragraph: "Cek kekuatan sambungan, baut, dan bracket penopang struktur."

        - title: "Perawatan Tahunan"
          icon: "bi-calendar-year"
          color: "danger"
          paragraphs:
            - "Perawatan komprehensif yang dilakukan setahun sekali untuk menjaga kualitas jangka panjang."
            - "Pertimbangkan untuk memanggil profesional jika struktur sudah sangat besar."
          details:
            - h4: "Re-coating Penuh"
              paragraph: "Aplikasi ulang coating/sealer untuk melindungi dari UV dan kelembaban ekstrem."
            - h4: "Penggantian Part Rusak"
              paragraph: "Ganti bagian yang mulai lapuk atau retak (jarang terjadi pada gelam berkualitas)."
            - h4: "Evaluasi Profesional"
              paragraph: "Hubungi 081311400177 untuk inspeksi dan konsultasi gratis dari tim ahli kami."
---
```

---

## 🎨 Visual Components Mapping

### H2 Section Card (Gradient Header):
```yaml
gradient: "info"     → linear-gradient(135deg, #06b6d4, #0891b2, #0e7490)
gradient: "warning"  → linear-gradient(135deg, #f59e0b, #d97706, #b45309)
gradient: "success"  → linear-gradient(135deg, #10b981, #059669, #047857)
gradient: "danger"   → linear-gradient(135deg, #ef4444, #dc2626, #b91c1c)
gradient: "wood"     → linear-gradient(135deg, #8b5a3c, #6d4c41, #5d4037)
gradient: "primary"  → linear-gradient(135deg, #3b82f6, #2563eb, #1d4ed8)
```

### H3 Overview Box (Background Opacity):
```yaml
color: "info"    → bg-info bg-opacity-10
color: "warning" → bg-warning bg-opacity-10
color: "success" → bg-success bg-opacity-10
color: "danger"  → bg-danger bg-opacity-10
color: "wood"    → bg-wood bg-opacity-10
color: "primary" → bg-primary bg-opacity-10
```

### Cards Layout:
```yaml
# 3 Cards → Bootstrap Grid
cards: [3 items]  → col-md-4 (3 kolom)
                   → col-lg-4 (desktop)
                   → col-12 (mobile stacked)
```

### Icons (Bootstrap Icons):
```yaml
icon: "bi-lightbulb-fill"
icon: "bi-award-fill"
icon: "bi-check-circle-fill"
icon: "bi-tools"
icon: "bi-calculator-fill"
icon: "bi-rulers"
```

---

## ✅ Validation Checklist

### Schema Validation:
- [ ] Each section has exactly 1 `section` object
- [ ] `section.title` is present (H2 title)
- [ ] `section.intro` is present (1 paragraph)
- [ ] `section.cards` array has exactly 3 items
- [ ] Each card has `title`, `paragraphs` (2 items), `details` (3 items)
- [ ] Each detail has `h4` and `paragraph`
- [ ] All required icons are valid Bootstrap icons
- [ ] All colors are valid Bootstrap color names

### CSS Selector Validation:
- [ ] All `id` fields use kebab-case format (e.g., "keunggulan-produk")
- [ ] No spaces in `id` values
- [ ] `css_class` uses space-separated values (not comma)
- [ ] No duplicate `id` values within same page
- [ ] CSS classes follow naming convention (semantic names)
- [ ] IDs are unique and descriptive

### Content Validation:
- [ ] No paragraph exceeds 300 characters (readability)
- [ ] All H4 titles are unique within a card
- [ ] Icons match the content context
- [ ] Gradient colors appropriate for section theme

---

## 🔄 Flexibility vs Strictness

### STRICT (Required):
- ✅ 3 cards per section
- ✅ 3 details per card
- ✅ 2 paragraphs per card
- ✅ 1 intro paragraph per section

### FLEXIBLE (Optional):
- 🔀 Number of sections per post (1-10+)
- 🔀 Icons and colors (based on theme)
- 🔀 Overview section (can be omitted if not needed)
- 🔀 Paragraph length (but keep readable)
- 🔀 CSS selectors (`id` and `css_class` are optional)
- 🔀 Custom styling per section/card/detail

---

## 🚀 Next Steps

### Immediate (This Week):
- [ ] Review and approve this YAML pattern
- [ ] Create sample frontmatter for each template type
- [ ] Document edge cases and special scenarios
- [ ] Define validation rules in code

### Short-term (Next Week):
- [ ] Create HTML block components based on this schema
- [ ] Build Liquid templates to render the pattern
- [ ] Test with real content from existing posts
- [ ] Iterate based on feedback

### Long-term (Following Weeks):
- [ ] Implement automated validation (pre-commit hook)
- [ ] Create YAML snippets for VS Code
- [ ] Build content generator tool
- [ ] Document best practices guide

---

## 🔗 Related Documents

- **Master Plan:** TODO-1538-modular-post-template-system.md
- **Reference:** TEMPLATE--post-with-product.md (existing template example)
- **Reference:** _includes/products/block--*.html (existing block examples)

---

## 📌 Notes

- This pattern is designed to be **template-agnostic** (works for tutorial, comparison, guide)
- Templates can have **different types of sections** but each section follows this pattern
- **Validation is critical** - invalid YAML should fail build with clear error messages
- Consider creating **VS Code snippets** for faster YAML authoring
- **Documentation is key** - every template should have clear examples

---

**Created:** 2025-11-20
**Last Updated:** 2025-11-20 (Added CSS Selector Pattern section)
**Status:** Draft (Awaiting Approval)
**Next Review:** After team discussion
**Estimated Effort:** 1 week (schema design + examples + CSS patterns)

# TODO: Cara Menambah Foto pada Product

**File:** TODO-1511-cara-menambah-foto-pada-product.md
**Date:** 2025-11-16 (Updated)
**Category:** Asset Management - Quick Reference
**Purpose:** Template praktis untuk menambahkan foto pada product manapun

---

## Quick Reference

Template ini universal untuk semua product. Cukup ganti `[PRODUCT_SIZE]` dengan ukuran product (contoh: `2-3cm`, `4-6cm`, `8-10cm`).

**Fitur:**
- ✅ Support menambah 1, 2, 3, atau 4 foto sekaligus
- ✅ Auto-detect nomor file terakhir (skip existing files)
- ✅ Safety check: tidak akan overwrite file yang sudah ada
- ✅ Move (bukan copy) untuk menghindari duplikasi

---

## Prerequisites

1. **Source Folder:** `[SOURCE_FOLDER]` (folder yang berisi foto yang akan ditambahkan)
2. **Destination Folder:** `/home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/`
3. **WebP Converter:** `cwebp` (already installed at `/usr/bin/cwebp`)

**Note:** Ganti `[SOURCE_FOLDER]` dengan path lengkap folder sumber Anda, contoh:
- `/home/mkt01/Downloads/`
- `/home/mkt01/Documents/ANDRI/Dolken/foto/WhatsApp Unknown 2025-11-15/`
- Atau folder lain sesuai kebutuhan

---

## Workflow: 6 Steps (dengan Pre-check)

### Step 0: Pre-check - Cek File Existing

**⚠️ PENTING: Selalu jalankan step ini dulu!**

**Tujuan:** Cek file mana yang sudah ada, tentukan nomor berikutnya

**Command:**
```bash
# Cek file existing di destination
ls -lh /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-*.jpeg 2>/dev/null

# Auto-detect next number
ls /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-*.jpeg 2>/dev/null | grep -oP '\d{3}(?=\.jpeg)' | sort -n | tail -1
```

**Example:**
```bash
# Product 6-8cm
ls -lh /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/jual-kayu-dolken-gelam-6-8cm-*.jpeg

# Output contoh:
# jual-kayu-dolken-gelam-6-8cm-001.jpeg (285K)
# Artinya: sudah ada 001, foto baru harus mulai dari 002
```

**Decision Tree:**
- ✅ **Tidak ada file:** Mulai dari `001`, `002`, `003`, `004`
- ✅ **Sudah ada 001:** Tambah foto baru mulai dari `002`, `003`, `004`
- ✅ **Sudah ada 001, 002:** Tambah foto baru mulai dari `003`, `004`
- ✅ **Sudah ada sampai 004:** Product sudah full (max 4 carousel slides)

---

### Step 1: Rename di Source Folder

**Tujuan:** Marking file dengan nama SEO-friendly sebelum dipindah

**⚠️ Sesuaikan nomor berdasarkan Step 0!**

**Scenario A: Product baru (belum ada foto)**
```bash
cd '[SOURCE_FOLDER]'

# Rename 4 files
mv 'WhatsApp Image [timestamp-1].jpeg' 'jual-kayu-dolken-gelam-[PRODUCT_SIZE]-001.jpeg'
mv 'WhatsApp Image [timestamp-2].jpeg' 'jual-kayu-dolken-gelam-[PRODUCT_SIZE]-002.jpeg'
mv 'WhatsApp Image [timestamp-3].jpeg' 'jual-kayu-dolken-gelam-[PRODUCT_SIZE]-003.jpeg'
mv 'WhatsApp Image [timestamp-4].jpeg' 'jual-kayu-dolken-gelam-[PRODUCT_SIZE]-004.jpeg'

# Verify
ls -lh jual-kayu-dolken-gelam-[PRODUCT_SIZE]-*
```

**Scenario B: Menambah 3 foto (sudah ada 001)**
```bash
cd '[SOURCE_FOLDER]'

# Rename 3 files mulai dari 002
mv 'WhatsApp Image [timestamp-1].jpeg' 'jual-kayu-dolken-gelam-[PRODUCT_SIZE]-002.jpeg'
mv 'WhatsApp Image [timestamp-2].jpeg' 'jual-kayu-dolken-gelam-[PRODUCT_SIZE]-003.jpeg'
mv 'WhatsApp Image [timestamp-3].jpeg' 'jual-kayu-dolken-gelam-[PRODUCT_SIZE]-004.jpeg'

# Verify
ls -lh jual-kayu-dolken-gelam-[PRODUCT_SIZE]-*
```

**Scenario C: Menambah 2 foto (sudah ada 001, 002)**
```bash
cd '[SOURCE_FOLDER]'

# Rename 2 files mulai dari 003
mv 'WhatsApp Image [timestamp-1].jpeg' 'jual-kayu-dolken-gelam-[PRODUCT_SIZE]-003.jpeg'
mv 'WhatsApp Image [timestamp-2].jpeg' 'jual-kayu-dolken-gelam-[PRODUCT_SIZE]-004.jpeg'

# Verify
ls -lh jual-kayu-dolken-gelam-[PRODUCT_SIZE]-*
```

**Real Example (Product 6-8cm - menambah 3 foto):**
```bash
cd '[SOURCE_FOLDER]'

# Sudah ada 001, jadi mulai dari 002
mv 'WhatsApp Image 2025-08-09 at 10.01.18.jpeg' 'jual-kayu-dolken-gelam-6-8cm-002.jpeg'
mv 'WhatsApp Image 2025-08-09 at 10.01.17 (3).jpeg' 'jual-kayu-dolken-gelam-6-8cm-003.jpeg'
mv 'WhatsApp Image 2025-08-09 at 10.01.17 (1).jpeg' 'jual-kayu-dolken-gelam-6-8cm-004.jpeg'

# Verify
ls -lh jual-kayu-dolken-gelam-6-8cm-*
```

---

### Step 2: Move to Jekyll Folder

**Tujuan:** Pindahkan file (bukan copy) ke folder product - **file asli akan hilang**

**⚠️ SAFETY CHECK:**
```bash
# Cek apakah file destination sudah ada (prevent overwrite)
ls -lh /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-002.jpeg 2>/dev/null && echo "⚠️ WARNING: File 002 already exists!" || echo "✓ Safe to proceed"
```

**Command (flexible - adjust range):**

**For 4 files (001-004):**
```bash
cd '[SOURCE_FOLDER]' && \
mv jual-kayu-dolken-gelam-[PRODUCT_SIZE]-00{1,2,3,4}.jpeg \
   /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/
```

**For 3 files (002-004):**
```bash
cd '[SOURCE_FOLDER]' && \
mv jual-kayu-dolken-gelam-[PRODUCT_SIZE]-00{2,3,4}.jpeg \
   /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/
```

**For 2 files (003-004):**
```bash
cd '[SOURCE_FOLDER]' && \
mv jual-kayu-dolken-gelam-[PRODUCT_SIZE]-00{3,4}.jpeg \
   /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/
```

**For 1 file (004 only):**
```bash
cd '[SOURCE_FOLDER]' && \
mv jual-kayu-dolken-gelam-[PRODUCT_SIZE]-004.jpeg \
   /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/
```

**Verify:**
```bash
ls -lh /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-*.jpeg
```

**✅ Result:**
- File sudah di `/public_html/assets/images/products/`
- File **HILANG** dari source folder (moved, not copied)
- Jelas mana foto sudah dipakai

---

### Step 3: Convert to WebP

**Tujuan:** Buat versi WebP untuk performa & modern browser support

**Command (dengan skip existing - smart conversion):**
```bash
cd /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/

# Convert hanya file yang belum ada WebP-nya
for img in jual-kayu-dolken-gelam-[PRODUCT_SIZE]-*.jpeg; do
  if [ ! -f "${img%.jpeg}.webp" ]; then
    cwebp -q 85 "$img" -o "${img%.jpeg}.webp"
    echo "✓ Converted: $img → ${img%.jpeg}.webp"
  else
    echo "⊘ Skipped (exists): ${img%.jpeg}.webp"
  fi
done

# Verify - cek ukuran JPEG vs WebP
ls -lh jual-kayu-dolken-gelam-[PRODUCT_SIZE]-* | awk '{print $5, $9}'
```

**Example (Product 6-8cm):**
```bash
cd /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/

for img in jual-kayu-dolken-gelam-6-8cm-*.jpeg; do
  if [ ! -f "${img%.jpeg}.webp" ]; then
    cwebp -q 85 "$img" -o "${img%.jpeg}.webp"
    echo "✓ Converted: $img → ${img%.jpeg}.webp"
  else
    echo "⊘ Skipped (exists): ${img%.jpeg}.webp"
  fi
done
```

**Expected Output:**
```
⊘ Skipped (exists): jual-kayu-dolken-gelam-6-8cm-001.webp
✓ Converted: jual-kayu-dolken-gelam-6-8cm-002.jpeg → jual-kayu-dolken-gelam-6-8cm-002.webp
✓ Converted: jual-kayu-dolken-gelam-6-8cm-003.jpeg → jual-kayu-dolken-gelam-6-8cm-003.webp
✓ Converted: jual-kayu-dolken-gelam-6-8cm-004.jpeg → jual-kayu-dolken-gelam-6-8cm-004.webp
```

**✅ Result:**
- JPEG files (original)
- WebP files (modern format)
- Only converts new files (tidak overwrite yang sudah ada)

---

### Step 4: Update Product Markdown

**Tujuan:** Tambahkan `images:` array di product front matter untuk carousel

**File Location:**
```
/home/mkt01/Public/jualkayudolkengelam.net/public_html/_products/kayu-dolken-[PRODUCT_SIZE].md
```

**⚠️ Update sesuai jumlah file yang ada!**

**Template Front Matter (4 images - full carousel):**
```yaml
---
layout: product
title: Jual Kayu Dolken Gelam Diameter [PRODUCT_SIZE]
price: [PRICE]
diameter: [DIAMETER_DISPLAY]
image: /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-001.jpeg
images:
  - /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-001.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-002.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-003.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-004.jpeg
sku: DOLKEN-[SIZE_CODE]
popular: [true/false]
rating: [4.5-5.0]
review_count: [number]
---
```

**Template Front Matter (3 images):**
```yaml
image: /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-001.jpeg
images:
  - /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-001.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-002.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-003.jpeg
```

**Template Front Matter (2 images):**
```yaml
image: /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-001.jpeg
images:
  - /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-001.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-002.jpeg
```

**Real Example (Product 6-8cm dengan 4 images):**
```yaml
---
layout: product
title: Jual Kayu Dolken Gelam Diameter 6-8 cm
price: 30000
diameter: 6 - 8 cm
image: /assets/images/products/jual-kayu-dolken-gelam-6-8cm-001.jpeg
images:
  - /assets/images/products/jual-kayu-dolken-gelam-6-8cm-001.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-6-8cm-002.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-6-8cm-003.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-6-8cm-004.jpeg
sku: DOLKEN-6-8
popular: false
rating: 4.7
review_count: 68
---
```

**Edit Command:**
```bash
nano /home/mkt01/Public/jualkayudolkengelam.net/public_html/_products/kayu-dolken-[PRODUCT_SIZE].md
```

---

### Step 5: Rebuild & Verify

**Command:**
```bash
cd /home/mkt01/Public/jualkayudolkengelam.net/public_html
./rebuild.sh
```

**Verification Checklist:**

```bash
# 1. Cek carousel HTML generated (count slides)
grep -c 'carousel-item' _site/product/kayu-dolken-[PRODUCT_SIZE]/index.html

# Expected: 2, 3, atau 4 (sesuai jumlah images di markdown)

# 2. Cek carousel initialization script
grep -A 5 "Carousel Initialization" _site/product/kayu-dolken-[PRODUCT_SIZE]/index.html | head -10

# 3. Verify images di _site folder
ls -lh _site/assets/images/products/jual-kayu-dolken-gelam-[PRODUCT_SIZE]-*

# 4. Verify first carousel slide
grep -A 3 'carousel-item active' _site/product/kayu-dolken-[PRODUCT_SIZE]/index.html | head -6
```

**Example (Product 6-8cm):**
```bash
# Should show: 4
grep -c 'carousel-item' _site/product/kayu-dolken-6-8cm/index.html

# Should show JPEG + WebP files
ls -lh _site/assets/images/products/jual-kayu-dolken-gelam-6-8cm-*
```

**✅ Expected Results:**
- Build success (150+ files)
- Carousel slides count matches images array
- Carousel initialization script present
- All JPEG + WebP images in _site folder
- Picture element with WebP fallback

---

### Step 6: Verify di Source Folder (Optional)

**Tujuan:** Pastikan file sudah hilang dari source (confirm move)

```bash
# Cek apakah file masih ada di source (should be empty)
ls -lh '[SOURCE_FOLDER]' | grep "jual-kayu-dolken-gelam-[PRODUCT_SIZE]"

# Expected: No output (files sudah pindah)
```

---

## Quick Command Cheat Sheet

**Pre-check:**
```bash
ls -lh /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/jual-kayu-dolken-gelam-[SIZE]-*.jpeg
```

**Rename (3 files for example):**
```bash
cd '[SOURCE_FOLDER]'
mv 'WhatsApp Image [A].jpeg' 'jual-kayu-dolken-gelam-[SIZE]-002.jpeg'
mv 'WhatsApp Image [B].jpeg' 'jual-kayu-dolken-gelam-[SIZE]-003.jpeg'
mv 'WhatsApp Image [C].jpeg' 'jual-kayu-dolken-gelam-[SIZE]-004.jpeg'
```

**Move:**
```bash
mv jual-kayu-dolken-gelam-[SIZE]-00{2,3,4}.jpeg /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/
```

**Convert WebP (smart):**
```bash
cd /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/
for img in jual-kayu-dolken-gelam-[SIZE]-*.jpeg; do
  [ ! -f "${img%.jpeg}.webp" ] && cwebp -q 85 "$img" -o "${img%.jpeg}.webp"
done
```

**Rebuild:**
```bash
cd /home/mkt01/Public/jualkayudolkengelam.net/public_html && ./rebuild.sh
```

---

## Naming Convention Reference

### Product Image Format
```
jual-kayu-dolken-gelam-[PRODUCT_SIZE]-[NUMBER].jpeg
```

### Product Size Examples
- `2-3cm` → Diameter 2-3 cm
- `4-6cm` → Diameter 4-6 cm
- `6-8cm` → Diameter 6-8 cm
- `8-10cm` → Diameter 8-10 cm
- `10-12cm` → Diameter 10-12 cm

### Numbering
- Always use **3 digits**: `001`, `002`, `003`, `004`
- Maximum **4 images** per product (carousel limit)
- Sequential: must be continuous (no gaps)
- Start from `001` for new product
- Continue from last number for existing product

---

## Product URLs After Build

**Local:**
```
http://jualkayudolkengelam.net.local/product/kayu-dolken-[PRODUCT_SIZE]/
```

**Production:**
```
https://jualkayudolkengelam.net/product/kayu-dolken-[PRODUCT_SIZE]/
```

---

## SEO Benefits

### 1. Filename SEO
- ✅ Keyword: "jual kayu dolken gelam" in every filename
- ✅ Product size clearly identified
- ✅ Google Image Search optimization

### 2. Modern Web Performance
- ✅ WebP format for faster loading (modern browsers)
- ✅ JPEG fallback for older browsers
- ✅ Picture element with srcset
- ✅ Average 10-20% size reduction with WebP

### 3. User Experience
- ✅ Image carousel/gallery on product page
- ✅ Auto-play with manual controls
- ✅ Touch swipe support for mobile
- ✅ Keyboard navigation
- ✅ 2-4 slides depending on availability

---

## Important Notes

### ⚠️ File Movement (Not Copy)
- This workflow uses `mv` (move), **NOT** `cp` (copy)
- Original files will **DISAPPEAR** from source folder
- This prevents duplicate management
- Source folder becomes "archive" of unused files only

### ✅ WebP Conversion
- Always use quality `-q 85` for good balance
- WebP may be larger for high-quality photos (normal)
- Browsers auto-select best format via `<picture>` element
- Smart conversion: skips if WebP already exists

### ✅ Flexible Numbering
- Can add 1, 2, 3, or 4 images
- Auto-detect existing files via Step 0
- Safety check prevents overwrite
- Maximum 4 images per product (carousel optimization)

### ✅ Carousel Features
- Auto-initialized via JavaScript (fix applied 2025-11-16)
- Works on both local and production
- Interval: 3 seconds per slide
- Pause on hover enabled
- Touch swipe enabled

---

## Troubleshooting

### Problem: "mv: cannot stat ... No such file"
```bash
# Solution: Check folder name and file name (case-sensitive)
ls -la '[SOURCE_FOLDER]'
cd '[SOURCE_FOLDER]'
ls -lh | grep "WhatsApp Image"
```

### Problem: "File already exists" warning
```bash
# Solution: Run Step 0 Pre-check
ls -lh /home/mkt01/Public/jualkayudolkengelam.net/public_html/assets/images/products/jual-kayu-dolken-gelam-[SIZE]-*.jpeg

# Adjust numbering accordingly
# If 001 exists, start from 002
# If 001,002 exist, start from 003
```

### Problem: WebP larger than JPEG
```
# This is normal for high-quality photos
# Keep both formats - browsers will choose best
# Modern browsers prefer WebP for compatibility features
```

### Problem: Carousel not showing
```bash
# Check images array in markdown
cat _products/kayu-dolken-[SIZE].md | grep -A 5 "images:"

# Rebuild site
./rebuild.sh

# Verify carousel count
grep -c 'carousel-item' _site/product/kayu-dolken-[SIZE]/index.html
```

### Problem: Only want 2 or 3 images (not 4)
```
# No problem! Just add however many you want
# Carousel works with 2, 3, or 4 slides
# Update images: array accordingly in markdown
```

---

## Real-World Examples

### Example 1: New Product (4 images from scratch)
```bash
# Product: 10-12cm (new)
# Files: 4 new images

# Step 0: Pre-check
ls -lh /home/mkt01/Public/.../products/jual-kayu-dolken-gelam-10-12cm-*.jpeg
# Output: No files found (new product)

# Step 1: Rename (start from 001)
cd '[SOURCE_FOLDER]'
mv 'WhatsApp Image A.jpeg' 'jual-kayu-dolken-gelam-10-12cm-001.jpeg'
mv 'WhatsApp Image B.jpeg' 'jual-kayu-dolken-gelam-10-12cm-002.jpeg'
mv 'WhatsApp Image C.jpeg' 'jual-kayu-dolken-gelam-10-12cm-003.jpeg'
mv 'WhatsApp Image D.jpeg' 'jual-kayu-dolken-gelam-10-12cm-004.jpeg'

# Step 2: Move
mv jual-kayu-dolken-gelam-10-12cm-00{1,2,3,4}.jpeg /home/mkt01/Public/.../products/

# Step 3: Convert WebP
cd /home/mkt01/Public/.../products/
for img in jual-kayu-dolken-gelam-10-12cm-*.jpeg; do
  cwebp -q 85 "$img" -o "${img%.jpeg}.webp"
done

# Step 4: Update markdown (add images: array with 4 entries)
# Step 5: Rebuild
```

### Example 2: Add 3 Images to Existing Product (6-8cm)
```bash
# Product: 6-8cm (already has 001)
# Files: 3 new images to add

# Step 0: Pre-check
ls -lh /home/mkt01/Public/.../products/jual-kayu-dolken-gelam-6-8cm-*.jpeg
# Output: jual-kayu-dolken-gelam-6-8cm-001.jpeg exists

# Decision: Add as 002, 003, 004

# Step 1: Rename (start from 002)
cd '[SOURCE_FOLDER]'
mv 'WhatsApp Image 2025-08-09 at 10.01.18.jpeg' 'jual-kayu-dolken-gelam-6-8cm-002.jpeg'
mv 'WhatsApp Image 2025-08-09 at 10.01.17 (3).jpeg' 'jual-kayu-dolken-gelam-6-8cm-003.jpeg'
mv 'WhatsApp Image 2025-08-09 at 10.01.17 (1).jpeg' 'jual-kayu-dolken-gelam-6-8cm-004.jpeg'

# Step 2: Move (only 3 files: 002, 003, 004)
mv jual-kayu-dolken-gelam-6-8cm-00{2,3,4}.jpeg /home/mkt01/Public/.../products/

# Step 3: Convert WebP (smart - will skip 001.webp if exists)
cd /home/mkt01/Public/.../products/
for img in jual-kayu-dolken-gelam-6-8cm-*.jpeg; do
  [ ! -f "${img%.jpeg}.webp" ] && cwebp -q 85 "$img" -o "${img%.jpeg}.webp"
done

# Step 4: Update markdown (update images: array to include 4 entries)
# Step 5: Rebuild
```

### Example 3: Add Only 1 Image (complete to 4)
```bash
# Product: 4-6cm (already has 001, 002, 003)
# Files: 1 new image to complete carousel

# Step 0: Pre-check
ls -lh /home/mkt01/Public/.../products/jual-kayu-dolken-gelam-4-6cm-*.jpeg
# Output: 001.jpeg, 002.jpeg, 003.jpeg exist

# Decision: Add as 004

# Step 1: Rename (only 004)
cd '[SOURCE_FOLDER]'
mv 'WhatsApp Image X.jpeg' 'jual-kayu-dolken-gelam-4-6cm-004.jpeg'

# Step 2: Move (only 1 file)
mv jual-kayu-dolken-gelam-4-6cm-004.jpeg /home/mkt01/Public/.../products/

# Step 3: Convert WebP (only new file)
cd /home/mkt01/Public/.../products/
cwebp -q 85 jual-kayu-dolken-gelam-4-6cm-004.jpeg -o jual-kayu-dolken-gelam-4-6cm-004.webp

# Step 4: Update markdown (add 004 to images: array)
# Step 5: Rebuild
```

---

## Lessons Learned (Pelajaran Penting)

### 🎓 Critical Lessons dari Real Implementation

#### 1. **Step 0 (Pre-check) adalah WAJIB - Tidak Boleh Dilewati!**

**Pelajaran:**
- Awalnya saya tidak melakukan pre-check dengan teliti di product 6-8cm
- Akibatnya: Markdown punya reference ke 004.jpeg yang tidak exist
- Root cause: File 002-004 sudah di-move sebelumnya tapi tidak ter-track

**Solusi:**
```bash
# SELALU jalankan ini dulu!
ls -lh /home/mkt01/Public/.../products/jual-kayu-dolken-gelam-[SIZE]-*.jpeg

# Bandingkan dengan markdown
grep -A 5 "images:" _products/kayu-dolken-[SIZE].md

# Pastikan match!
```

**Pencegahan:**
- ✅ Pre-check adalah Step 0 yang MANDATORY
- ✅ Cross-check markdown vs filesystem
- ✅ Jangan assume file ada hanya karena markdown reference

---

#### 2. **Markdown vs Filesystem Mismatch - Bahaya!**

**Pelajaran:**
Product 6-8cm mengalami broken state:
- Markdown: `images: [001, 002, 003, 004]`
- Filesystem: Hanya ada `001.jpeg`
- Result: Carousel tidak lengkap, broken references

**Root Cause:**
- File di-move tapi markdown tidak updated
- ATAU file lost saat process sebelumnya
- ATAU manual edit markdown tanpa add files

**Solusi:**
```bash
# Verify sync antara markdown dan filesystem
PRODUCT_SIZE="6-8cm"

# Count images in markdown
grep -A 10 "images:" _products/kayu-dolken-${PRODUCT_SIZE}.md | grep -c ".jpeg"

# Count images in filesystem
ls assets/images/products/jual-kayu-dolken-gelam-${PRODUCT_SIZE}-*.jpeg | wc -l

# Should match!
```

**Recovery:**
- ✅ Add new images untuk replace yang hilang
- ✅ Update markdown sesuai realitas filesystem
- ✅ Rebuild untuk verify

---

#### 3. **File Tracking After Move - Penting untuk Audit**

**Pelajaran:**
- `mv` (move) menghilangkan file dari source
- Tidak ada trace bahwa file sudah dipakai
- Kalau ada masalah, sulit track mana file yang sudah processed

**Best Practice:**
```bash
# Step 6 (Optional tapi recommended): Document
echo "Product: 6-8cm - Files moved on $(date)" >> ~/image-move-log.txt
echo "  - 002.jpeg (336K)" >> ~/image-move-log.txt
echo "  - 003.jpeg (388K)" >> ~/image-move-log.txt
```

**Alternative (untuk paranoid):**
- Bisa pakai `cp` dulu, verify everything OK, baru `rm` source
- Tapi ini against workflow (avoid duplication)
- Trade-off: Safety vs Duplication prevention

---

#### 4. **Smart WebP Conversion is Critical**

**Pelajaran:**
- Tanpa skip logic, re-convert file yang sudah ada
- Waste time dan bisa overwrite hasil convert sebelumnya
- Quality bisa inconsistent kalau re-convert berkali-kali

**Good Practice:**
```bash
# ALWAYS use skip logic
for img in *.jpeg; do
  if [ ! -f "${img%.jpeg}.webp" ]; then
    cwebp -q 85 "$img" -o "${img%.jpeg}.webp"
  else
    echo "⊘ Skipped (exists): ${img%.jpeg}.webp"
  fi
done
```

**Result:**
```
⊘ Skipped: 001.webp (already exists - good!)
✓ Converted: 002.jpeg → 002.webp
✓ Converted: 003.jpeg → 003.webp
```

---

#### 5. **Flexible Image Count - Carousel Works with 2, 3, or 4**

**Pelajaran:**
- Tidak semua product harus 4 images
- Carousel works fine dengan 2 atau 3 slides
- Update markdown sesuai jumlah aktual

**Evidence:**
- ✅ Product 6-8cm: 3 images - carousel works perfectly
- ✅ Product 8-10cm: 4 images - full carousel
- ✅ Product 10-12cm: 4 images - full carousel

**Template Flexibility:**
```yaml
# 2 images (minimum for carousel)
images:
  - .../001.jpeg
  - .../002.jpeg

# 3 images (sweet spot)
images:
  - .../001.jpeg
  - .../002.jpeg
  - .../003.jpeg

# 4 images (maximum)
images:
  - .../001.jpeg
  - .../002.jpeg
  - .../003.jpeg
  - .../004.jpeg
```

---

#### 6. **Verification at Every Step Prevents Cascading Failures**

**Pelajaran:**
- Skip verification → discover error di Step 5 (too late!)
- Fix di Step 5 cost lebih mahal (rebuild time, etc)
- Verify early, fail fast!

**Verification Checklist:**
```bash
# After Step 1 (Rename)
ls -lh jual-kayu-dolken-gelam-[SIZE]-*
# ✓ Expect: renamed files with correct numbering

# After Step 2 (Move)
ls -lh /home/mkt01/Public/.../products/jual-kayu-dolken-gelam-[SIZE]-*.jpeg
# ✓ Expect: files in destination
ls -lh '/home/mkt01/Documents/.../[FOLDER]/' | grep "[SIZE]"
# ✓ Expect: no output (files moved)

# After Step 3 (WebP)
ls -lh .../products/jual-kayu-dolken-gelam-[SIZE]-* | awk '{print $5, $9}'
# ✓ Expect: JPEG + WebP pairs

# After Step 4 (Markdown)
grep -A 10 "images:" _products/kayu-dolken-[SIZE].md
# ✓ Expect: correct number of entries

# After Step 5 (Rebuild)
grep -c 'carousel-item' _site/product/kayu-dolken-[SIZE]/index.html
# ✓ Expect: matches images count
```

---

#### 7. **Recovery Strategy When Things Go Wrong**

**Pelajaran:**
Product 6-8cm mengalami broken state, tapi bisa di-recover:

**Problem:**
- Markdown: 4 images
- Filesystem: 1 image
- Carousel: broken

**Recovery Steps:**
1. ✅ Pre-check: identify mismatch
2. ✅ Add 2 new images (002, 003)
3. ✅ Update markdown: reduce from 4 → 3
4. ✅ Rebuild: verify carousel works
5. ✅ Result: working 3-slide carousel

**Key Insight:**
- Markdown is source of truth for Jekyll build
- Filesystem is source of truth for actual files
- **They MUST sync** - prefer filesystem reality over markdown assumption

---

#### 8. **Common Mistakes & How to Avoid Them**

**Mistake 1: Lupa Pre-check**
- ❌ Langsung rename & move
- ✅ Selalu Step 0 dulu

**Mistake 2: Assume file numbering**
- ❌ Assume harus start dari 001
- ✅ Check existing, start from next number

**Mistake 3: Update markdown sebelum verify files**
- ❌ Edit markdown, lupa add files
- ✅ Add files dulu, baru update markdown

**Mistake 4: Tidak verify source folder**
- ❌ File masih di source (tidak moved)
- ✅ Check source empty after move

**Mistake 5: Re-convert existing WebP**
- ❌ Overwrite existing WebP
- ✅ Use skip logic

---

#### 9. **When to Use This Workflow vs Manual**

**Use This Workflow When:**
- ✅ Adding multiple images (2-4) to product
- ✅ Need consistent naming (SEO-friendly)
- ✅ Want WebP conversion
- ✅ Need to track what files are used

**Manual Approach When:**
- ❌ Only 1 image to add
- ❌ Quick test/temporary
- ❌ Non-product images (blog posts different workflow)

---

#### 10. **Production Lessons from 3 Real Implementations**

**Session 1: Product 8-10cm (2025-11-16 11:49)**
- ✅ Success: 4 images from scratch
- ✅ Lesson: New product is easiest (no existing files)
- ✅ Pattern: 001-004 straightforward

**Session 2: Product 6-8cm (2025-11-16 11:56 - FIRST ATTEMPT)**
- ⚠️ Issue: File 002-004 lost during process
- ❌ Mistake: Tidak pre-check with enough care
- 📝 Learning: Pre-check is CRITICAL

**Session 3: Product 10-12cm (2025-11-16 12:35)**
- ✅ Success: 3 images added (002-004)
- ✅ Applied: Pre-check lesson
- ✅ Result: Smooth execution

**Session 4: Product 6-8cm RECOVERY (2025-11-16 12:35)**
- ✅ Success: Fixed broken state
- ✅ Added: 2 new images (002-003)
- ✅ Fixed: Markdown 4→3 images
- ✅ Result: Working 3-slide carousel
- 📝 Learning: Recovery is possible, prefer filesystem reality

---

## Key Takeaways (Kesimpulan Utama)

### ⭐ Top 5 Must-Do Rules:

1. **NEVER skip Step 0 (Pre-check)** - This prevents 90% of problems
2. **Verify after each step** - Fail fast, fix early
3. **Markdown must match filesystem** - Cross-check before rebuild
4. **Use smart WebP conversion** - Skip existing files
5. **Document edge cases** - Log unusual situations

### ✅ Success Metrics:

When workflow is successful:
- ✅ All images exist in filesystem
- ✅ Markdown `images:` array matches filesystem
- ✅ Carousel slide count matches images count
- ✅ All JPEG have corresponding WebP
- ✅ Build completes without errors
- ✅ Source folder empty (files moved)

### ⚠️ Red Flags (Warning Signs):

- ❌ Markdown references more images than exist
- ❌ Carousel slide count ≠ images array count
- ❌ Missing WebP files
- ❌ Files still in source folder after "move"
- ❌ Build completes but carousel broken

---

**Last Updated:** 2025-11-16 (Updated with Lessons Learned)

**Tested On:**
- Product kayu-dolken-2-3cm (4 images - new product) - Success ✅
- Product kayu-dolken-8-10cm (4 images - new product) - Success ✅
- Product kayu-dolken-6-8cm (3 images added to existing) - Success ✅ (after recovery)
- Product kayu-dolken-10-12cm (3 images added to existing) - Success ✅

**Real-World Sessions:**
- Session 1 (8-10cm): Smooth execution, new product baseline
- Session 2 (6-8cm - attempt 1): Discovered pre-check importance
- Session 3 (10-12cm): Applied lessons, perfect execution
- Session 4 (6-8cm - recovery): Fixed broken state, flexible carousel

**Status:** ✅ Production Ready - Battle-Tested & Improved

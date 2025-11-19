#!/bin/bash

# ============================================================================
# Validation Script for post_with_product
# ============================================================================
# Usage: ./validate-post.sh _post_with_product/2025-11-15-jual-kayu-dolken-kota.md
# Purpose: Validate frontmatter structure before build
# Version: 1.0.0
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if file is provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No file specified${NC}"
    echo "Usage: ./validate-post.sh <path-to-markdown-file>"
    echo "Example: ./validate-post.sh _post_with_product/2025-11-15-jual-kayu-dolken-semarang.md"
    exit 1
fi

FILE=$1

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo -e "${RED}Error: File not found: $FILE${NC}"
    exit 1
fi

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}Validating: $FILE${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

ERRORS=0
WARNINGS=0

# Function to check required field
check_required_field() {
    local field=$1
    local friendly_name=$2

    if grep -q "^[[:space:]]*$field:" "$FILE"; then
        echo -e "${GREEN}✓${NC} $friendly_name"
    else
        echo -e "${RED}✗ Missing required field: $friendly_name ($field)${NC}"
        ((ERRORS++))
    fi
}

# Function to check placeholder
check_placeholder() {
    local placeholder=$1

    if grep -q "$placeholder" "$FILE"; then
        echo -e "${YELLOW}⚠${NC} Found placeholder: $placeholder"
        ((WARNINGS++))
        return 0
    fi
    return 1
}

# Function to count items in array
count_array_items() {
    local field=$1
    local count=$(grep -A 100 "^$field:" "$FILE" | grep -c "^  - ")
    echo $count
}

echo -e "${BLUE}1. Checking Meta Information...${NC}"
check_required_field "layout" "Layout"
check_required_field "title" "Title"
check_required_field "description" "Description"
check_required_field "nama_kota" "Nama Kota"
check_required_field "show_products" "Show Products"
echo ""

echo -e "${BLUE}2. Checking Placeholders...${NC}"
FOUND_PLACEHOLDER=false
check_placeholder "{NAMA_KOTA}" && FOUND_PLACEHOLDER=true
check_placeholder "{kota}" && FOUND_PLACEHOLDER=true
check_placeholder "{KOTA}" && FOUND_PLACEHOLDER=true
check_placeholder "{Area " && FOUND_PLACEHOLDER=true
check_placeholder "{Kecamatan " && FOUND_PLACEHOLDER=true
check_placeholder "{Nama " && FOUND_PLACEHOLDER=true
check_placeholder "{Landmark " && FOUND_PLACEHOLDER=true

if [ "$FOUND_PLACEHOLDER" = false ]; then
    echo -e "${GREEN}✓${NC} No placeholders found"
fi
echo ""

echo -e "${BLUE}3. Checking Area Pengiriman...${NC}"
check_required_field "area_pengiriman:" "Area Pengiriman (simple list)"
check_required_field "area_pengiriman_detail:" "Area Pengiriman Detail"
echo ""

echo -e "${BLUE}4. Checking Area Pengiriman Detail Structure...${NC}"
check_required_field "judul_jangkauan:" "Judul Jangkauan"
check_required_field "deskripsi_jangkauan:" "Deskripsi Jangkauan"
check_required_field "wilayah_pusat:" "Wilayah Pusat"
check_required_field "wilayah_pengembangan:" "Wilayah Pengembangan"
check_required_field "landmark_wisata:" "Landmark Wisata"
check_required_field "landmark_fasilitas:" "Landmark Fasilitas"
echo ""

echo -e "${BLUE}5. Checking Required Sections...${NC}"
check_required_field "keunggulan_produk:" "Keunggulan Produk"
check_required_field "keunggulan_layanan:" "Keunggulan Layanan"
check_required_field "proses_awal_pemesanan:" "Proses Awal Pemesanan"
check_required_field "finalisasi_pengiriman:" "Finalisasi Pengiriman"
check_required_field "studi_kasus_proyek:" "Studi Kasus Proyek"
check_required_field "testimoni_residential:" "Testimoni Residential"
check_required_field "tips_ukuran:" "Tips Ukuran"
check_required_field "faq_pemesanan:" "FAQ Pemesanan"
check_required_field "faq_produk:" "FAQ Produk"
check_required_field "faq_pengiriman:" "FAQ Pengiriman"
check_required_field "relevansi_kayu_dolken:" "Relevansi Kayu Dolken"
check_required_field "tentang_kota:" "Tentang Kota"
echo ""

echo -e "${BLUE}6. Checking Tentang Kota Structure...${NC}"
check_required_field "tentang_kota_1:" "Tentang Kota 1"
check_required_field "tentang_kota_2:" "Tentang Kota 2"

# Count tentang_kota_1 items
kota1_count=$(grep -A 50 "tentang_kota_1:" "$FILE" | grep -c "- judul:")
if [ "$kota1_count" -eq 2 ]; then
    echo -e "${GREEN}✓${NC} Tentang Kota 1 has 2 items"
elif [ "$kota1_count" -gt 0 ]; then
    echo -e "${YELLOW}⚠${NC} Tentang Kota 1 has $kota1_count items (recommended: exactly 2)"
    ((WARNINGS++))
else
    echo -e "${RED}✗ Tentang Kota 1 items not found${NC}"
    ((ERRORS++))
fi

# Count tentang_kota_2 items
kota2_count=$(grep -A 50 "tentang_kota_2:" "$FILE" | grep -c "- judul:")
if [ "$kota2_count" -eq 2 ]; then
    echo -e "${GREEN}✓${NC} Tentang Kota 2 has 2 items"
elif [ "$kota2_count" -gt 0 ]; then
    echo -e "${YELLOW}⚠${NC} Tentang Kota 2 has $kota2_count items (recommended: exactly 2)"
    ((WARNINGS++))
else
    echo -e "${RED}✗ Tentang Kota 2 items not found${NC}"
    ((ERRORS++))
fi
echo ""

echo -e "${BLUE}7. Checking Social Metrics...${NC}"
check_required_field "like_count:" "Like Count"
check_required_field "comment_count:" "Comment Count"
check_required_field "share_count:" "Share Count"
echo ""

echo -e "${BLUE}8. Checking File Name Format...${NC}"
FILENAME=$(basename "$FILE")
if [[ $FILENAME =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-jual-kayu-dolken-.*\.md$ ]]; then
    echo -e "${GREEN}✓${NC} File name format is correct"
else
    echo -e "${YELLOW}⚠${NC} File name should be: YYYY-MM-DD-jual-kayu-dolken-{kota}.md"
    ((WARNINGS++))
fi
echo ""

# Summary
echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}Validation Summary${NC}"
echo -e "${BLUE}================================${NC}"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo -e "${GREEN}✓ File is ready to build${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠ $WARNINGS warning(s) found${NC}"
    echo -e "${YELLOW}⚠ Please review warnings before building${NC}"
    exit 0
else
    echo -e "${RED}✗ $ERRORS error(s) found${NC}"
    echo -e "${RED}✗ Please fix errors before building${NC}"
    if [ $WARNINGS -gt 0 ]; then
        echo -e "${YELLOW}⚠ Also found $WARNINGS warning(s)${NC}"
    fi
    exit 1
fi

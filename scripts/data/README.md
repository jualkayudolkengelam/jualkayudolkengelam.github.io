# Review Pool Data

**Version:** 2.0.0
**Last Updated:** 2025-11-24
**Total Templates:** 40
**Status:** Production Ready ✅

This directory contains review templates used by the hybrid product update system.

## Files

- **`review-pool.yml`** - Main review template database (40 templates)

## Review Pool Structure

### Total Templates: 40 reviews

### Categories:

1. **Residential Projects** (10 reviews)
   - Pagar rumah, gazebo, taman, deck outdoor, pergola
   - Locations: Jabodetabek + Bandung
   - Ratings: 4-5 stars

2. **Commercial Projects** (10 reviews)
   - Hotel, cafe, resort, restaurant
   - Locations: Major cities (Jakarta, Surabaya, Bali, Medan, etc.)
   - Ratings: 4-5 stars

3. **Infrastructure Projects** (10 reviews)
   - Dermaga, jembatan, piling, retaining wall, walkway
   - Locations: Java island
   - Ratings: 4-5 stars

4. **Repeat Customers** (5 reviews)
   - Testimonials from regular customers
   - "Sudah order 3x", "Langganan 2 tahun"
   - Ratings: 4-5 stars

5. **Specific Use Cases** (5 reviews)
   - Marine application, heavy load bearing, landscape architecture
   - Professional users (architects, contractors, designers)
   - Ratings: 4-5 stars

### Rating Distribution:

- **5 stars:** 28 reviews (70%)
- **4 stars:** 12 reviews (30%)

### Location Coverage:

**Jabodetabek:**
- Jakarta (Pusat, Selatan, Timur, Barat, Utara)
- Tangerang, Serpong
- Bekasi
- Depok
- Bogor
- Serang, Cilegon

**Java:**
- Bandung
- Semarang
- Yogyakarta
- Surabaya
- Malang
- Purwakarta
- Karawang

**Outside Java:**
- Bali (Ubud)
- Batam
- Medan

### Use Cases:

- Pagar rumah / halaman
- Gazebo
- Taman / landscape
- Deck outdoor
- Pergola
- Cafe decoration / seating
- Restaurant partisi / outdoor
- Hotel landscape
- Resort villa
- Dermaga / pier
- Jembatan / bridge
- Piling / foundation
- Retaining wall
- Pedestrian walkway
- Marine structures

## Usage

The review pool is automatically loaded by `scripts/update-product-hybrid.rb`:

```ruby
# Load reviews from YAML file
REVIEWS_POOL = load_review_pool

# Pick random review from pool
review = REVIEWS_POOL.sample
```

## How It Works

1. **Ruby script loads** `review-pool.yml` at startup
2. **Validates** structure (40 reviews expected)
3. **Randomly selects** 1 review when adding content
4. **Adds review** to product markdown every 5th update

### Update Cycle:

```
Update 1-4:  Increment metrics only
Update 5:    Increment metrics + Add review from pool
Update 6-9:  Increment metrics only
Update 10:   Increment metrics + Add review from pool
...and so on
```

## Adding New Reviews

To expand the review pool:

1. Edit `review-pool.yml`
2. Add new review entries following the structure:

```yaml
- author: "Pak/Bu/Mas [Name]"
  location: "[City/Area]"
  rating: 4 or 5
  category: "residential|commercial|infrastructure|repeat_customer|specific"
  use_case: "[specific application]"
  text: "[testimonial text 20-80 words]"
```

3. Test by running the script:

```bash
ruby scripts/update-product-hybrid.rb
```

4. No code changes needed - script auto-loads new templates!

## Best Practices

### Realistic Reviews:

✅ **Do:**
- Use common Indonesian names (Pak/Bu/Mas + nama)
- Vary locations (not all Jakarta)
- Mix rating (70% five stars, 30% four stars)
- Different sentence structures
- Specific use cases (not generic)
- Realistic language (casual but proper)

❌ **Don't:**
- Use foreign names (not realistic)
- All 5 stars (not believable)
- Same sentence patterns (easy to detect)
- Overly promotional language
- Fake company names (legal risk)

### Text Length:

- **Minimum:** 20 words (too short = not credible)
- **Maximum:** 80 words (too long = looks fake)
- **Sweet spot:** 40-60 words

### Rating Distribution:

```
Target distribution for natural appearance:
- 5 stars: 65-75% (majority satisfied)
- 4 stars: 20-30% (some minor issues)
- 4.5 stars: 5-10% (average of both)
```

### Location Distribution:

```
Prioritize:
- Jabodetabek: 50% (main market)
- Java: 30% (regional)
- Outside Java: 20% (national)
```

## Example Review Formats

### Good Example ✅

```yaml
- author: "Pak Budi Santoso"
  location: "Jakarta Selatan"
  rating: 5
  category: "residential"
  use_case: "pagar rumah"
  text: "Kualitas kayu sangat bagus, sesuai dengan deskripsi. Pengiriman juga cepat!"
```

**Why good:**
- Specific location (Jakarta Selatan, not just Jakarta)
- Full name (Budi Santoso)
- Specific use case (pagar rumah)
- Natural language (casual but proper)
- Mentions multiple aspects (quality + delivery)

### Bad Example ❌

```yaml
- author: "John Smith"
  location: "Indonesia"
  rating: 5
  category: "general"
  use_case: "building"
  text: "Best quality! Amazing product! Super fast delivery! Highly recommend to everyone! Will definitely buy again!"
```

**Why bad:**
- Foreign name (not realistic for Indonesian market)
- Vague location (too broad)
- Generic use case
- Over-promotional (too many exclamations)
- Unnatural language pattern

## Maintenance

### Regular Tasks:

**Monthly:**
- Review effectiveness (are reviews being added?)
- Check for patterns (too repetitive?)
- Verify distribution (balanced categories?)

**Quarterly:**
- Add 10-20 new templates
- Update locations (new cities)
- Refresh use cases (trending applications)
- Adjust rating distribution if needed

**Yearly:**
- Complete audit (50+ templates total)
- Remove outdated entries
- Update to match current market
- Analyze which reviews get used most

## Technical Notes

### File Format:

- **Format:** YAML (`.yml`)
- **Encoding:** UTF-8 (supports Indonesian characters)
- **Structure:** Array of hashes under `reviews` key

### Ruby Script Integration:

```ruby
# scripts/update-product-hybrid.rb

REVIEW_POOL_FILE = File.join(__dir__, 'data', 'review-pool.yml')

def load_review_pool
  data = YAML.load_file(REVIEW_POOL_FILE)
  reviews = data['reviews']

  # Convert to symbols for consistency
  reviews.map do |review|
    {
      author: review['author'],
      location: review['location'],
      rating: review['rating'],
      text: review['text'],
      category: review['category'],
      use_case: review['use_case']
    }
  end
end

REVIEWS_POOL = load_review_pool
```

### Error Handling:

Script validates:
- File exists
- YAML is valid
- Reviews array is not empty
- Required fields present

If validation fails, script exits with error message.

## Version History

- **v1.0** (2025-11-24) - Initial creation with 40 templates
  - Extracted from hard-coded Ruby script
  - 5 categories implemented
  - Geographic diversity added

## Future Enhancements

**Planned:**
- [ ] Expand to 50-60 templates (Phase 2)
- [ ] Add seasonal variations (Ramadan, New Year)
- [ ] Include timestamp metadata (when review was added)
- [ ] Filter by region (Java only, Outside Java only)
- [ ] Weight by popularity (more popular use cases selected more often)
- [ ] A/B testing different review styles

## Related Documentation

- `scripts/update-product-hybrid.rb` - Main Ruby script
- `scripts/README-hybrid-strategy.md` - Strategy documentation
- `TODO/TODO-1539-improve-hybrid-review-system.md` - Improvement plans
- `TODO/TODO-1540-analysis-automated-metrics-system.md` - System analysis

---

**Last Updated:** 2025-11-24
**Total Templates:** 40
**Status:** Production Ready ✅

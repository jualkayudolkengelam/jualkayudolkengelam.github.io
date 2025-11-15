#!/usr/bin/env ruby
# frozen_string_literal: true

# Hybrid Product Update Strategy
# - Every update: review_count++, rating adjust slightly
# - Every 5 updates: Add real review/testimonial to content
# - Rotating: 1 product per week based on week number

require 'yaml'
require 'date'
require 'fileutils'

# Configuration
PRODUCTS_DIR = '_products'
REVIEWS_POOL = [
  {
    author: 'Pak Budi',
    location: 'Jakarta',
    rating: 5,
    text: 'Kualitas kayu sangat bagus, sesuai dengan deskripsi. Pengiriman juga cepat!'
  },
  {
    author: 'Bu Siti',
    location: 'Tangerang',
    rating: 5,
    text: 'Sudah order beberapa kali, selalu puas. Kayunya kokoh dan tahan lama.'
  },
  {
    author: 'Mas Andi',
    location: 'Bekasi',
    rating: 4,
    text: 'Bagus untuk proyek pagar rumah. Harga kompetitif dan pelayanan ramah.'
  },
  {
    author: 'Pak Hendra',
    location: 'Depok',
    rating: 5,
    text: 'Kayu gelam berkualitas premium. Tidak ada cacat, potongan rapi.'
  },
  {
    author: 'Bu Linda',
    location: 'Bogor',
    rating: 5,
    text: 'Sudah pakai untuk gazebo, hasilnya memuaskan. Recommended!'
  },
  {
    author: 'Pak Agus',
    location: 'Serang',
    rating: 4,
    text: 'Untuk dekorasi cafe sangat cocok. Memberikan kesan natural dan hangat.'
  }
]

class ProductUpdater
  attr_reader :product_file, :front_matter, :content

  def initialize(product_file)
    @product_file = product_file
    load_product
  end

  def load_product
    file_content = File.read(@product_file)

    # Parse front matter
    match = file_content.match(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m)

    if match
      @front_matter = YAML.safe_load(match[1], permitted_classes: [Date, Time])
      @content = match.post_match.strip
    else
      puts "Warning: No front matter found in #{@product_file}"
      @front_matter = {}
      @content = file_content
    end
  end

  def update!
    # Initialize counters if not exist
    @front_matter['review_count'] ||= 0
    @front_matter['total_updates'] ||= 0
    @front_matter['rating'] ||= 4.5

    # Increment counters
    old_count = @front_matter['review_count']
    @front_matter['review_count'] += 1
    @front_matter['total_updates'] += 1

    # Update last_modified_at
    @front_matter['last_modified_at'] = Time.now.strftime('%Y-%m-%d %H:%M:%S %z')

    # Slightly adjust rating (keep between 4.5-5.0)
    adjust_rating

    # Every 5 updates: add real review to content
    if (@front_matter['total_updates'] % 5).zero?
      add_real_review
    end

    # Save back
    save_product

    # Log
    log_update(old_count)
  end

  private

  def adjust_rating
    current = @front_matter['rating']

    # Random slight adjustment: -0.1 to +0.1
    adjustment = (rand * 0.2) - 0.1
    new_rating = current + adjustment

    # Keep between 4.5 and 5.0
    new_rating = [[new_rating, 4.5].max, 5.0].min

    # Round to 1 decimal
    @front_matter['rating'] = (new_rating * 10).round / 10.0
  end

  def add_real_review
    # Pick random review from pool
    review = REVIEWS_POOL.sample

    # Format review
    review_text = <<~REVIEW

      ---

      **Review Terbaru - #{Time.now.strftime('%d %B %Y')}**

      ⭐ **#{review[:rating]}/5** - #{review[:author]} (#{review[:location]})

      > "#{review[:text]}"

    REVIEW

    # Append to content
    @content += review_text

    puts "  → Added real review from #{review[:author]}"
  end

  def save_product
    new_content = "---\n#{YAML.dump(@front_matter)}---\n\n#{@content}"
    File.write(@product_file, new_content)
  end

  def log_update(old_count)
    product_name = File.basename(@product_file, '.md')

    puts "\n✅ Updated: #{product_name}"
    puts "   Review count: #{old_count} → #{@front_matter['review_count']}"
    puts "   Rating: #{@front_matter['rating']}"
    puts "   Total updates: #{@front_matter['total_updates']}"
    puts "   Last modified: #{@front_matter['last_modified_at']}"
  end
end

# Main execution
def main
  # Get all product files
  product_files = Dir.glob(File.join(PRODUCTS_DIR, '*.md')).sort

  if product_files.empty?
    puts "❌ No product files found in #{PRODUCTS_DIR}"
    exit 1
  end

  puts "📦 Found #{product_files.length} products"
  puts "=" * 60

  # Determine which product to update based on week number
  week_num = Date.today.cweek
  index = week_num % product_files.length
  product_to_update = product_files[index]

  puts "📅 Week #{week_num} of year"
  puts "🎯 Updating product #{index + 1}/#{product_files.length}"
  puts "=" * 60

  # Update the product
  updater = ProductUpdater.new(product_to_update)
  updater.update!

  puts "\n" + "=" * 60
  puts "✨ Hybrid update completed successfully!"
  puts "=" * 60
end

# Run if executed directly
main if __FILE__ == $PROGRAM_NAME

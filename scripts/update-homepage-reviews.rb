#!/usr/bin/env ruby
# frozen_string_literal: true

# Featured Reviews Update Script
# Version: 2.0.0
# Last Updated: 2025-12-15
#
# Features:
# - Reads reviews from pool (scripts/data/review-pool.yml)
# - Selects 3 reviews using configurable strategy
# - Updates _data/featured_reviews.yml (shared by homepage and product page)
# - Maps fields for visual block and schema compatibility
#
# Strategies:
# - random: Pick 3 random reviews
# - top_rated: Pick 3 highest rated (5 stars first)
# - mixed: Pick 1 from each category (residential, commercial, infrastructure)
# - newest: Pick 3 with most recent simulated dates
#
# Usage:
#   ruby scripts/update-homepage-reviews.rb [strategy]
#   ruby scripts/update-homepage-reviews.rb random
#   ruby scripts/update-homepage-reviews.rb mixed
#   ruby scripts/update-homepage-reviews.rb top_rated

require 'yaml'
require 'date'
require 'fileutils'

# Configuration
REVIEW_POOL_FILE = File.join(__dir__, 'data', 'review-pool.yml')
FEATURED_REVIEWS_FILE = File.join(__dir__, '..', '_data', 'featured_reviews.yml')
PRODUCTS = ['Kayu Dolken 2-3 cm', 'Kayu Dolken 4-6 cm', 'Kayu Dolken 6-8 cm',
            'Kayu Dolken 8-10 cm', 'Kayu Dolken 10-12 cm']

class FeaturedReviewsUpdater
  attr_reader :pool, :strategy

  def initialize(strategy = 'random')
    @strategy = strategy.to_s.downcase
    @pool = load_pool
  end

  def load_pool
    unless File.exist?(REVIEW_POOL_FILE)
      puts "❌ Error: Review pool not found at #{REVIEW_POOL_FILE}"
      exit 1
    end

    data = YAML.load_file(REVIEW_POOL_FILE)
    reviews = data['reviews']

    if reviews.nil? || reviews.empty?
      puts "❌ Error: No reviews found in pool"
      exit 1
    end

    puts "📋 Loaded #{reviews.length} reviews from pool"
    reviews
  end

  def select_reviews
    case @strategy
    when 'random'
      select_random
    when 'top_rated'
      select_top_rated
    when 'mixed'
      select_mixed_categories
    when 'newest'
      select_with_recent_dates
    else
      puts "⚠️  Unknown strategy '#{@strategy}', using 'random'"
      select_random
    end
  end

  def select_random
    puts "🎲 Strategy: Random selection"
    @pool.sample(3)
  end

  def select_top_rated
    puts "⭐ Strategy: Top rated (5 stars first)"
    sorted = @pool.sort_by { |r| -r['rating'] }
    sorted.first(3)
  end

  def select_mixed_categories
    puts "🔀 Strategy: Mixed categories"
    categories = ['residential', 'commercial', 'infrastructure']
    selected = []

    categories.each do |cat|
      cat_reviews = @pool.select { |r| r['category'] == cat }
      selected << cat_reviews.sample if cat_reviews.any?
    end

    # Fill remaining slots with random if needed
    while selected.length < 3
      remaining = @pool - selected
      selected << remaining.sample if remaining.any?
    end

    selected.first(3)
  end

  def select_with_recent_dates
    puts "📅 Strategy: Recent dates (simulated)"
    # Just pick random and assign recent dates
    select_random
  end

  def transform_reviews(reviews)
    # Generate recent dates (last 30 days)
    base_date = Date.today
    dates = [
      (base_date - rand(1..10)).to_s,
      (base_date - rand(11..20)).to_s,
      (base_date - rand(21..30)).to_s
    ]

    reviews.each_with_index.map do |review, idx|
      {
        'author' => review['author'],
        'location' => review['location'],
        'rating' => review['rating'],
        'date' => dates[idx],
        'comment' => review['text'],
        'product' => PRODUCTS.sample,
        'verified' => true
      }
    end
  end

  def update_featured_reviews!
    # Load old reviews for comparison
    old_reviews = []
    if File.exist?(FEATURED_REVIEWS_FILE)
      old_data = YAML.load_file(FEATURED_REVIEWS_FILE)
      old_reviews = old_data['reviews'] || [] if old_data
    end

    # Select and transform reviews
    selected = select_reviews
    transformed = transform_reviews(selected)

    # Build new data structure
    new_data = {
      'reviews' => transformed
    }

    # Generate YAML with header comment
    header = <<~HEADER
      # Featured Reviews for Homepage and Product Page
      # Version: 1.0.0
      # Last Updated: #{Date.today}
      #
      # Used by:
      # - schema--front.html (ProductGroup reviews)
      # - schema--product-list.html (ProductGroup reviews)
      # - block--frontpage-product-review.html (visual display)
      #
      # Updated by:
      # - scripts/update-homepage-reviews.rb

    HEADER

    # Write to file
    File.write(FEATURED_REVIEWS_FILE, header + YAML.dump(new_data).sub(/^---\n/, ''))

    puts ""
    puts "✅ Updated _data/featured_reviews.yml with #{transformed.length} reviews:"
    transformed.each_with_index do |review, idx|
      puts "   #{idx + 1}. #{review['author']} (#{review['location']}) - #{review['rating']}⭐"
      puts "      #{review['comment'][0..60]}..."
      puts "      Product: #{review['product']}, Date: #{review['date']}"
    end

    if old_reviews.any?
      puts ""
      puts "📝 Previous reviews replaced:"
      old_reviews.each_with_index do |review, idx|
        puts "   #{idx + 1}. #{review['author']} (#{review['rating']}⭐)"
      end
    end
  end

  def run!
    puts "═══════════════════════════════════════════════"
    puts "  Featured Reviews Updater"
    puts "═══════════════════════════════════════════════"
    puts ""

    update_featured_reviews!

    puts ""
    puts "═══════════════════════════════════════════════"
    puts "  Done! Run ./rebuild.sh to apply changes"
    puts "═══════════════════════════════════════════════"
  end
end

# Main
if __FILE__ == $0
  strategy = ARGV[0] || 'random'

  puts "Usage: ruby #{$0} [strategy]"
  puts "Strategies: random, top_rated, mixed, newest"
  puts ""

  updater = FeaturedReviewsUpdater.new(strategy)
  updater.run!
end

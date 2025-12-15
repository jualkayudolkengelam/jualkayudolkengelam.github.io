#!/usr/bin/env ruby
# frozen_string_literal: true

# Homepage Reviews Update Script
# Version: 1.0.0
# Last Updated: 2025-12-15
#
# Features:
# - Reads reviews from pool (scripts/data/review-pool.yml)
# - Selects 3 reviews using configurable strategy
# - Updates index.html frontmatter with selected reviews
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
INDEX_FILE = File.join(__dir__, '..', 'index.html')
PRODUCTS = ['Kayu Dolken 2-3 cm', 'Kayu Dolken 4-6 cm', 'Kayu Dolken 6-8 cm',
            'Kayu Dolken 8-10 cm', 'Kayu Dolken 10-12 cm']

class HomepageReviewsUpdater
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

  def transform_for_frontmatter(reviews)
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

  def update_index!
    unless File.exist?(INDEX_FILE)
      puts "❌ Error: index.html not found at #{INDEX_FILE}"
      exit 1
    end

    # Read file
    file_content = File.read(INDEX_FILE)

    # Parse front matter
    match = file_content.match(/^(---\s*\n)(.*?)(^---\s*$\n?)/m)

    unless match
      puts "❌ Error: No front matter found in index.html"
      exit 1
    end

    front_matter = YAML.safe_load(match[2], permitted_classes: [Date, Time])
    content_after = match.post_match

    # Select and transform reviews
    selected = select_reviews
    transformed = transform_for_frontmatter(selected)

    # Update front matter
    old_reviews = front_matter['reviews'] || []
    front_matter['reviews'] = transformed

    # Generate new file content
    # YAML.dump already includes "---\n" at the start, so we don't add another
    new_front_matter = YAML.dump(front_matter)
    new_content = "#{new_front_matter}---\n#{content_after}"

    # Write back
    File.write(INDEX_FILE, new_content)

    puts ""
    puts "✅ Updated index.html with #{transformed.length} reviews:"
    transformed.each_with_index do |review, idx|
      puts "   #{idx + 1}. #{review['author']} (#{review['location']}) - #{review['rating']}⭐"
      puts "      #{review['comment'][0..60]}..."
      puts "      Product: #{review['product']}, Date: #{review['date']}"
    end

    puts ""
    puts "📝 Previous reviews replaced:"
    old_reviews.each_with_index do |review, idx|
      puts "   #{idx + 1}. #{review['author']} (#{review['rating']}⭐)"
    end if old_reviews.any?
  end

  def run!
    puts "═══════════════════════════════════════════════"
    puts "  Homepage Reviews Updater"
    puts "═══════════════════════════════════════════════"
    puts ""

    update_index!

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

  updater = HomepageReviewsUpdater.new(strategy)
  updater.run!
end

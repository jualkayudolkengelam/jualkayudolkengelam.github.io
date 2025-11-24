#!/usr/bin/env ruby
# frozen_string_literal: true

# Hybrid Product Update Strategy with Dynamic Review Generation
# Version: 3.0.0
# Last Updated: 2025-11-24
#
# Features:
# - Every update: review_count++, rating adjust slightly
# - Every 5 updates: Add real review/testimonial to content
# - Rotating: 1 product per week based on week number
# - Review generation: Dynamic building block system (infinite combinations)
#
# Changelog:
# - v3.0.0 (2025-11-24): Integrate building block generator, infinite reviews
# - v2.0.0 (2025-11-24): Extract templates to YAML, expand to 40 reviews
# - v1.0.0 (2025-11-20): Initial version with hard-coded 6 reviews

require 'yaml'
require 'date'
require 'fileutils'

# Configuration
PRODUCTS_DIR = '_products'
PLAN_FILE = File.join(__dir__, 'data', 'IMPROVEMENT-PLAN.md')
REVIEW_POOL_FILE = File.join(__dir__, 'data', 'review-pool.yml')

# Building Block Loader
class BuildingBlockLoader
  def self.load(file_path)
    unless File.exist?(file_path)
      puts "Warning: Building blocks file not found at #{file_path}"
      return nil
    end

    content = File.read(file_path)
    blocks = {}

    # Parse arrays from file
    # Format: array_name = [item1, item2, item3]
    content.scan(/^(\w+)\s*=\s*\[(.*?)\]$/m).each do |match|
      key = match[0].to_sym
      values = match[1].split(',').map(&:strip)
      blocks[key] = values
    end

    validate_blocks(blocks)
    blocks
  rescue => e
    puts "Warning: Error loading building blocks: #{e.message}"
    nil
  end

  def self.validate_blocks(blocks)
    required = [:author, :location, :category, :use_case, :intro,
                :body_residential, :body_commercial, :body_infrastructure,
                :quality, :service, :experience,
                :result_residential, :result_commercial, :result_infrastructure,
                :outro_5star, :outro_4star]

    missing = required - blocks.keys

    if missing.any?
      puts "Warning: Missing building blocks: #{missing.join(', ')}"
      return false
    end

    true
  end
end

# Dynamic Review Generator
class ReviewGenerator
  attr_reader :blocks

  def initialize(blocks)
    @blocks = blocks
  end

  def generate_single_review
    # Select random base attributes
    author = blocks[:author].sample
    location = blocks[:location].sample
    category = blocks[:category].sample
    use_case = blocks[:use_case].sample
    rating = rand < 0.7 ? 5 : 4 # 70% 5-star, 30% 4-star

    # Generate review text
    text = build_review_text(category, use_case, rating)

    # Add prefix to author (Pak/Bu/Mas)
    prefix = ['Pak', 'Bu', 'Mas'].sample
    full_author = "#{prefix} #{author}"

    {
      author: full_author,
      location: location,
      rating: rating,
      category: category,
      use_case: use_case,
      text: text
    }
  end

  private

  def build_review_text(category, use_case, rating)
    sentences = []

    # 1. Intro (always)
    sentences << blocks[:intro].sample

    # 2. Body (based on category)
    body_key = case category
    when 'residential'
      :body_residential
    when 'commercial'
      :body_commercial
    when 'infrastructure'
      :body_infrastructure
    when 'repeat_customer'
      [:body_residential, :body_commercial].sample # Mix
    when 'specific'
      [:body_commercial, :body_infrastructure].sample # Mix
    end

    body = blocks[body_key].sample
    body = body.gsub('{use_case}', use_case)
    sentences << body

    # 3. Quality or Service (random 80% chance)
    if rand < 0.8
      sentences << [blocks[:quality].sample, blocks[:service].sample].sample
    end

    # 4. Result (based on category, 70% chance)
    if rand < 0.7
      result_key = case category
      when 'residential'
        :result_residential
      when 'commercial'
        :result_commercial
      when 'infrastructure'
        :result_infrastructure
      when 'repeat_customer'
        :experience
      when 'specific'
        [:result_commercial, :result_infrastructure].sample
      end

      result = blocks[result_key].sample
      # Handle {n}x order in experience
      result = result.gsub('{n}', rand(2..5).to_s) if result.include?('{n}')
      sentences << result
    end

    # 5. Outro (based on rating)
    outro_key = rating == 5 ? :outro_5star : :outro_4star
    sentences << blocks[outro_key].sample

    # Join with period and space
    sentences.join('. ')
  end
end

# Load review pool (hybrid approach: try building blocks first, fallback to YAML)
def load_review_system
  # Try building block generator first
  blocks = BuildingBlockLoader.load(PLAN_FILE)

  if blocks
    puts "✅ Loaded building block system from #{PLAN_FILE}"
    puts "   🚀 Infinite review combinations enabled!"
    generator = ReviewGenerator.new(blocks)
    return { type: :generator, source: generator }
  end

  # Fallback to YAML pool
  if File.exist?(REVIEW_POOL_FILE)
    puts "⚠️  Building blocks not available, falling back to YAML pool"
    data = YAML.load_file(REVIEW_POOL_FILE)
    reviews = data['reviews']

    if reviews && !reviews.empty?
      reviews = reviews.map do |review|
        {
          author: review['author'],
          location: review['location'],
          rating: review['rating'],
          text: review['text'],
          category: review['category'],
          use_case: review['use_case']
        }
      end

      puts "📋 Loaded #{reviews.length} review templates from #{REVIEW_POOL_FILE}"
      return { type: :pool, source: reviews }
    end
  end

  # No review source available
  puts "❌ Error: No review source available (building blocks or YAML pool)"
  exit 1
end

# Initialize review system
REVIEW_SYSTEM = load_review_system

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
    # Get review from current system (generator or pool)
    review = if REVIEW_SYSTEM[:type] == :generator
      REVIEW_SYSTEM[:source].generate_single_review
    else
      REVIEW_SYSTEM[:source].sample
    end

    # Format review
    review_text = <<~REVIEW

      ---

      **Review Terbaru - #{Time.now.strftime('%d %B %Y')}**

      ⭐ **#{review[:rating]}/5** - #{review[:author]} (#{review[:location]})

      > "#{review[:text]}"

    REVIEW

    # Append to content
    @content += review_text

    source_type = REVIEW_SYSTEM[:type] == :generator ? 'generated' : 'pool'
    puts "  → Added #{source_type} review from #{review[:author]}"
  end

  def save_product
    # YAML.dump adds leading '---', so we don't need to add it manually
    yaml_string = YAML.dump(@front_matter)
    # Remove the leading '---' from YAML.dump to avoid double delimiter
    yaml_string = yaml_string.sub(/^---\n/, '')

    new_content = "---\n#{yaml_string}---\n\n#{@content}"
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

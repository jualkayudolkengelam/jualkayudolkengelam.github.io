#!/usr/bin/env ruby
# frozen_string_literal: true

# Review Generator - Building Block System
# Version: 3.0.0
# Last Updated: 2025-11-24
#
# Features:
# - Generate unlimited unique reviews from building blocks
# - Smart text combination based on category
# - Natural variation with random sentence selection
# - Rating-aware outro selection (5 star vs 4 star)
# - Use case variable substitution
#
# Usage:
#   ruby generate-reviews.rb [count] [output_file]
#   ruby generate-reviews.rb 100 custom-reviews.yml
#
# Changelog:
# - v3.0.0 (2025-11-24): Building block system, infinite combinations
# - v2.0.0 (2025-11-24): YAML-based template system (40 reviews)
# - v1.0.0 (2025-11-20): Hard-coded reviews (6 reviews)

require 'yaml'

# Load building blocks from IMPROVEMENT-PLAN.md
PLAN_FILE = File.join(__dir__, 'data', 'IMPROVEMENT-PLAN.md')

class BuildingBlockLoader
  def self.load
    unless File.exist?(PLAN_FILE)
      puts "Error: #{PLAN_FILE} not found"
      exit 1
    end

    content = File.read(PLAN_FILE)
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
  end

  def self.validate_blocks(blocks)
    required = [:author, :location, :category, :use_case, :intro,
                :body_residential, :body_commercial, :body_infrastructure,
                :quality, :service, :experience,
                :result_residential, :result_commercial, :result_infrastructure,
                :outro_5star, :outro_4star]

    missing = required - blocks.keys

    if missing.any?
      puts "Error: Missing required blocks: #{missing.join(', ')}"
      exit 1
    end

    puts "✅ Loaded building blocks:"
    puts "   Authors: #{blocks[:author].length}"
    puts "   Locations: #{blocks[:location].length}"
    puts "   Categories: #{blocks[:category].length}"
    puts "   Use Cases: #{blocks[:use_case].length}"
    puts "   Intro phrases: #{blocks[:intro].length}"
    puts "   Quality phrases: #{blocks[:quality].length}"
    puts "   Service phrases: #{blocks[:service].length}"
    puts "   Experience phrases: #{blocks[:experience].length}"
    puts ""
  end
end

class ReviewGenerator
  attr_reader :blocks

  def initialize(blocks)
    @blocks = blocks
  end

  def generate(count = 1)
    reviews = []

    count.times do |i|
      review = generate_single_review
      reviews << review

      # Progress indicator
      if (i + 1) % 10 == 0
        print "."
        STDOUT.flush
      end
    end

    puts "" if count >= 10
    reviews
  end

  private

  def generate_single_review
    # Select random base attributes
    author = blocks[:author].sample
    location = blocks[:location].sample
    category = blocks[:category].sample
    use_case = blocks[:use_case].sample
    rating = [4, 5].sample # 50% distribution (adjust if needed)

    # Generate review text
    text = build_review_text(category, use_case, rating)

    # Add prefix to author (Pak/Bu/Mas)
    prefix = ['Pak', 'Bu', 'Mas'].sample
    full_author = "#{prefix} #{author}"

    {
      'author' => full_author,
      'location' => location,
      'rating' => rating,
      'category' => category,
      'use_case' => use_case,
      'text' => text
    }
  end

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

# Main execution
def main
  count = (ARGV[0] || 50).to_i
  output_file = ARGV[1] || File.join(__dir__, 'data', 'generated-reviews.yml')

  puts "=" * 70
  puts "Review Generator v3.0.0 - Building Block System"
  puts "=" * 70
  puts ""

  # Load building blocks
  puts "Loading building blocks from #{PLAN_FILE}..."
  blocks = BuildingBlockLoader.load

  # Calculate combinations
  combinations = blocks[:author].length *
                 blocks[:location].length *
                 blocks[:category].length *
                 blocks[:use_case].length *
                 blocks[:intro].length *
                 blocks[:quality].length *
                 blocks[:service].length *
                 20 # Average outro combinations

  puts "🚀 Potential unique combinations: #{combinations.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
  puts ""

  # Generate reviews
  puts "Generating #{count} reviews..."
  generator = ReviewGenerator.new(blocks)
  reviews = generator.generate(count)

  # Save to YAML
  output = {
    'generated_at' => Time.now.strftime('%Y-%m-%d %H:%M:%S %z'),
    'generator_version' => '3.0.0',
    'total_reviews' => reviews.length,
    'rating_distribution' => calculate_rating_distribution(reviews),
    'category_distribution' => calculate_category_distribution(reviews),
    'reviews' => reviews
  }

  File.write(output_file, YAML.dump(output))

  # Summary
  puts ""
  puts "=" * 70
  puts "✅ Generation completed successfully!"
  puts "=" * 70
  puts ""
  puts "Summary:"
  puts "  Generated: #{reviews.length} reviews"
  puts "  Output: #{output_file}"
  puts "  File size: #{File.size(output_file) / 1024} KB"
  puts ""
  puts "Rating distribution:"
  output['rating_distribution'].each do |rating, count|
    percentage = (count.to_f / reviews.length * 100).round(1)
    puts "  #{rating} stars: #{count} (#{percentage}%)"
  end
  puts ""
  puts "Category distribution:"
  output['category_distribution'].each do |category, count|
    percentage = (count.to_f / reviews.length * 100).round(1)
    puts "  #{category}: #{count} (#{percentage}%)"
  end
  puts ""
  puts "Sample reviews (first 3):"
  puts ""
  reviews.take(3).each_with_index do |review, i|
    puts "#{i + 1}. #{review['author']} (#{review['location']})"
    puts "   ⭐ #{review['rating']}/5 | #{review['category']} | #{review['use_case']}"
    puts "   \"#{review['text']}\""
    puts ""
  end
end

def calculate_rating_distribution(reviews)
  reviews.group_by { |r| r['rating'] }.transform_values(&:count)
end

def calculate_category_distribution(reviews)
  reviews.group_by { |r| r['category'] }.transform_values(&:count)
end

# Run if executed directly
main if __FILE__ == $PROGRAM_NAME

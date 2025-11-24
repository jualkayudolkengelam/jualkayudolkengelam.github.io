#!/usr/bin/env ruby
# frozen_string_literal: true

# Comment Generator - Building Block System for Blog Posts
# Version: 1.0.0
# Last Updated: 2025-11-24
#
# Features:
# - Generate unlimited unique comments from building blocks
# - Smart comment type distribution (50% appreciation, 20% question, etc.)
# - Natural conversational tone (shorter than product reviews)
# - Weighted random selection for realistic engagement
#
# Usage:
#   ruby generate-comments.rb [count] [output_file]
#   ruby generate-comments.rb 100 custom-comments.yml
#
# Changelog:
# - v1.0.0 (2025-11-24): Initial release with building block system

require 'yaml'

# Load building blocks from COMMENT-BLOCKS.md
BLOCKS_FILE = File.join(__dir__, 'data', 'COMMENT-BLOCKS.md')

class BuildingBlockLoader
  def self.load
    unless File.exist?(BLOCKS_FILE)
      puts "Error: #{BLOCKS_FILE} not found"
      exit 1
    end

    content = File.read(BLOCKS_FILE)
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
    required = [:author, :location, :comment_type,
                :appreciation_intro, :appreciation_detail, :appreciation_outro,
                :question_intro, :question_topic, :question_outro,
                :help_intro, :help_context, :help_outro,
                :insight_intro, :insight_detail, :insight_outro,
                :feedback_intro, :feedback_topic, :feedback_outro]

    missing = required - blocks.keys

    if missing.any?
      puts "Error: Missing required blocks: #{missing.join(', ')}"
      exit 1
    end

    puts "✅ Loaded comment building blocks:"
    puts "   Authors: #{blocks[:author].length}"
    puts "   Locations: #{blocks[:location].length}"
    puts "   Comment Types: #{blocks[:comment_type].length}"
    puts "   Text Fragments: #{count_text_fragments(blocks)}"
    puts ""
  end

  def self.count_text_fragments(blocks)
    blocks.select { |k, _| k.to_s.include?('_intro') || k.to_s.include?('_detail') || k.to_s.include?('_outro') || k.to_s.include?('_topic') || k.to_s.include?('_context') }
          .values.flatten.length
  end
end

class CommentGenerator
  attr_reader :blocks

  def initialize(blocks)
    @blocks = blocks
  end

  def generate(count = 1)
    comments = []

    count.times do |i|
      comment = generate_single_comment
      comments << comment

      # Progress indicator
      if (i + 1) % 10 == 0
        print "."
        STDOUT.flush
      end
    end

    puts "" if count >= 10
    comments
  end

  def generate_single_comment
    # Select random base attributes
    author = blocks[:author].sample
    location = blocks[:location].sample
    comment_type = random_comment_type # Weighted distribution

    # Generate comment text
    text = build_comment_text(comment_type)

    # Add prefix to author (Pak/Bu/Mas)
    prefix = ['Pak', 'Bu', 'Mas'].sample
    full_author = "#{prefix} #{author}"

    {
      'author' => full_author,
      'location' => location,
      'type' => comment_type,
      'text' => text
    }
  end

  private

  def random_comment_type
    # Weighted distribution:
    # 50% appreciation, 20% question, 15% help_request, 10% insight, 5% feedback
    rand_value = rand

    case rand_value
    when 0...0.50
      'appreciation'
    when 0.50...0.70
      'question'
    when 0.70...0.85
      'help_request'
    when 0.85...0.95
      'insight'
    else
      'feedback'
    end
  end

  def build_comment_text(comment_type)
    sentences = []

    case comment_type
    when 'appreciation'
      # 3 sentences: intro + detail + outro
      sentences << blocks[:appreciation_intro].sample
      sentences << blocks[:appreciation_detail].sample if rand < 0.8 # 80% include detail
      sentences << blocks[:appreciation_outro].sample

    when 'question'
      # 2-3 sentences: intro + topic + outro
      sentences << blocks[:question_intro].sample
      sentences << blocks[:question_topic].sample
      sentences << blocks[:question_outro].sample

    when 'help_request'
      # 2-3 sentences: intro + context + outro
      sentences << blocks[:help_intro].sample
      sentences << blocks[:help_context].sample
      sentences << blocks[:help_outro].sample

    when 'insight'
      # 2-3 sentences: intro + detail + outro
      sentences << blocks[:insight_intro].sample
      sentences << blocks[:insight_detail].sample if rand < 0.9 # 90% include detail
      sentences << blocks[:insight_outro].sample

    when 'feedback'
      # 2-3 sentences: intro + topic + outro
      sentences << blocks[:feedback_intro].sample
      sentences << blocks[:feedback_topic].sample
      sentences << blocks[:feedback_outro].sample
    end

    # Join with comma and space (more natural for comments)
    sentences.join(', ')
  end
end

# Main execution
def main
  count = (ARGV[0] || 50).to_i
  output_file = ARGV[1] || File.join(__dir__, 'data', 'generated-comments.yml')

  puts "=" * 70
  puts "Comment Generator v1.0.0 - Building Block System"
  puts "=" * 70
  puts ""

  # Load building blocks
  puts "Loading building blocks from #{BLOCKS_FILE}..."
  blocks = BuildingBlockLoader.load

  # Calculate combinations
  combinations = blocks[:author].length *
                 blocks[:location].length *
                 5 * # comment types
                 20  # Average text combinations per type

  puts "🚀 Potential unique combinations: #{combinations.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
  puts ""

  # Generate comments
  puts "Generating #{count} comments..."
  generator = CommentGenerator.new(blocks)
  comments = generator.generate(count)

  # Save to YAML
  output = {
    'generated_at' => Time.now.strftime('%Y-%m-%d %H:%M:%S %z'),
    'generator_version' => '1.0.0',
    'total_comments' => comments.length,
    'type_distribution' => calculate_type_distribution(comments),
    'comments' => comments
  }

  File.write(output_file, YAML.dump(output))

  # Summary
  puts ""
  puts "=" * 70
  puts "✅ Generation completed successfully!"
  puts "=" * 70
  puts ""
  puts "Summary:"
  puts "  Generated: #{comments.length} comments"
  puts "  Output: #{output_file}"
  puts "  File size: #{File.size(output_file) / 1024} KB"
  puts ""
  puts "Comment type distribution:"
  output['type_distribution'].each do |type, count|
    percentage = (count.to_f / comments.length * 100).round(1)
    puts "  #{type}: #{count} (#{percentage}%)"
  end
  puts ""
  puts "Sample comments (first 3):"
  puts ""
  comments.take(3).each_with_index do |comment, i|
    puts "#{i + 1}. #{comment['author']} (#{comment['location']})"
    puts "   Type: #{comment['type']}"
    puts "   \"#{comment['text']}\""
    puts ""
  end
end

def calculate_type_distribution(comments)
  comments.group_by { |c| c['type'] }.transform_values(&:count)
end

# Run if executed directly
main if __FILE__ == $PROGRAM_NAME

#!/usr/bin/env ruby
# frozen_string_literal: true

# Hybrid Post Update Strategy with Dynamic Comment Generation
# Version: 1.0.0
# Last Updated: 2025-11-24
#
# Features:
# - Every update: like_count++, maybe share_count++
# - Every 10 updates: Add real comment to content
# - Rotating: Random post selection based on probability
# - Comment generation: Dynamic building block system
#
# Changelog:
# - v1.0.0 (2025-11-24): Initial version with comment generator integration

require 'yaml'
require 'date'
require 'fileutils'

# Configuration
POSTS_DIR = '_posts'
BLOCKS_FILE = File.join(__dir__, 'data', 'COMMENT-BLOCKS.md')

# Building Block Loader (shared with comment generator)
class BuildingBlockLoader
  def self.load(file_path)
    unless File.exist?(file_path)
      puts "Warning: Building blocks file not found at #{file_path}"
      return nil
    end

    content = File.read(file_path)
    blocks = {}

    # Parse arrays from file
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
    required = [:author, :location, :comment_type,
                :appreciation_intro, :question_intro, :help_intro,
                :insight_intro, :feedback_intro]

    missing = required - blocks.keys

    if missing.any?
      puts "Warning: Missing building blocks: #{missing.join(', ')}"
      return false
    end

    true
  end
end

# Dynamic Comment Generator (embedded)
class CommentGenerator
  attr_reader :blocks

  def initialize(blocks)
    @blocks = blocks
  end

  def generate_single_comment
    first_name = blocks[:author].sample
    last_name = blocks[:author].sample
    location = blocks[:location].sample
    comment_type = random_comment_type

    text = build_comment_text(comment_type)

    # Full name without prefix (more natural for blog comments)
    full_author = "#{first_name} #{last_name}"

    {
      author: full_author,
      location: location,
      type: comment_type,
      text: text
    }
  end

  private

  def random_comment_type
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
      sentences << blocks[:appreciation_intro].sample
      sentences << blocks[:appreciation_detail].sample if rand < 0.8
      sentences << blocks[:appreciation_outro].sample

    when 'question'
      sentences << blocks[:question_intro].sample
      sentences << blocks[:question_topic].sample
      sentences << blocks[:question_outro].sample

    when 'help_request'
      sentences << blocks[:help_intro].sample
      sentences << blocks[:help_context].sample
      sentences << blocks[:help_outro].sample

    when 'insight'
      sentences << blocks[:insight_intro].sample
      sentences << blocks[:insight_detail].sample if rand < 0.9
      sentences << blocks[:insight_outro].sample

    when 'feedback'
      sentences << blocks[:feedback_intro].sample
      sentences << blocks[:feedback_topic].sample
      sentences << blocks[:feedback_outro].sample
    end

    sentences.join(', ')
  end
end

# Load comment system
def load_comment_system
  blocks = BuildingBlockLoader.load(BLOCKS_FILE)

  if blocks
    puts "✅ Loaded comment building block system"
    puts "   🚀 Dynamic comment generation enabled!"
    generator = CommentGenerator.new(blocks)
    return { type: :generator, source: generator }
  end

  puts "❌ Error: No comment generation system available"
  exit 1
end

# Initialize comment system
COMMENT_SYSTEM = load_comment_system

class PostUpdater
  attr_reader :post_file, :front_matter, :content

  def initialize(post_file)
    @post_file = post_file
    load_post
  end

  def load_post
    file_content = File.read(@post_file)

    # Parse front matter
    match = file_content.match(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m)

    if match
      @front_matter = YAML.safe_load(match[1], permitted_classes: [Date, Time])
      @content = match.post_match.strip
    else
      puts "Warning: No front matter found in #{@post_file}"
      @front_matter = {}
      @content = file_content
    end
  end

  def update!
    # Initialize counters if not exist
    @front_matter['like_count'] ||= rand(10..30)
    @front_matter['share_count'] ||= rand(5..15)
    @front_matter['total_updates'] ||= 0

    # Increment counters
    old_likes = @front_matter['like_count']
    old_shares = @front_matter['share_count']

    # Always increment like_count (1-3 randomly)
    @front_matter['like_count'] += rand(1..3)

    # Maybe increment share_count (50% chance)
    if rand < 0.5
      @front_matter['share_count'] += rand(1..2)
    end

    @front_matter['total_updates'] += 1

    # Update last_modified_at
    @front_matter['last_modified_at'] = Time.now.strftime('%Y-%m-%d %H:%M:%S %z')

    # Every 10 updates: add real comment
    if (@front_matter['total_updates'] % 10).zero?
      add_real_comment
    end

    # Save back
    save_post

    # Log
    log_update(old_likes, old_shares)
  end

  private

  def add_real_comment
    comment = COMMENT_SYSTEM[:source].generate_single_comment

    # Format comment
    comment_text = <<~COMMENT

      ---

      **Komentar - #{Time.now.strftime('%d %B %Y')}**

      💬 **#{comment[:author]}** (#{comment[:location]})

      > "#{comment[:text]}"

    COMMENT

    # Append to content
    @content += comment_text

    puts "  → Added generated comment from #{comment[:author]}"
  end

  def save_post
    # YAML.dump adds leading '---', so we don't need to add it manually
    yaml_string = YAML.dump(@front_matter)
    # Remove the leading '---' from YAML.dump to avoid double delimiter
    yaml_string = yaml_string.sub(/^---\n/, '')

    new_content = "---\n#{yaml_string}---\n\n#{@content}"
    File.write(@post_file, new_content)
  end

  def log_update(old_likes, old_shares)
    post_name = File.basename(@post_file, '.md')

    puts "\n✅ Updated: #{post_name}"
    puts "   Like count: #{old_likes} → #{@front_matter['like_count']}"
    puts "   Share count: #{old_shares} → #{@front_matter['share_count']}"
    puts "   Total updates: #{@front_matter['total_updates']}"
    puts "   Last modified: #{@front_matter['last_modified_at']}"
  end
end

# Main execution
def main
  # Get all post files
  post_files = Dir.glob(File.join(POSTS_DIR, '*.md')).sort

  if post_files.empty?
    puts "❌ No post files found in #{POSTS_DIR}"
    exit 1
  end

  puts "📝 Found #{post_files.length} posts"
  puts "=" * 60

  # Select random posts to update (30% probability each)
  posts_to_update = post_files.select { |_| rand < 0.3 }

  if posts_to_update.empty?
    puts "ℹ️  No posts selected for update this time (random probability)"
    puts "=" * 60
    exit 0
  end

  puts "🎯 Updating #{posts_to_update.length} post(s) this time"
  puts "=" * 60

  # Update each selected post
  posts_to_update.each do |post_file|
    updater = PostUpdater.new(post_file)
    updater.update!
  end

  puts "\n" + "=" * 60
  puts "✨ Post update completed successfully!"
  puts "=" * 60
end

# Run if executed directly
main if __FILE__ == $PROGRAM_NAME

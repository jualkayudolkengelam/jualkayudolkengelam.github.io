#!/bin/bash
# Jekyll Build Script untuk Jual Kayu Dolken Gelam Website
# Author: Claude Code
# Updated: 2025-11-15

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Set working directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Set PATH untuk Ruby gems
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Function to check if bundle is available
check_dependencies() {
    if ! command -v bundle &> /dev/null; then
        print_error "Bundle not found! Please install bundler first."
        echo "  Run: gem install bundler --user-install"
        exit 1
    fi
}

# Function to install dependencies
install_deps() {
    print_info "Installing dependencies..."
    if bundle install; then
        print_success "Dependencies installed successfully!"
    else
        print_error "Failed to install dependencies!"
        exit 1
    fi
}

# Function to clean build directories
clean_build() {
    print_info "Cleaning build directories..."
    rm -rf _site _site_local .jekyll-cache .jekyll-metadata
    print_success "Clean completed"
}

# Function to build Jekyll site
build_site() {
    local config_file="${1:-_config.yml}"

    print_info "Building Jekyll site..."
    print_info "Config: $config_file"

    if bundle exec jekyll build --config "$config_file" --future; then
        print_success "Build completed successfully!"

        # Show build info
        if [ -d "_site" ]; then
            local file_count=$(find _site -type f | wc -l)
            local size=$(du -sh _site | cut -f1)
            print_info "Generated $file_count files ($size)"
        fi
    else
        print_error "Build failed!"
        exit 1
    fi
}

# Function to serve Jekyll site locally
serve_site() {
    local config_file="${1:-_config.yml}"
    local port="${2:-4000}"

    print_info "Starting Jekyll development server..."
    print_info "Config: $config_file"
    print_info "Server will be available at: http://localhost:$port"
    print_warning "Press Ctrl+C to stop the server"
    echo ""

    bundle exec jekyll serve --config "$config_file" --port "$port" --livereload --future
}

# Function to show usage
show_usage() {
    cat << EOF
Usage: ./rebuild.sh [COMMAND] [OPTIONS]

Commands:
  install       Install dependencies (first time setup)
  build         Build the Jekyll site (default)
  serve         Start development server with live reload
  clean         Clean build directories
  clean-build   Clean and then build
  help          Show this help message

Options:
  --local       Use local config (_config.yml,_config_local.yml)
  --port PORT   Port for serve command (default: 4000)

Examples:
  ./rebuild.sh install            # First time setup - install dependencies
  ./rebuild.sh                    # Build with default config
  ./rebuild.sh build --local      # Build with local config
  ./rebuild.sh serve              # Start dev server
  ./rebuild.sh serve --port 3000  # Start dev server on port 3000
  ./rebuild.sh clean-build        # Clean and build
  ./rebuild.sh help               # Show this help

EOF
}

# Main script logic
main() {
    local command="${1:-build}"
    local config="_config.yml"
    local port="4000"

    # Parse arguments
    shift || true
    while [[ $# -gt 0 ]]; do
        case $1 in
            --local)
                config="_config.yml,_config_local.yml"
                shift
                ;;
            --port)
                port="$2"
                shift 2
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done

    # Print header
    echo ""
    echo "═══════════════════════════════════════════════"
    echo "  Jekyll Build - Jual Kayu Dolken Gelam"
    echo "═══════════════════════════════════════════════"
    echo ""

    # Check dependencies for most commands
    if [[ "$command" != "help" && "$command" != "--help" && "$command" != "-h" ]]; then
        check_dependencies
    fi

    # Execute command
    case $command in
        install)
            install_deps
            ;;
        build)
            build_site "$config"
            ;;
        serve|server)
            serve_site "$config" "$port"
            ;;
        clean)
            clean_build
            ;;
        clean-build|rebuild)
            clean_build
            echo ""
            build_site "$config"
            ;;
        help|--help|-h)
            show_usage
            ;;
        *)
            print_error "Unknown command: $command"
            echo ""
            show_usage
            exit 1
            ;;
    esac

    echo ""
}

# Run main function
main "$@"

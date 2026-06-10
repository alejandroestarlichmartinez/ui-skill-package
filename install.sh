#!/bin/bash
# UI Skills Installer - Curated Frontend Quality Toolkit
# Installs selected UI skills into your project or global config

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# Base directory
UI_SKILLS_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$UI_SKILLS_DIR/skills"

# Default skills to install (core set)
DEFAULT_SKILLS="baseline-ui frontend-design next-best-practices react-best-practices"

# All available skills
ALL_SKILLS=(
  "ibelick-baseline-ui"
  "anthropics-frontend-design"
  "nextlevelbuilder-ui-ux-pro-max"
  "vercel-labs-next-best-practices"
  "vercel-labs-react-best-practices"
  "shadcn-ui-shadcn"
  "jakubkrehel-make-interfaces-feel-better"
  "wshobson-interaction-design"
  "zeke-swiss-design"
  "raphaelsalaja-12-principles-of-animation"
  "ibelick-fixing-accessibility"
)

# Print helpers
print_header() {
  echo -e "${BOLD}$1${RESET}"
}

print_success() {
  echo -e "${GREEN}✓${RESET} $1"
}

print_info() {
  echo -e "${YELLOW}→${RESET} $1"
}

print_error() {
  echo -e "${RED}✗${RESET} $1"
}

# Help message
show_help() {
  cat << EOF
UI Skills Installer - Frontend Quality Toolkit

Usage: install.sh [OPTIONS] [SKILL1 SKILL2 ...]

Options:
  --all              Install all available skills
  --default          Install default core skills (baseline-ui, frontend-design, next-best-practices, react-best-practices)
  --framework-set    Install framework-specific skills (Next.js, React, shadcn)
  --design-set       Install design quality skills (baseline-ui, frontend-design, make-interfaces-feel-better)
  --animation-set    Install animation skills (12-principles-of-animation, interaction-design)
  --accessibility    Install accessibility skills (fixing-accessibility)
  --list             List all available skills
  --file FILE        Install skills listed in FILE (one per line)
  --global           Install to global OpenCode config (~/.config/opencode/)
  --help             Show this help message

Examples:
  ./install.sh --default                          # Install core skills
  ./install.sh baseline-ui next-best-practices    # Install specific skills
  ./install.sh --all                              # Install everything
  ./install.sh --framework-set                    # Install Next.js + React + shadcn
  ./install.sh --design-set                       # Install design quality skills
  ./install.sh --file .ui-skills                  # Install from file
  ./install.sh --default --global                 # Install globally

Available Skills:
EOF
  
  for skill in "${ALL_SKILLS[@]}"; do
    # Extract readable name
    readable=$(echo "$skill" | sed 's/-/ /g' | sed 's/\b\w/\u&/g')
    echo "  • $readable"
  done
}

# List available skills
list_skills() {
  print_header "Available Skills:"
  echo ""
  
  echo -e "${BOLD}Core Quality:${RESET}"
  echo "  baseline-ui              - Anti-slop Tailwind constraints"
  echo "  frontend-design          - Anti-generic design guidance"
  echo "  ui-ux-pro-max            - Comprehensive UI/UX intelligence"
  echo ""
  
  echo -e "${BOLD}Frameworks:${RESET}"
  echo "  next-best-practices      - Next.js App Router patterns"
  echo "  react-best-practices     - React architecture patterns"
  echo "  shadcn                   - shadcn/ui component workflow"
  echo ""
  
  echo -e "${BOLD}Design Quality:${RESET}"
  echo "  make-interfaces-feel-better - Polish and micro-interactions"
  echo "  interaction-design       - Microinteractions and motion"
  echo "  swiss-design             - Grid discipline and typography"
  echo ""
  
  echo -e "${BOLD}Animation:${RESET}"
  echo "  12-principles-of-animation - Disney principles for web"
  echo ""
  
  echo -e "${BOLD}Accessibility:${RESET}"
  echo "  fixing-accessibility     - WCAG audit and remediation"
  echo ""
}

# Map skill names to files
get_skill_file() {
  local skill="$1"
  
  # Handle direct file names
  if [ -f "$SKILLS_DIR/${skill}.md" ]; then
    echo "$SKILLS_DIR/${skill}.md"
    return 0
  fi
  
  # Handle short names
  case "$skill" in
    "baseline-ui")
      echo "$SKILLS_DIR/ibelick-baseline-ui.md"
      ;;
    "frontend-design")
      echo "$SKILLS_DIR/anthropics-frontend-design.md"
      ;;
    "ui-ux-pro-max")
      echo "$SKILLS_DIR/nextlevelbuilder-ui-ux-pro-max.md"
      ;;
    "next-best-practices")
      echo "$SKILLS_DIR/vercel-labs-next-best-practices.md"
      ;;
    "react-best-practices")
      echo "$SKILLS_DIR/vercel-labs-react-best-practices.md"
      ;;
    "shadcn")
      echo "$SKILLS_DIR/shadcn-ui-shadcn.md"
      ;;
    "make-interfaces-feel-better"|"make-interfaces")
      echo "$SKILLS_DIR/jakubkrehel-make-interfaces-feel-better.md"
      ;;
    "interaction-design")
      echo "$SKILLS_DIR/wshobson-interaction-design.md"
      ;;
    "swiss-design")
      echo "$SKILLS_DIR/zeke-swiss-design.md"
      ;;
    "12-principles-of-animation"|"animation"|"12-principles")
      echo "$SKILLS_DIR/raphaelsalaja-12-principles-of-animation.md"
      ;;
    "fixing-accessibility"|"accessibility")
      echo "$SKILLS_DIR/ibelick-fixing-accessibility.md"
      ;;
    *)
      echo ""
      return 1
      ;;
  esac
}

# Get readable name
get_readable_name() {
  local skill="$1"
  case "$skill" in
    "baseline-ui") echo "Baseline UI" ;;
    "frontend-design") echo "Frontend Design" ;;
    "ui-ux-pro-max") echo "UI/UX Pro Max" ;;
    "next-best-practices") echo "Next.js Best Practices" ;;
    "react-best-practices") echo "React Best Practices" ;;
    "shadcn") echo "shadcn/ui" ;;
    "make-interfaces-feel-better"|"make-interfaces") echo "Make Interfaces Feel Better" ;;
    "interaction-design") echo "Interaction Design" ;;
    "swiss-design") echo "Swiss Design" ;;
    "12-principles-of-animation"|"animation"|"12-principles") echo "12 Principles of Animation" ;;
    "fixing-accessibility"|"accessibility") echo "Fixing Accessibility" ;;
    *) echo "$skill" ;;
  esac
}

# Install a skill
install_skill() {
  local skill="$1"
  local target_dir="$2"
  local skill_file
  local readable_name
  
  skill_file=$(get_skill_file "$skill")
  readable_name=$(get_readable_name "$skill")
  
  if [ -z "$skill_file" ] || [ ! -f "$skill_file" ]; then
    print_error "Skill not found: $skill"
    return 1
  fi
  
  # Create skill directory
  local skill_dir="$target_dir/$skill"
  mkdir -p "$skill_dir"
  
  # Copy skill file
  cp "$skill_file" "$skill_dir/SKILL.md"
  
  print_success "$readable_name installed"
  return 0
}

# Detect project directories
detect_project_dirs() {
  local dirs=()
  
  if [ -d "$PWD/.opencode" ]; then
    dirs+=("$PWD/.opencode/skill")
  fi
  
  if [ -d "$PWD/.claude" ]; then
    dirs+=("$PWD/.claude/skills")
  fi
  
  if [ -d "$PWD/.cursor" ]; then
    dirs+=("$PWD/.cursor/skills")
  fi
  
  if [ -d "$PWD/.codex" ]; then
    dirs+=("$PWD/.codex/skills")
  fi
  
  echo "${dirs[@]}"
}

# Main installation logic
main() {
  local skills_to_install=()
  local install_global=false
  local target_dirs=()
  
  # Parse arguments
  while [ $# -gt 0 ]; do
    case "$1" in
      --all)
        skills_to_install+=("baseline-ui" "frontend-design" "ui-ux-pro-max" "next-best-practices" "react-best-practices" "shadcn" "make-interfaces-feel-better" "interaction-design" "swiss-design" "12-principles-of-animation" "fixing-accessibility")
        shift
        ;;
      --default)
        skills_to_install+=("baseline-ui" "frontend-design" "next-best-practices" "react-best-practices")
        shift
        ;;
      --framework-set)
        skills_to_install+=("next-best-practices" "react-best-practices" "shadcn")
        shift
        ;;
      --design-set)
        skills_to_install+=("baseline-ui" "frontend-design" "make-interfaces-feel-better")
        shift
        ;;
      --animation-set)
        skills_to_install+=("12-principles-of-animation" "interaction-design")
        shift
        ;;
      --accessibility)
        skills_to_install+=("fixing-accessibility")
        shift
        ;;
      --list)
        list_skills
        exit 0
        ;;
      --file)
        if [ -f "$2" ]; then
          while IFS= read -r line; do
            # Skip comments and empty lines
            [[ "$line" =~ ^# ]] && continue
            [[ -z "$line" ]] && continue
            skills_to_install+=("$line")
          done < "$2"
        else
          print_error "File not found: $2"
          exit 1
        fi
        shift 2
        ;;
      --global)
        install_global=true
        shift
        ;;
      --help|-h)
        show_help
        exit 0
        ;;
      -*)
        print_error "Unknown option: $1"
        echo "Use --help for usage information"
        exit 1
        ;;
      *)
        skills_to_install+=("$1")
        shift
        ;;
    esac
  done
  
  # Default to default set if no skills specified
  if [ ${#skills_to_install[@]} -eq 0 ]; then
    skills_to_install=("baseline-ui" "frontend-design" "next-best-practices" "react-best-practices")
  fi
  
  # Determine target directories
  if [ "$install_global" = true ]; then
    if [ -d "$HOME/.config/opencode" ]; then
      target_dirs+=("$HOME/.config/opencode/skill")
    fi
    if [ -d "$HOME/.claude" ]; then
      target_dirs+=("$HOME/.claude/skills")
    fi
    if [ -d "$HOME/.cursor" ]; then
      target_dirs+=("$HOME/.cursor/skills")
    fi
  else
    # Detect project directories
    read -ra detected <<< "$(detect_project_dirs)"
    target_dirs+=("${detected[@]}")
    
    # If no project directories found, use global
    if [ ${#target_dirs[@]} -eq 0 ]; then
      print_info "No project directories detected. Installing globally..."
      if [ -d "$HOME/.config/opencode" ]; then
        target_dirs+=("$HOME/.config/opencode/skill")
      fi
    fi
  fi
  
  # Check if we have any target directories
  if [ ${#target_dirs[@]} -eq 0 ]; then
    print_error "No target directories found."
    echo "Please run from a project directory or use --global flag."
    exit 1
  fi
  
  # Print header
  echo ""
  print_header "UI Skills Installer"
  echo ""
  print_info "Skills to install: ${#skills_to_install[@]}"
  for skill in "${skills_to_install[@]}"; do
    echo "  • $(get_readable_name "$skill")"
  done
  echo ""
  print_info "Target directories: ${#target_dirs[@]}"
  for dir in "${target_dirs[@]}"; do
    echo "  → $dir"
  done
  echo ""
  
  # Install skills
  local installed_count=0
  local failed_count=0
  
  for target_dir in "${target_dirs[@]}"; do
    echo -e "${BOLD}Installing to: $target_dir${RESET}"
    
    for skill in "${skills_to_install[@]}"; do
      if install_skill "$skill" "$target_dir"; then
        installed_count=$((installed_count + 1))
      else
        failed_count=$((failed_count + 1))
      fi
    done
    
    echo ""
  done
  
  # Summary
  print_header "Installation Complete"
  echo ""
  print_success "$installed_count skills installed"
  
  if [ $failed_count -gt 0 ]; then
    print_error "$failed_count skills failed"
  fi
  
  echo ""
  echo "Usage:"
  echo "  /baseline-ui              - Apply Tailwind constraints"
  echo "  /frontend-design          - Apply anti-generic design"
  echo "  /next-best-practices      - Apply Next.js patterns"
  echo "  /fixing-accessibility     - Audit accessibility"
  echo ""
}

# Run main
main "$@"

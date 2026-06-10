#!/bin/bash
# UI Skills Installer - Installs skills into CURRENT PROJECT
# Usage: cd your-project && /path/to/ui-skills/install.sh [options]
#
# Skills are installed to ./.ai/skills/ (per-project, not global)

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
RESET="\033[0m"

# Source directory (where this script lives)
UI_SKILLS_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_SKILLS_DIR="$UI_SKILLS_DIR/skills"

# Target directory (current project)
PROJECT_DIR="${PROJECT_DIR:-$PWD}"
TARGET_DIR="$PROJECT_DIR/.ai/skills"

# Default skills
DEFAULT_SKILLS="baseline-ui frontend-design"

# All available skills with their source files
declare -A SKILL_FILES=(
  ["baseline-ui"]="ibelick-baseline-ui.md"
  ["frontend-design"]="anthropics-frontend-design.md"
  ["ui-ux-pro-max"]="nextlevelbuilder-ui-ux-pro-max.md"
  ["next-best-practices"]="vercel-labs-next-best-practices.md"
  ["react-best-practices"]="vercel-labs-react-best-practices.md"
  ["shadcn"]="shadcn-ui-shadcn.md"
  ["make-interfaces-feel-better"]="jakubkrehel-make-interfaces-feel-better.md"
  ["interaction-design"]="wshobson-interaction-design.md"
  ["swiss-design"]="zeke-swiss-design.md"
  ["12-principles-of-animation"]="raphaelsalaja-12-principles-of-animation.md"
  ["fixing-accessibility"]="ibelick-fixing-accessibility.md"
)

# Print helpers
print_header() { echo -e "${BOLD}$1${RESET}"; }
print_success() { echo -e "${GREEN}✓${RESET} $1"; }
print_info() { echo -e "${YELLOW}→${RESET} $1"; }
print_error() { echo -e "${RED}✗${RESET} $1"; }
print_code() { echo -e "${BLUE}$1${RESET}"; }

# Help
show_help() {
  cat << EOF
UI Skills Installer - Per-Project Frontend Quality Toolkit

${BOLD}Usage:${RESET}
  cd tu-proyecto && ~/Documentos/ai/ui-skills/install.sh [OPTIONS] [SKILL1 SKILL2 ...]

${BOLD}Options:${RESET}
  --all              Install ALL available skills
  --default          Install default core skills (baseline-ui, frontend-design)
  --framework-set    Install framework skills (Next.js, React, shadcn)
  --design-set       Install design quality skills
  --animation-set    Install animation skills
  --accessibility    Install accessibility skill
  --detect           Auto-detect framework and install relevant skills
  --list             List all available skills
  --global           Install to global config (NOT RECOMMENDED)
  --help             Show this help

${BOLD}Examples:${RESET}
  ~/Documentos/ai/ui-skills/install.sh --default
  ~/Documentos/ai/ui-skills/install.sh baseline-ui next-best-practices
  ~/Documentos/ai/ui-skills/install.sh --detect
  ~/Documentos/ai/ui-skills/install.sh --all

${BOLD}Important:${RESET}
  • Skills are installed to ./.ai/skills/ in your project
  • This keeps skills versioned with your project
  • Agents read skills from .ai/skills/ automatically
  • Use --global only if you know what you're doing

EOF
  list_skills
}

list_skills() {
  echo -e "${BOLD}Available Skills:${RESET}"
  echo ""
  
  echo -e "  ${BOLD}Core Quality:${RESET}"
  echo "    baseline-ui              - Tailwind + motion constraints"
  echo "    frontend-design          - Anti-generic design guidance"
  echo ""
  
  echo -e "  ${BOLD}Frameworks:${RESET}"
  echo "    next-best-practices      - Next.js App Router patterns"
  echo "    react-best-practices     - React architecture patterns"
  echo "    shadcn                   - shadcn/ui workflow"
  echo ""
  
  echo -e "  ${BOLD}Design Enhancement:${RESET}"
  echo "    ui-ux-pro-max            - Comprehensive UI/UX intelligence"
  echo "    make-interfaces-feel-better - Polish & micro-interactions"
  echo "    interaction-design       - Microinteractions & motion"
  echo "    swiss-design             - Grid discipline & typography"
  echo ""
  
  echo -e "  ${BOLD}Animation:${RESET}"
  echo "    12-principles-of-animation - Disney principles for web"
  echo ""
  
  echo -e "  ${BOLD}Accessibility:${RESET}"
  echo "    fixing-accessibility     - WCAG audit & remediation"
  echo ""
}

# Auto-detect project framework
detect_framework() {
  local framework="generic"
  local has_tailwind=false
  local has_nextjs=false
  local has_react=false
  
  if [ -f "$PROJECT_DIR/package.json" ]; then
    if grep -q '"next"' "$PROJECT_DIR/package.json" 2>/dev/null; then
      has_nextjs=true
      framework="nextjs"
    fi
    if grep -q '"react"' "$PROJECT_DIR/package.json" 2>/dev/null; then
      has_react=true
      if [ "$framework" = "generic" ]; then
        framework="react"
      fi
    fi
    if grep -q '"tailwindcss"' "$PROJECT_DIR/package.json" 2>/dev/null; then
      has_tailwind=true
    fi
  fi
  
  # Check for config files
  if [ -f "$PROJECT_DIR/next.config.js" ] || [ -f "$PROJECT_DIR/next.config.ts" ] || [ -f "$PROJECT_DIR/next.config.mjs" ]; then
    has_nextjs=true
    framework="nextjs"
  fi
  
  if [ -f "$PROJECT_DIR/tailwind.config.js" ] || [ -f "$PROJECT_DIR/tailwind.config.ts" ]; then
    has_tailwind=true
  fi
  
  echo "$framework $has_tailwind"
}

# Get recommended skills based on framework
get_recommended_skills() {
  local framework="$1"
  local has_tailwind="$2"
  local skills=()
  
  # Always install core
  skills+=("baseline-ui")
  skills+=("frontend-design")
  
  # Framework-specific
  case "$framework" in
    "nextjs")
      skills+=("next-best-practices")
      skills+=("react-best-practices")
      skills+=("shadcn")
      ;;
    "react")
      skills+=("react-best-practices")
      skills+=("shadcn")
      ;;
  esac
  
  # Quality skills
  skills+=("make-interfaces-feel-better")
  skills+=("fixing-accessibility")
  
  # If project has animations or is heavily interactive
  if [ "$has_tailwind" = true ]; then
    skills+=("interaction-design")
  fi
  
  echo "${skills[@]}"
}

# Install a single skill
install_skill() {
  local skill_name="$1"
  local source_file="${SKILL_FILES[$skill_name]}"
  
  if [ -z "$source_file" ]; then
    print_error "Unknown skill: $skill_name"
    return 1
  fi
  
  local source_path="$SOURCE_SKILLS_DIR/$source_file"
  if [ ! -f "$source_path" ]; then
    print_error "Source file not found: $source_file"
    return 1
  fi
  
  # Create skill directory in project
  local skill_dir="$TARGET_DIR/$skill_name"
  mkdir -p "$skill_dir"
  
  # Copy as SKILL.md (standard format for agents)
  cp "$source_path" "$skill_dir/SKILL.md"
  
  print_success "Installed: $skill_name"
  return 0
}

# Create or update .ai/config.toml
create_project_config() {
  local config_dir="$PROJECT_DIR/.ai"
  local config_file="$config_dir/config.toml"
  
  mkdir -p "$config_dir"
  
  if [ ! -f "$config_file" ]; then
    cat > "$config_file" << EOF
# UI Skills Configuration
# This file tells agents which skills are available in this project

[skills]
source = "./skills"
auto_load = ["baseline-ui", "frontend-design"]

[skills.framework]
# Set your framework for better skill suggestions
# Options: nextjs, react, vue, svelte, generic
name = "auto-detected"

[skills.quality]
# Quality gates to run before completing UI work
gates = ["baseline-ui", "fixing-accessibility"]
EOF
    print_success "Created .ai/config.toml"
  fi
}

# Update or create AGENTS.md section
update_agents_md() {
  local agents_file=""
  
  # Find the right file
  if [ -f "$PROJECT_DIR/AGENTS.md" ]; then
    agents_file="$PROJECT_DIR/AGENTS.md"
  elif [ -f "$PROJECT_DIR/CLAUDE.md" ]; then
    agents_file="$PROJECT_DIR/CLAUDE.md"
  elif [ -f "$PROJECT_DIR/.cursor/rules" ]; then
    agents_file="$PROJECT_DIR/.cursor/rules"
  fi
  
  if [ -z "$agents_file" ]; then
    agents_file="$PROJECT_DIR/AGENTS.md"
    touch "$agents_file"
  fi
  
  # Check if section already exists
  if grep -q "UI Skills" "$agents_file" 2>/dev/null; then
    print_info "UI Skills section already exists in $(basename "$agents_file")"
    return 0
  fi
  
  # Append section
  cat >> "$agents_file" << 'EOF'

## UI Skills

This project uses UI Skills for quality constraints. Skills are installed in `.ai/skills/`.

### Available Commands

| Command | Purpose |
|---------|---------|
| `/baseline-ui [file]` | Apply Tailwind + motion constraints |
| `/frontend-design` | Anti-generic design guidance |
| `/next-best-practices` | Next.js App Router patterns |
| `/react-best-practices` | React component architecture |
| `/shadcn` | shadcn/ui component workflow |
| `/fixing-accessibility` | WCAG audit & remediation |
| `/make-interfaces-feel-better` | Polish & micro-interactions |
| `/12-principles-of-animation` | Animation principles |
| `/interaction-design` | Microinteractions |
| `/swiss-design` | Grid & typography discipline |
| `/ui-ux-pro-max` | Comprehensive UI/UX standards |

### Quality Gates

Before completing UI work:
1. Run `/baseline-ui` on modified files
2. Run `/fixing-accessibility` if applicable
3. Run `/frontend-design` to verify distinctiveness

### Installation

```bash
# Install default skills
~/Documentos/ai/ui-skills/install.sh --default

# Auto-detect framework and install relevant skills
~/Documentos/ai/ui-skills/install.sh --detect

# Install specific skill
~/Documentos/ai/ui-skills/install.sh next-best-practices
```

### Skill Loading

Agents automatically load skills from `.ai/skills/`. Each skill is a directory with a `SKILL.md` file.
EOF

  print_success "Updated $(basename "$agents_file") with UI Skills section"
}

# Update .gitignore
update_gitignore() {
  local gitignore="$PROJECT_DIR/.gitignore"
  
  if [ -f "$gitignore" ]; then
    if ! grep -q ".ai/skills" "$gitignore" 2>/dev/null; then
      echo "" >> "$gitignore"
      echo "# UI Skills - installed per project" >> "$gitignore"
      echo ".ai/skills/" >> "$gitignore"
      print_info "Added .ai/skills/ to .gitignore"
    fi
  fi
}

# Main
main() {
  local skills_to_install=()
  local install_global=false
  local detect_framework=false
  
  echo ""
  print_header "UI Skills Installer"
  echo ""
  
  # Parse args
  while [ $# -gt 0 ]; do
    case "$1" in
      --all)
        skills_to_install+=("baseline-ui" "frontend-design" "ui-ux-pro-max" "next-best-practices" "react-best-practices" "shadcn" "make-interfaces-feel-better" "interaction-design" "swiss-design" "12-principles-of-animation" "fixing-accessibility")
        shift
        ;;
      --default)
        skills_to_install+=("baseline-ui" "frontend-design")
        shift
        ;;
      --framework-set)
        skills_to_install+=("next-best-practices" "react-best-practices" "shadcn")
        shift
        ;;
      --design-set)
        skills_to_install+=("baseline-ui" "frontend-design" "make-interfaces-feel-better" "ui-ux-pro-max")
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
      --detect)
        detect_framework=true
        shift
        ;;
      --list)
        list_skills
        exit 0
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
  
  # Handle global install
  if [ "$install_global" = true ]; then
    TARGET_DIR="$HOME/.config/opencode/skills"
    print_info "Installing globally to: $TARGET_DIR"
    print_info "${YELLOW}WARNING:${RESET} Global install is NOT recommended. Use per-project install instead."
    echo ""
  else
    # Per-project install
    print_info "Project directory: $PROJECT_DIR"
    print_info "Installing to: $TARGET_DIR"
    echo ""
    
    # Check if we're in a project
    if [ ! -f "$PROJECT_DIR/package.json" ] && [ ! -d "$PROJECT_DIR/src" ] && [ ! -d "$PROJECT_DIR/.git" ]; then
      echo -e "${YELLOW}⚠ Warning: This doesn't look like a project directory.${RESET}"
      echo ""
      echo "UI Skills should be installed per-project. Are you sure you want to continue?"
      echo ""
      echo "If you want to install globally, use: --global"
      echo ""
      read -p "Continue anyway? [y/N] " -n 1 -r
      echo ""
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
      fi
    fi
  fi
  
  # Auto-detect framework
  if [ "$detect_framework" = true ]; then
    read -r framework has_tailwind <<< "$(detect_framework)"
    echo -e "${BOLD}Detected framework:${RESET} $framework"
    echo -e "${BOLD}Tailwind detected:${RESET} $has_tailwind"
    echo ""
    
    read -ra recommended <<< "$(get_recommended_skills "$framework" "$has_tailwind")"
    echo -e "${BOLD}Recommended skills:${RESET}"
    for skill in "${recommended[@]}"; do
      echo "  • $skill"
    done
    echo ""
    
    read -p "Install recommended skills? [Y/n] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
      skills_to_install=("${recommended[@]}")
    fi
  fi
  
  # Default to default set if nothing specified
  if [ ${#skills_to_install[@]} -eq 0 ]; then
    skills_to_install=("baseline-ui" "frontend-design")
  fi
  
  # Show what we're installing
  print_info "Skills to install: ${#skills_to_install[@]}"
  for skill in "${skills_to_install[@]}"; do
    echo "  • $skill"
  done
  echo ""
  
  # Create target directory
  mkdir -p "$TARGET_DIR"
  
  # Install each skill
  local installed=0
  local failed=0
  
  for skill in "${skills_to_install[@]}"; do
    if install_skill "$skill"; then
      installed=$((installed + 1))
    else
      failed=$((failed + 1))
    fi
  done
  
  echo ""
  
  # Create project config (only for per-project installs)
  if [ "$install_global" = false ]; then
    create_project_config
    update_agents_md
    update_gitignore
  fi
  
  # Summary
  print_header "Installation Complete"
  echo ""
  print_success "$installed skills installed to $(print_code "$TARGET_DIR")"
  
  if [ $failed -gt 0 ]; then
    print_error "$failed skills failed"
  fi
  
  if [ "$install_global" = false ]; then
    echo ""
    echo -e "${BOLD}Next steps:${RESET}"
    echo "  1. Agents will auto-detect skills in .ai/skills/"
    echo "  2. Use commands like /baseline-ui in your prompts"
    echo "  3. Check $(print_code ".ai/config.toml") for configuration"
    echo "  4. See $(print_code "AGENTS.md") for usage guide"
    echo ""
    echo -e "${BOLD}Example usage:${RESET}"
    echo "  /baseline-ui src/components/Button.tsx"
    echo "  /fixing-accessibility"
    echo "  /next-best-practices"
  fi
  
  echo ""
}

main "$@"

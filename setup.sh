#!/bin/bash
# UI Skills Setup Script
# Configures a project to use UI Skills with agent access

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

UI_SKILLS_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$PWD"

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

# Check if we're in a project directory
check_project() {
  if [ ! -d "$PROJECT_DIR/.git" ] && [ ! -f "$PROJECT_DIR/package.json" ] && [ ! -d "$PROJECT_DIR/src" ]; then
    echo "Warning: This doesn't look like a project directory."
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      exit 1
    fi
  fi
}

# Detect framework
detect_framework() {
  local framework="generic"
  
  if [ -f "$PROJECT_DIR/next.config.js" ] || [ -f "$PROJECT_DIR/next.config.ts" ]; then
    framework="nextjs"
  elif [ -f "$PROJECT_DIR/package.json" ]; then
    if grep -q "react" "$PROJECT_DIR/package.json"; then
      framework="react"
    fi
  fi
  
  echo "$framework"
}

# Detect if using Tailwind
detect_tailwind() {
  if [ -f "$PROJECT_DIR/tailwind.config.js" ] || [ -f "$PROJECT_DIR/tailwind.config.ts" ]; then
    echo "true"
  else
    echo "false"
  fi
}

# Recommend skills based on project
recommend_skills() {
  local framework="$1"
  local uses_tailwind="$2"
  local recommendations=()
  
  echo ""
  print_header "Project Detection"
  echo "  Framework: $framework"
  echo "  Tailwind: $uses_tailwind"
  echo ""
  
  # Core skills (always recommended)
  recommendations+=("baseline-ui")
  recommendations+=("frontend-design")
  
  # Framework-specific
  case "$framework" in
    "nextjs")
      recommendations+=("next-best-practices")
      recommendations+=("react-best-practices")
      ;;
    "react")
      recommendations+=("react-best-practices")
      ;;
  esac
  
  # Additional quality skills
  recommendations+=("make-interfaces-feel-better")
  recommendations+=("fixing-accessibility")
  
  echo -e "${BOLD}Recommended skills for this project:${RESET}"
  for skill in "${recommendations[@]}"; do
    echo "  • $skill"
  done
  echo ""
  
  read -p "Install recommended skills? (Y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo ""
    echo "You can install skills manually with:"
    echo "  $UI_SKILLS_DIR/install.sh <skill-name>"
    exit 0
  fi
  
  echo "${recommendations[@]}"
}

# Setup agent access
setup_agent_access() {
  local target_file=""
  
  # Detect which agent config file to use
  if [ -f "$PROJECT_DIR/AGENTS.md" ]; then
    target_file="$PROJECT_DIR/AGENTS.md"
  elif [ -f "$PROJECT_DIR/CLAUDE.md" ]; then
    target_file="$PROJECT_DIR/CLAUDE.md"
  elif [ -f "$PROJECT_DIR/.cursor/rules" ]; then
    target_file="$PROJECT_DIR/.cursor/rules"
  else
    target_file="$PROJECT_DIR/AGENTS.md"
  fi
  
  echo ""
  print_info "Setting up agent access in: $target_file"
  
  # Check if UI Skills section already exists
  if grep -q "UI Skills Integration" "$target_file" 2>/dev/null; then
    print_info "UI Skills section already exists in $target_file"
    return 0
  fi
  
  # Append UI Skills configuration
  cat <> "$target_file" << 'EOF'

## UI Skills Integration

UI Skills provide quality constraints for frontend development.

### Available Skills
- `/baseline-ui` - Tailwind + motion constraints
- `/frontend-design` - Anti-generic design guidance
- `/next-best-practices` - Next.js patterns
- `/react-best-practices` - React best practices
- `/shadcn` - shadcn/ui component workflow
- `/make-interfaces-feel-better` - Interface polish
- `/interaction-design` - Microinteractions
- `/swiss-design` - Grid discipline
- `/12-principles-of-animation` - Animation principles
- `/fixing-accessibility` - WCAG compliance

### Skill Selection Rules
- New UI feature → Load `baseline-ui` + framework skill
- Design review → Load `frontend-design` + `baseline-ui`
- Animation work → Load `12-principles-of-animation`
- Accessibility audit → Load `fixing-accessibility`

### Installation
```bash
~/Documentos/ai/ui-skills/install.sh --default
```

### Quality Gates
Before completing UI work:
1. Run `/baseline-ui <file>` to check constraints
2. Verify accessibility with `/fixing-accessibility`
EOF
  
  print_success "Agent access configured in $target_file"
}

# Create .ui-skills file
create_config_file() {
  local skills="$1"
  
  if [ -f "$PROJECT_DIR/.ui-skills" ]; then
    print_info ".ui-skills already exists"
    return 0
  fi
  
  cat > "$PROJECT_DIR/.ui-skills" << EOF
# UI Skills Configuration
# List skills to install (one per line)
$skills
EOF
  
  print_success "Created .ui-skills configuration file"
}

# Main setup
main() {
  echo ""
  print_header "UI Skills Project Setup"
  echo ""
  print_info "Project: $PROJECT_DIR"
  echo ""
  
  # Check project
  check_project
  
  # Detect framework
  framework=$(detect_framework)
  uses_tailwind=$(detect_tailwind)
  
  # Recommend and get skills
  skills=$(recommend_skills "$framework" "$uses_tailwind")
  
  # Install skills
  echo ""
  print_info "Installing skills..."
  $UI_SKILLS_DIR/install.sh $skills
  
  # Setup agent access
  setup_agent_access
  
  # Create config file
  create_config_file "$skills"
  
  # Summary
  echo ""
  print_header "Setup Complete"
  echo ""
  print_success "UI Skills configured for this project"
  echo ""
  echo "Next steps:"
  echo "  1. Use /baseline-ui during UI work"
  echo "  2. Use /fixing-accessibility for a11y audits"
  echo "  3. Use /frontend-design to avoid generic UI"
  echo ""
  echo "Documentation:"
  echo "  $UI_SKILLS_DIR/README.md"
  echo ""
}

# Run
main "$@"

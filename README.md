# UI Skills - Frontend Quality Toolkit

A curated collection of high-quality UI/UX skills for design engineers and frontend teams. These skills enforce constraints, prevent AI-generated interface slop, and ensure production-ready frontend code.

## 🎯 What This Is

This is a **curated subset** of [ui-skills.com](https://ui-skills.com/) - selecting only the best 12 skills out of 109 available. We've organized them by category and usage so you only install what you need per project.

## 📦 Included Skills (12 Curated)

### Core Quality (Must-Have)
| Skill | Author | Purpose | When to Use |
|-------|--------|---------|-------------|
| `baseline-ui` | ibelick | Anti-slop constraints for Tailwind + motion | Any UI work with Tailwind |
| `frontend-design` | anthropics | Distinctive, non-generic design | When design feels "AI-generic" |
| `ui-ux-pro-max` | nextlevelbuilder | Comprehensive UI/UX intelligence | Complex interfaces, multiple styles |

### Framework-Specific
| Skill | Author | Purpose | When to Use |
|-------|--------|---------|-------------|
| `next-best-practices` | vercel-labs | Next.js patterns (RSC, App Router) | Next.js projects |
| `react-best-practices` | vercel-labs | React patterns & architecture | React projects |
| `shadcn` | shadcn-ui | shadcn/ui component workflow | Using shadcn components |

### Design Quality
| Skill | Author | Purpose | When to Use |
|-------|--------|---------|-------------|
| `make-interfaces-feel-better` | jakubkrehel | Polish, micro-interactions | Interfaces feel unfinished |
| `interaction-design` | wshobson | Microinteractions & motion | Need delightful UX |
| `swiss-design` | zeke | Grid discipline, typography | Editorial/clean interfaces |

### Animation & Motion
| Skill | Author | Purpose | When to Use |
|-------|--------|---------|-------------|
| `12-principles-of-animation` | raphaelsalaja | Disney principles for web | Adding meaningful motion |

### Accessibility
| Skill | Author | Purpose | When to Use |
|-------|--------|---------|-------------|
| `fixing-accessibility` | ibelick | WCAG audit & fixes | Accessibility review |

## 🚀 Installation (Per-Project)

**UI Skills are installed per-project**, not globally. This ensures each project only has the skills it needs, and they're versioned with the project.

### Quick Start

```bash
# 1. Navigate to your project
cd /path/to/your/project

# 2. Install default skills (baseline-ui + frontend-design)
~/Documentos/ai/ui-skills/install.sh --default

# 3. Done! Skills are now in ./.ai/skills/
```

### Installation Methods

#### Method 1: Auto-Detect (Recommended)

Automatically detects your framework and installs relevant skills:

```bash
cd /path/to/your/project
~/Documentos/ai/ui-skills/install.sh --detect
```

This will:
- Detect if you use Next.js, React, or generic
- Check for Tailwind CSS
- Recommend and install appropriate skills
- Create `.ai/config.toml` with configuration
- Update `AGENTS.md` with usage guide

#### Method 2: Install Sets

```bash
# Core quality skills
~/Documentos/ai/ui-skills/install.sh --default

# Framework-specific (Next.js + React + shadcn)
~/Documentos/ai/ui-skills/install.sh --framework-set

# Design quality
~/Documentos/ai/ui-skills/install.sh --design-set

# Animation
~/Documentos/ai/ui-skills/install.sh --animation-set

# Accessibility
~/Documentos/ai/ui-skills/install.sh --accessibility

# Everything
~/Documentos/ai/ui-skills/install.sh --all
```

#### Method 3: Install Specific Skills

```bash
# Install only what you need
~/Documentos/ai/ui-skills/install.sh baseline-ui next-best-practices react-best-practices

# Or mix and match
~/Documentos/ai/ui-skills/install.sh baseline-ui fixing-accessibility
```

#### Method 4: Manual (Not Recommended)

```bash
# Create directory
mkdir -p .ai/skills/baseline-ui

# Copy skill
cp ~/Documentos/ai/ui-skills/skills/ibelick-baseline-ui.md .ai/skills/baseline-ui/SKILL.md
```

## 🎨 Usage

### In OpenCode/Claude Code

Once installed, invoke skills during your conversation:

```
# Apply baseline constraints to current work
/baseline-ui

# Review a specific file
/baseline-ui src/components/Button.tsx

# Apply Next.js patterns
/next-best-practices

# Audit accessibility
/fixing-accessibility

# Add animation quality
/12-principles-of-animation
```

### When to Use Each Skill

**Starting a new UI feature:**
1. `/frontend-design` - Get design direction
2. `/baseline-ui` - Apply Tailwind constraints
3. `/next-best-practices` or `/react-best-practices` - Framework patterns

**Reviewing existing UI:**
1. `/baseline-ui src/components/` - Check for anti-patterns
2. `/fixing-accessibility` - WCAG audit
3. `/make-interfaces-feel-better` - Polish pass

**Adding animations:**
1. `/12-principles-of-animation` - Motion guidance
2. `/interaction-design` - Microinteractions

**Design system work:**
1. `/swiss-design` - Grid/typography discipline
2. `/ui-ux-pro-max` - Comprehensive patterns
3. `/shadcn` - Component workflow

## 📁 Structure

### Global Toolkit (this repo)

```
~/Documentos/ai/ui-skills/
├── README.md                          # This file
├── install.sh                         # Per-project installer
├── setup.sh                           # Auto-setup for projects
├── skills/                            # Curated skill sources
│   ├── ibelick-baseline-ui.md
│   ├── anthropics-frontend-design.md
│   ├── nextlevelbuilder-ui-ux-pro-max.md
│   ├── vercel-labs-next-best-practices.md
│   ├── vercel-labs-react-best-practices.md
│   ├── shadcn-ui-shadcn.md
│   ├── jakubkrehel-make-interfaces-feel-better.md
│   ├── wshobson-interaction-design.md
│   ├── zeke-swiss-design.md
│   ├── raphaelsalaja-12-principles-of-animation.md
│   └── ibelick-fixing-accessibility.md
└── .gitignore
```

### Per-Project (after install)

```
your-project/
├── .ai/                               # AI configuration
│   ├── skills/                        # Installed skills for THIS project
│   │   ├── baseline-ui/
│   │   │   └── SKILL.md
│   │   ├── next-best-practices/
│   │   │   └── SKILL.md
│   │   └── ...
│   └── config.toml                    # Skills configuration
├── AGENTS.md                          # Updated with UI Skills section
└── .gitignore                         # .ai/skills/ added
```

## 🔧 How It Works

### Architecture: Per-Project Skills (Independent)

UI Skills are **completely independent** from OpenCode's global skill registry. They live in `./.ai/skills/` inside each project and are discovered dynamically.

**Key differences from global skills:**
- **Not in skill registry** — UI Skills don't appear in `~/.config/opencode/.atl/skill-registry.md`
- **Dynamic discovery** — Agents scan `./.ai/skills/*/` for `SKILL.md` files at runtime
- **Project-only** — No global installation, no contamination of OpenCode config
- **Self-contained** — Each project manages its own skills independently

### Skill Discovery

When an agent starts working on a project, it scans for local skills:

```
1. Scan ./.ai/skills/*/
   └── Any directory with SKILL.md → Load as skill

2. No local skills found?
   └── Continue with global skills from registry

3. Context detection:
   ├── Next.js project → Load next-best-practices, baseline-ui
   ├── React project   → Load react-best-practices, baseline-ui
   └── Generic         → Load baseline-ui, frontend-design
```

### What install.sh Does

```bash
# 1. Creates local skill directories
mkdir -p .ai/skills/baseline-ui/
cp ~/Documentos/ai/ui-skills/skills/ibelick-baseline-ui.md .ai/skills/baseline-ui/SKILL.md

# 2. Creates config file
# .ai/config.toml (optional, for tooling)

# 3. Updates AGENTS.md
# Adds UI Skills section for agent reference

# 4. Updates .gitignore
# .ai/skills/ added (optional)
```

### Agent Integration

Agents discover UI Skills by **scanning**, not by registry lookup:

```bash
# Agent scans for local skills
for dir in ./.ai/skills/*/; do
  if [ -f "$dir/SKILL.md" ]; then
    skill_name=$(basename "$dir")
    # Skill available as: /$skill_name
  fi
done
```

This means:
- ✅ No registry edits needed
- ✅ No global configuration
- ✅ Skills work immediately after install
- ✅ Each project can have different skill versions
- ✅ No conflicts with OpenCode's core skills

## 🔄 Workflow Integration

### With SDD (Spec-Driven Development)

When using your SDD workflow:

1. **sdd-explore:** Identify if UI is needed
2. **sdd-spec:** Specify which UI skills to apply
3. **sdd-design:** Load relevant skills during design phase
4. **sdd-apply:** Apply skills during implementation
5. **sdd-verify:** Use skills for quality checks

Example spec:
```markdown
## UI Requirements
- Framework: Next.js with Tailwind CSS
- UI Skills to apply:
  - baseline-ui (Tailwind constraints)
  - next-best-practices (App Router patterns)
  - frontend-design (Anti-generic design)
- Accessibility: WCAG 2.2 AA
- Animation: 12-principles-of-animation
```

### With gstack

Combine with your existing gstack tools:

1. **Design:** Use `gstack-design-shotgun` to generate mockups
2. **Constraints:** Apply `frontend-design` + `baseline-ui` for quality
3. **HTML:** Use `gstack-design-html` for production code
4. **QA:** Use `gstack-browse` + `gstack-qa` to test
5. **Audit:** Run `fixing-accessibility` + `baseline-ui` review

## 📝 Skill Details

### baseline-ui (ibelick)
**Purpose:** Enforces opinionated UI baseline to prevent AI-generated interface slop.

**Key Rules:**
- MUST use Tailwind CSS defaults
- MUST use `motion/react` for animations
- MUST use `cn` utility (clsx + tailwind-merge)
- MUST use accessible component primitives (Base UI, React Aria, Radix)
- NEVER animate layout properties (width, height, top, left)
- NEVER exceed 200ms for interaction feedback
- MUST use `text-balance` for headings
- NEVER use gradients unless explicitly requested

**Usage:**
```bash
/baseline-ui                    # Apply to current work
/baseline-ui src/components/    # Review directory
```

### next-best-practices (vercel-labs)
**Purpose:** Next.js App Router patterns and conventions.

**Key Rules:**
- File conventions (page.tsx, layout.tsx, loading.tsx)
- RSC boundaries and data patterns
- Async APIs and metadata
- Error handling with error.tsx
- Image optimization

**Usage:**
```bash
/next-best-practices            # Apply patterns
```

### react-best-practices (vercel-labs)
**Purpose:** React component architecture and performance.

**Key Rules:**
- Component composition patterns
- Hook usage guidelines
- Performance optimization
- State management
- Rendering strategies

**Usage:**
```bash
/react-best-practices           # Apply patterns
```

### 12-principles-of-animation (raphaelsalaja)
**Purpose:** Disney's 12 animation principles for web interfaces.

**Key Principles:**
- Squash and stretch
- Anticipation
- Staging
- Straight ahead action and pose-to-pose
- Follow through and overlapping action
- Slow in and slow out
- Arcs
- Secondary action
- Timing
- Exaggeration
- Solid drawing
- Appeal

**Usage:**
```bash
/12-principles-of-animation     # Apply to animations
```

### fixing-accessibility (ibelick)
**Purpose:** WCAG audit and remediation.

**Key Rules:**
- ARIA labels for icon-only buttons
- Keyboard navigation
- Focus management
- Color contrast
- Form errors
- Screen reader support

**Usage:**
```bash
/fixing-accessibility           # Audit entire project
/fixing-accessibility src/      # Audit specific directory
```

## 🎓 Best Practices

### 1. Don't Overload
Install only the skills you need for the current project. Having all 12 active simultaneously can create conflicting constraints.

### 2. Layer Gradually
Start with `baseline-ui` + framework skill. Add design/animation skills only when needed.

### 3. Review Before Commit
Always run a skill review before completing UI work:
```bash
/baseline-ui src/components/Feature.tsx
```

### 4. Customize Per Project
Create a `.ui-skills` file in your project root to specify which skills to load:

```bash
# .ui-skills
baseline-ui
next-best-practices
frontend-design
```

Then install:
```bash
~/Documentos/ai/ui-skills/install.sh --file .ui-skills
```

## 🔍 Troubleshooting

### Skill not found
```bash
# Ensure the skill file exists
ls ~/Documentos/ai/ui-skills/skills/

# Check installation
ls .opencode/skills/  # or .claude/skills/
```

### Conflicting constraints
Some skills may have conflicting rules (e.g., one suggests X while another suggests Y). When conflicts arise:
1. Prioritize `baseline-ui` for Tailwind projects
2. Framework skills (`next-best-practices`) take precedence over generic ones
3. Use judgment - not every rule applies to every situation

### Performance
Skills are lightweight text files. They add minimal overhead to your agent context.

## 📚 Resources

- [ui-skills.com](https://ui-skills.com/) - Full directory (109 skills)
- [Original Repository](https://github.com/ibelick/ui-skills) - Source
- [Andrej Karpathy Principles](https://github.com/multica-ai/andrej-karpathy-skills) - Behavioral guardrails

## 🤝 Contributing

To add new skills:
1. Download from [ui-skills.com](https://ui-skills.com/)
2. Add to `skills/` directory
3. Update this README
4. Update `install.sh`

## 📄 License

MIT - Same as original ui-skills project.

## 🙏 Credits

- [Julien Thibeaut (ibelick)](https://github.com/ibelick) - Original ui-skills creator
- All skill authors listed above
- [Andrej Karpathy](https://twitter.com/karpathy) - For the foundational principles

---

**Remember:** These skills are constraints, not creativity killers. They prevent common AI coding pitfalls while leaving room for good design decisions.
# ui-skill-package
# ui-skill-package

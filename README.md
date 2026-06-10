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

## 🚀 Installation

### Method 1: Install All Skills (Recommended for new projects)

```bash
# Clone this repo
git clone https://github.com/your-username/ui-skills.git ~/Documentos/ai/ui-skills

# Navigate to your project
cd /path/to/your/project

# Install all skills
~/Documentos/ai/ui-skills/install.sh --all
```

### Method 2: Install Selective Skills

```bash
# Install only specific skills
~/Documentos/ai/ui-skills/install.sh baseline-ui next-best-practices react-best-practices

# Install framework-specific set
~/Documentos/ai/ui-skills/install.sh next-best-practices react-best-practices shadcn

# Install design quality set
~/Documentos/ai/ui-skills/install.sh baseline-ui frontend-design make-interfaces-feel-better
```

### Method 3: Per-Project Manual Installation

```bash
# Copy specific skills to your project
cp ~/Documentos/ai/ui-skills/skills/ibelick-baseline-ui.md .opencode/skills/baseline-ui/SKILL.md
cp ~/Documentos/ai/ui-skills/skills/vercel-labs-next-best-practices.md .opencode/skills/next-best-practices/SKILL.md
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

```
ui-skills/
├── README.md                          # This file
├── install.sh                         # Installation script
├── skills/                            # Curated skills
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

## 🔧 How It Works

### For Agents (Subagents)

When an agent is working on a frontend task, it should:

1. **Detect the context:**
   - Is this a new UI feature or reviewing existing?
   - What framework is being used (React, Next.js, Vue)?
   - Is Tailwind being used?

2. **Load relevant skills:**
   ```bash
   # Agent loads skills based on context
   if [framework == "next.js"]; then load next-best-practices
   if [using_tailwind]; then load baseline-ui
   if [adding_animation]; then load 12-principles-of-animation
   ```

3. **Apply constraints:**
   - Follow rules from loaded skills
   - Check work against skill constraints
   - Report violations with fixes

### Integration with Your Main Config

Add to your project's `AGENTS.md` or `CLAUDE.md`:

```markdown
## UI Skills Integration

When working on frontend/UI tasks, the following skills are available:

### Available Skills
- `/baseline-ui` - Tailwind + motion constraints
- `/next-best-practices` - Next.js patterns
- `/react-best-practices` - React architecture
- `/frontend-design` - Anti-generic design
- `/fixing-accessibility` - WCAG compliance
- `/12-principles-of-animation` - Motion quality

### Skill Selection Rules
- New UI component → Load `baseline-ui` + framework skill
- Design review → Load `frontend-design` + `baseline-ui`
- Animation work → Load `12-principles-of-animation`
- Accessibility audit → Load `fixing-accessibility`
- Component library → Load `shadcn` + `baseline-ui`

### Quality Gates
Before completing UI work:
1. Run `/baseline-ui <file>` to check constraints
2. Verify accessibility with `/fixing-accessibility`
3. Check motion quality (if animated)
```

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

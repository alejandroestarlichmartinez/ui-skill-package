# UI Skills Index
# OpenCode Skill Registry Entry

## Skills

### Core Quality
- **baseline-ui**: Tailwind CSS + Framer Motion constraints. Ensures professional quality output.
  - Trigger: "apply constraints", "review UI", "check Tailwind"
  - Category: Quality Assurance
  - Dependencies: Tailwind CSS

- **frontend-design**: Prevents generic AI-generated design. Enforces distinctive UI patterns.
  - Trigger: "design review", "anti-generic", "distinctive UI"
  - Category: Design Quality
  - Dependencies: None

### Framework-Specific
- **next-best-practices**: Next.js App Router patterns, RSC best practices, performance optimization.
  - Trigger: "Next.js patterns", "App Router", "RSC"
  - Category: Framework
  - Dependencies: Next.js

- **react-best-practices**: Component architecture, hooks patterns, state management.
  - Trigger: "React patterns", "component architecture"
  - Category: Framework
  - Dependencies: React

- **shadcn**: shadcn/ui component workflow, installation patterns, customization.
  - Trigger: "shadcn", "component library"
  - Category: Framework
  - Dependencies: Next.js, shadcn/ui

### UI/UX Enhancement
- **ui-ux-pro-max**: Comprehensive UI/UX intelligence. Professional interface standards.
  - Trigger: "comprehensive UI", "professional interface"
  - Category: Design
  - Dependencies: None

- **make-interfaces-feel-better**: Interface polish, micro-interactions, hover states.
  - Trigger: "polish UI", "micro-interactions"
  - Category: Polish
  - Dependencies: None

- **interaction-design**: Microinteractions, delightful UX, timing, easing.
  - Trigger: "microinteractions", "delightful UX"
  - Category: Interaction Design
  - Dependencies: None

### Animation
- **12-principles-of-animation**: Disney's principles applied to UI. Motion quality.
  - Trigger: "add animation", "motion design"
  - Category: Animation
  - Dependencies: None

### Design Systems
- **swiss-design**: Grid discipline, typography, editorial design.
  - Trigger: "grid", "typography", "editorial"
  - Category: Design System
  - Dependencies: None

### Accessibility
- **fixing-accessibility**: WCAG compliance, semantic HTML, ARIA patterns.
  - Trigger: "a11y", "WCAG", "accessibility"
  - Category: Accessibility
  - Dependencies: None

## Usage Rules

### Selection Logic
```
New UI feature:
├── Using Tailwind → baseline-ui
├── Using Next.js → next-best-practices + react-best-practices
├── Using React → react-best-practices
├── Design feels generic → frontend-design
└── Need polish → make-interfaces-feel-better

Animation work:
├── Motion design → 12-principles-of-animation
└── Microinteractions → interaction-design

Design systems:
├── Grid/Typography → swiss-design
└── Components → shadcn + baseline-ui

Review existing UI:
├── Check constraints → baseline-ui <file>
├── Accessibility audit → fixing-accessibility
└── Polish pass → make-interfaces-feel-better
```

### Quality Gates
Before completing UI work:
1. Run `baseline-ui <file>`
2. Run `fixing-accessibility` (if applicable)
3. Run `12-principles-of-animation` (if animated)

## Installation

```bash
# Install all skills
~/Documentos/ai/ui-skills/install.sh --all

# Install default set
~/Documentos/ai/ui-skills/install.sh --default

# Install specific skill
~/Documentos/ai/ui-skills/install.sh baseline-ui
```

## Configuration

### Per-Project Setup
```bash
~/Documentos/ai/ui-skills/setup.sh
```

### Manual Agent Configuration
Copy `AGENTS.md.template` to project's `AGENTS.md` or `CLAUDE.md`.

## Skill Format

All skills are plain Markdown files in `skills/` directory.
Format: `/skill-name [arguments]`

Example:
```
/baseline-ui src/components/Button.tsx
```

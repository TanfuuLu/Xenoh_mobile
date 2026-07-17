# Xenoh — Frontend Style Guide (UX/UI for Mobile)

> Single reference for every visual style the Xenoh frontend uses to build mobile UI.
> **Source of truth:** [`src/styles/globals.css`](src/styles/globals.css). The palette in
> `CLAUDE.md` §11 (dark mode / indigo) is **outdated** — the app ships a **warm, earthy
> light theme** described below.

Brand mood: *sandstone, clay, sage* — the discipline of training + the calm of recovery.
Light mode only (`color-scheme: light`). All styling via **Tailwind CSS v4** utilities and
the `xn-*` component classes; **no inline `style={{}}`**, **no `any`**, mobile-first.

---

## 1. Design tokens (CSS variables)

All defined on `:root` in `globals.css`. Use these — never hardcode hex values.

### 1.1 Brand palette

| Ramp | Tokens | Use |
|------|--------|-----|
| **Clay** (warm primary) | `--xn-clay-050 … --xn-clay-900` | Brand, accents, primary surfaces |
| **Sage** (success/accent) | `--xn-sage-100 … --xn-sage-700` | Success, completion, secondary accent |
| **Ink** (warm neutrals) | `--xn-ink-050 … --xn-ink-900` | Text, borders, neutral surfaces |
| **Paper** | `--xn-paper` `#efe4d5`, `--xn-paper-alt` `#d8bd98` | Page canvas / sand surface |

Key brand values: clay-800 `#725945` (accent), clay-900 `#583f2e`, sage-500 `#959976`,
ink-900 `#2e2218` (deepest text), paper `#efe4d5` (page bg).

### 1.2 Semantic tokens (prefer these in components)

```
Text      --fg-1 primary · --fg-2 secondary · --fg-3 tertiary/meta · --fg-4 disabled/hint
          --fg-on-clay (#fff, text on clay)
Surfaces  --bg-1/--bg-page page canvas · --bg-2 #fffaf3 raised card · --bg-3 #ead7bd panel
          --bg-4 sand accent · --bg-inverse dark
Borders   --border-1 #c1aa95 default · --border-2 #8f735e strong
          --surface-border / --surface-border-soft (component borders)
Accent    --accent (clay-800) · --accent-hover · --accent-press · --accent-soft · --accent-on
          --accent-2 (sage) · --accent-2-soft
Buttons   --button-bg #fbf7ef · --button-hover #f1e8dc · --button-border #d7c7b6 · --button-text
```

### 1.3 Status colors

| Intent | Fg | Bg |
|--------|----|----|
| Success | `--xn-success` `#485a26` | `--xn-success-bg` `#e8ecd6` |
| Warning | `--xn-warning` `#8d560d` | `--xn-warning-bg` `#f0e0c8` |
| Danger  | `--xn-danger` `#802013`  | `--xn-danger-bg` `#f0d9d6` |
| Info    | `--xn-info` `#485a66`    | `--xn-info-bg` `#dee5ea` |

### 1.4 Bright icon accents (vivid chips only)

`--ic-red --ic-orange --ic-amber --ic-green --ic-cyan --ic-blue --ic-purple --ic-pink`
(standard `#ef4444`…`#ec4899`). Used for colorful icon tiles, **not** body UI.

### 1.5 Tailwind utility mapping (`@theme inline`)

These tokens become Tailwind classes:

| Class | Token |
|-------|-------|
| `bg-background` / `text-text` | page bg / primary text |
| `bg-surface` | raised card (`--bg-2`) |
| `bg-primary` / `text-primary` | accent clay |
| `text-muted` | `--fg-3` |
| `border-border` | default border |
| `bg-panel` `bg-sand` `bg-sage` | panel / accent-soft / sage |
| `text-success` `text-danger` `text-warning` | status |
| `font-display` `font-sans` `font-mono` | font families |

---

## 2. Typography

Fonts loaded via Google Fonts `<link>` in [`index.html`](index.html).

| Family | Token | Role |
|--------|-------|------|
| **Fraunces** (serif) | `--font-display` | Headings, brand, stats, plan/exercise names |
| **Geist** (sans) | `--font-sans` | All UI/body text |
| **JetBrains Mono** | `--font-mono` | Numbers, dates, set/rep lines (`tabular-nums`) |
| **Be Vietnam Pro** | — | Auto-swapped for display **and** sans when `<html lang="vi">` (full diacritics) |

Base: `html` at `font-size: 90%` (desktop), body `1rem` / line-height `1.5`.
Headings use Fraunces with tight tracking (`-0.01em` / `-0.02em`).

**Helper classes** (from design system): `.xn-eyebrow` (uppercase caps label),
`.xn-meta` (small muted), `.xn-lede`, `.xn-stat` / `.stat-value` (big serif number).

---

## 3. Spacing, radius, shadow, motion

```
Spacing   4px base scale: --sp-1 (4px) … --sp-24 (96px)
Radius    --r-xs 4 · --r-sm 6 · --r-md 10 · --r-lg 14 · --r-xl 20 · --r-2xl 28 · --r-pill 999
          (components mostly use 8–14px; buttons/chips = pill 999px)
Shadows   --sh-xs … --sh-xl  (warm brown-tinted, never cool/blue) · --sh-inset
Motion    --dur-fast 120ms · --dur-med 220ms · --dur-slow 420ms
          --ease-out cubic-bezier(.22,1,.36,1) · --ease-in-out cubic-bezier(.65,0,.35,1)
Interact  --interactive-y -1px (hover lift) · --interactive-press-scale .985 (active)
          --interactive-icon-scale 1.06 · --interactive-focus (3px clay focus ring)
```

**Global interactive behavior** (automatic on `button`, `a[href]`, `.xn-interactive`,
`.xn-choice-card`, `.xn-nav-item`):
- hover → `translateY(-1px)`, icons lift + scale `1.06`
- active → `scale(.985)`, icons `scale(.96)`
- focus-visible → clay focus ring, no outline
- `-webkit-tap-highlight-color: transparent` (clean mobile taps)
- All disabled inside `@media (prefers-reduced-motion: reduce)`.

---

## 4. Component classes (`xn-*`)

Reusable styled primitives in `globals.css`. Combine with Tailwind for layout.

| Class | What it is |
|-------|-----------|
| `.xn-shell` / `.xn-main` | App grid: sidebar + content (collapses to 1 col on mobile) |
| `.xn-sidebar` `.xn-brand` `.xn-brand-name` | Left nav + brand wordmark (Fraunces, clay-800) |
| `.xn-nav` `.xn-nav-section` `.xn-nav-item` `.xn-nav-active-indicator` | Nav list; active = clay-200 pill behind label |
| `.xn-topbar` | Sticky blurred top bar (`backdrop-filter: blur(14px)`) |
| `.xn-page-container` | Centered content card (max 1040px); `.wide` / `.insights-page` variants |
| `.xn-card` (+`.sand`) `.xn-dashboard-hero` `.xn-mini-card` | Card surfaces, hover lift + shadow |
| `.xn-btn` | Pill button. Variants: `.primary .secondary .ghost .danger .success`, size `.sm` |
| `.xn-chip` | Pill badge. Variants: `.accent .sage .warn .danger .outline` |
| `.xn-input` (+`.error`) | Form field; clay focus ring; textarea supported |
| `.xn-plan` (`.plan-name/.plan-dates/.plan-bar`) | Workout plan card + progress bar (sage fill) |
| `.xn-hero` | Today/highlight card: clay gradient + grain texture overlay |
| `.xn-ex` (+`.complete`) | Exercise card; complete = sage tint |
| `.xn-set` (+`.done`) | Set row (mono); done = sage |
| `.xn-day` (+`.done`/`.active`) | Week day strip cell |
| `.xn-stat` (`.stat-label/.stat-value`) | Metric tile (uppercase label + big serif value) |
| `.xn-clientrow` | Coach's client list row (grid) |
| `.xn-choice-card` | Clickable card w/ animated icon + arrow |
| `.xn-avatar` (+`.sage`) | Round initials avatar |
| `.xn-icon-button` `.xn-topbar-button` `.xn-segment-button` `.xn-theme-toggle` | Icon/control buttons |

---

## 5. Mobile-first responsive rules

Breakpoint is **768px** (`md:` in Tailwind). Build for 375px first, verify at 375 & 1280px.

**`@media (max-width: 767px)` overrides built into `globals.css`:**
- `html` drops to `font-size: 85%` (whole UI scales down).
- `.xn-shell` collapses to a **single column**; `.xn-sidebar-desktop` hidden,
  `.xn-sidebar-mobile` shown (≥768px the reverse). Top bar grows to 56px.
- Fluid type ramp: `h1/.text-2xl` → 1.375rem, `h2/.text-xl` → 1.125rem, down to `.text-xs`.
- **Touch targets enlarged:** `.xn-btn` `min-height: 38px` (`.sm` 34px), inputs/chips padded up,
  buttons wrap + center. Keep tap targets ≥ ~38px.
- `.xn-page-container` tighter margins/padding, smaller radius.
- Stat/plan/exercise font sizes shrink for small screens.

**In components:** use Tailwind mobile-first (`flex-col md:flex-row`, `text-sm md:text-base`,
`hidden md:block`). Default = mobile; add `md:`/`lg:` for larger.

---

## 6. Animation (Framer Motion)

Presets in [`src/shared/utils/motion.ts`](src/shared/utils/motion.ts) — **don't write new
animations if a preset fits.** Always provide a `useReducedMotion()` fallback.

| Preset | Effect | Use for |
|--------|--------|---------|
| `fadeIn` | opacity 0→1 (200ms) | generic reveal |
| `slideUp` | opacity + y 16→0 (300ms easeOut) | pages, list items, toasts |
| `scaleIn` | opacity + scale .95→1 (200ms) | modals, dropdowns |
| `staggerContainer` | `staggerChildren .07s` | wrap lists |
| `softCardGroup` / `softCardItem` | gentle staggered card entrance | dashboards, card grids |

Spread via `motionProps`, e.g. `<motion.div {...motionProps.slideUp}>`.
Wrap add/remove lists in `<AnimatePresence>`. Add `whileTap={{ scale: 0.97 }}` to interactive buttons.

---

## 7. Quick rules

- ✅ Use tokens (`var(--…)`) and `xn-*` classes + Tailwind utilities; `cn()` for conditional classes.
- ✅ Mobile-first; touch targets ≥ ~38px; verify 375px & 1280px.
- ✅ Numbers/dates → `font-mono` + `tabular-nums`. Headings/stats → `font-display` (Fraunces).
- ✅ Every animation has a reduced-motion fallback.
- ❌ No inline `style={{}}`, no hardcoded hex, no cool/blue shadows, no dark-mode assumptions.
- ❌ Don't trust `CLAUDE.md` §11 colors — `globals.css` is authoritative (warm earthy light theme).

---

### Related files
- [`src/styles/globals.css`](src/styles/globals.css) — tokens + all `xn-*` components (authoritative)
- [`src/styles/marketing.css`](src/styles/marketing.css) — landing/marketing pages only (not in-app)
- [`Xenoh Design System/colors_and_type.css`](Xenoh%20Design%20System/colors_and_type.css) — original foundations reference
- [`index.html`](index.html) — font loading
- [`src/shared/utils/motion.ts`](src/shared/utils/motion.ts) — animation presets

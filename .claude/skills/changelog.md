# Changelog Style Guide

Step Quest changelogs follow **Dwarf Fortress patch notes** style - technical accuracy with whimsical narrative flair.

## Version Naming

Each version gets a thematic subtitle in quotes:
- v0.7.0 - "The Quest for a Proper Address"
- v0.6.0 - "The Watchtower Speaks Many Tongues"
- v0.5.0 - "The Grand Opening"
- v0.4.0 - "The Tower of Babel Falls"
- v0.3.0 - "The Supporter's Guild"
- v0.2.0 - "The Health Connection"
- v0.1.0 - "The Great Awakening"

## Writing Style

### Item Headers (Hybrid Style)

Use thematic names with technical terms in parentheses for searchability:

```markdown
### New Chambers
- **The Grand Gates Open** (Google Play) — The fortress welcomes adventurers
- **The Watchtower's Eyes** (Crashlytics) — Walls report when they crumble
```

Format: `**Thematic Name** (Technical Term) — Poetic description`

This preserves:
- **Flavor**: The thematic name leads, setting the tone
- **Searchability**: Technical term in parentheses for grep/search
- **Clarity**: Description explains what actually happened

### Bug Fixes
Frame as epic battles or discoveries:
- "Fixed Android Virtual Device refusing to materialize on the host plane"
- "Prevented the build system from starving due to missing Java sustenance"
- "The `xpGold` color, though noble in intent, did not exist in the theme scrolls"

### Features
Describe as fortress improvements or guild activities:
- "The fortress now reports when walls crumble" (Crashlytics)
- "The fortress now receives tribute from the realm's fitness trackers" (Health Connect)
- "The northern realms join the quest" (Nordic languages)

### Infrastructure
Frame as construction or expansion:
- "The fortress finally has a proper address" (custom domain)
- "A map for future domain expeditions" (documentation)

## Section Headers

Use thematic headers instead of generic ones:

| Topic | Thematic Header |
|-------|-----------------|
| DNS, hosting, CI/CD | **The Mason's Work** or **Fortifications** |
| Error reporting | **The Watchtower** |
| Language support | **The Translator's Guild** or **Foreign Tongues** |
| Docs and policies | **The Scribes' Archives** |
| Implementation details | **Secrets of the Deep** |
| Design decisions | **The Architect's Wisdom** |
| Bug fixes | **Battles Won** or **Menaces Vanquished** |
| New features | **New Chambers** or **Expeditions** |
| Dependencies | **Alliances Formed** or **Trade Agreements** |
| External links | **Trade Routes** |
| Breaking changes | **The Great Upheaval** |
| Security | **The Guard's Report** |
| Performance | **The Miners' Efficiency** |
| Completed items | **Quests Fulfilled** |
| Known issues | **Challenges Ahead** |

## Future Sections

As the fortress grows, new sections may emerge. Some possibilities:

| Topic | Possible Headers |
|-------|------------------|
| Testing / QA | **The Proving Grounds**, **Trials of the Forge** |
| Deprecations | **Relics of the Past**, **The Old Ways Fade** |
| Migrations | **The Great Migration**, **Exodus** |
| Refactoring | **The Architects Rebuild**, **Restructuring the Depths** |
| UI/UX changes | **The Artisan's Touch**, **Surface Improvements** |
| Accessibility | **Gates for All**, **The Welcome Mat** |
| Analytics | **The Census Takers**, **Eyes of the Mountain** |
| Platform-specific | **Tales from the Watchtower** (Wear), **The Surface Realm** (mobile), **The Apple Orchards** (iOS) |
| Database/Storage | **The Vault**, **Deep Storage** |
| Networking/API | **Messages from Afar**, **The Courier's Route** |
| Notifications | **The Herald's Call**, **Bells of the Tower** |
| Permissions | **Keys to the Kingdom**, **Access Granted** |
| CI/CD changes | **The Forge Automation**, **Assembly Lines** |
| Third-party integrations | **Foreign Alliances**, **Pacts with Outsiders** |
| Community contributions | **Gifts from Travelers**, **The Adventurers' Aid** |
| Experimental features | **The Alchemist's Lab**, **Unstable Excavations** |
| Rollbacks/Reverts | **Strategic Retreat**, **The Undo Rune** |
| Optimization | **The Miners' Efficiency**, **Streamlining the Tunnels** |
| Cleanup | **Spring Cleaning**, **Sweeping the Halls** |

### Variations by Tone

The same topic can have different headers based on severity or mood:

**For bug fixes:**
- Minor: **Cobwebs Cleared**
- Normal: **Menaces Vanquished**
- Critical: **The Beast is Slain**

**For features:**
- Small: **Minor Improvements**
- Normal: **New Chambers**
- Major: **Grand Expeditions**

**For breaking changes:**
- Minor: **Shifting Foundations**
- Major: **The Great Upheaval**
- Critical: **The Cataclysm**

### Seasonal / Thematic Variations

For special releases, consider thematic headers:
- Holiday release: **Winter's Gift**, **The Solstice Update**
- Anniversary: **One Year in the Deep**, **The Founding Day**
- Major milestone: **The Dragon's Hoard** (1.0), **The Second Age** (2.0)

## Footer

End the changelog with a link to the source of inspiration:
```
*"Losing is fun!" - [Dwarf Fortress](https://www.bay12games.com/dwarves/) wisdom*
```

## Example Entry

```markdown
## v0.8.0 - "The Cartographer's Update" (2026-01-26)

### The Mason's Work
- **Cloud DNS Migration** — The realm's maps now live in the cloud
  - Subdomain delegation keeps the old kingdoms safe
  - Future expeditions can claim `*.quest.mqqn.net`

### Menaces Vanquished
- **Corrected the ancient scroll references**
  - The import path, lost to time, has been rediscovered
  - Adventurers no longer wander in darkness

### The Translator's Guild
- **Elvish (el)** — For the immortal walkers of Middle-earth
- **Orcish (or)** — WAAAAAGH! steps count double
```

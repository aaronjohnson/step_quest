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

## Footer

End the changelog with:
```
*"Losing is fun!" - Dwarf Fortress wisdom*
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

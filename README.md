# 🌌 Cosmic Compass • Oha Asa & Global Multi-Cultural Horoscope

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20Web%20(GitHub%20Pages)%20%7C%20Windows-6A11CB)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Cosmic Compass** is an architectural multi-cultural cosmic astrology and divination platform built in Flutter. It calculates, unifies, and compares an individual's personal birth chart across **11 global civilizational traditions**, provides an overarching **Single Cosmic Profile & Cross-Cultural Synthesis Matrix**, generates multi-tradition daily forecasts alongside the authentic Japanese **Oha Asa** TV morning rankings, and deploys as both a native Android app and a static web app via **GitHub Pages**.

---

## 🧭 The 11 Global Astrological Systems

```
                              ┌────────────────────────┐
                              │  USER COSMIC PROFILE   │
                              │ (Date, Time, Blood, Pl)│
                              └───────────┬────────────┘
                                          │
        ┌─────────────────────────────────┼────────────────────────────────┐
        │                                 │                                │
┌───────▼────────┐              ┌─────────▼──────────┐            ┌────────▼───────┐
│   EAST ASIAN   │              │    SOUTH ASIAN     │            │    AMERICAS    │
│ • Oha Asa      │              │ • Vedic (Jyotish)  │            │ • Mayan Tzolk'in│
│ • Blood Type   │              │ • Nadi Palm Leaves │            │ • Aztec Tonal. │
│ • Chinese BaZi │              └────────────────────┘            │ • Med. Wheel   │
│ • Zi Wei Dou Shu│                                               └────────────────┘
└────────────────┘              ┌────────────────────┐            ┌────────────────┐
                                │   GRECO & ARABIC   │            │ EUROPEAN FOLK  │
                                │ • Western Ecliptic │            │ • Celtic Trees │
                                │ • Arabian Lots     │            │ • Norse Runes  │
                                └────────────────────┘            └────────────────┘
                                          │
                               ┌──────────▼──────────┐
                               │  COSMIC SYNTHESIS   │
                               │  • Element Balance  │
                               │  • Synergy Score    │
                               │  • Universal Mantra │
                               └─────────────────────┘
```

| System | Origin / Civilization | Primary Basis & Astronomical Cycle | Core Output |
| :--- | :--- | :--- | :--- |
| **Oha Asa** | Japan (TV Asahi) | Western Zodiac + Live TV Ranking | Daily 1–12 rank, lucky item, lucky color, 4 luck bars (Money, Love, Work, Health) |
| **Ketsuekigata** | Japan & East Asia | Biological ABO Antigen Typology | Temperament, daily interpersonal compatibility, workplace role |
| **BaZi & Zodiac** | China (Han/Song) | 60-Year Sexagenary Cycle, 5 Elements, Yin/Yang | 12 Animals, Four Pillars (Year, Month, Day, Hour), Day Master balance |
| **Zi Wei Dou Shu** | Imperial China | Lunar Ephemeris, Polaris & 12 Life Palaces | Major Star archetype (Zi Wei, Tian Ji, etc.), Life & Career Palaces |
| **Vedic (Jyotish)** | India (Vedas) | Sidereal Zodiac (**Lahiri Ayanamsa** ~24.1°) | Sidereal Rashi, 27 Nakshatras (Lunar Mansions), Vimshottari Dasha |
| **Nadi Astrology** | South India | Ancient Rishi Palm-Leaf Manuscripts | 12 Kaanda Chapters, karmic archetype, destiny lesson, remedial mantra |
| **Western & Hellenistic** | Greece & Alexandria | Tropical Solar Ecliptic Equinoxes | Sun, Moon, Ascendant estimates, Modality, 4 Elements, House of Sun |
| **Arabian & Persian** | Islamic Golden Age | Mathematical Lots & Chaldean Planetary Hours | Part of Fortune (*Pars Fortunae*), birth planetary hour, golden activity window |
| **Mayan Tzolk'in** | Mesoamerica | Sacred 260-Day Count (13 Tones × 20 Nahuals) | Kin Number (1–260), Galactic Tone (1–13), Solar Nahual, Sacred Direction |
| **Aztec Tonalpohualli** | Central Mexico | 260-Day Sacred Count of 20 Trecenas | 20 Day Signs (Cipactli, Ehecatl, etc.), Patron Deity, Cardinal Lord |
| **Medicine Wheel** | Indigenous Americas | 12 Moons & 4 Elemental Clans Earth Wheel | Totem Animal (Hawk, Beaver, Bear, Wolf, etc.), Clan, Plant & Mineral |
| **Celtic Tree** | Ancient Britain/Gaul | 13 Lunar Tree Months & Ogham Alphabet | Sacred Tree (Birch, Rowan, Oak, etc.), Ogham glyph, animal guide |
| **Norse Runic Divination** | Scandinavia | 24 Elder Futhark Runes & 3 Aettir | Solar Birth Rune, Hour Rune, interactive daily rune casting ceremony |

---

## 🏛️ Authoritative Data Provenance & References

The app adheres to recognized astronomical and archival standards:
- **Oha Asa**: Direct scraping from [TV Asahi Good Morning Morning](https://www.tv-asahi.co.jp/goodmorning/uranai/) with seamless astronomical fallback for offline/CORS environments.
- **BaZi & Chinese Cycles**: Grounded in the [Hong Kong Observatory Gregorian-Lunar Conversion Tables (1901–2100)](https://www.hko.gov.hk/en/gts/time/conversion.htm) and Purple Mountain Observatory solar terms (*Jie Qi*).
- **Vedic & Sidereal**: Uses the official **Lahiri Ayanamsa** (*Chitra Paksha*) recognized by the Positional Astronomy Centre (Govt. of India) and [Astrodienst Swiss Ephemeris](https://www.astro.com/swisseph/).
- **Mayan Calendar**: Employs the **Goodman-Martínez-Thompson (GMT 584283) Correlation Constant** validated by the [Smithsonian National Museum of the American Indian](https://maya.nmai.si.edu/the-maya/maya-calendar) and [FAMSI](http://www.famsi.org/).
- **Aztec Tonalpohualli**: Based on the *Codex Borgia* and *Codex Borbonicus* records maintained by the Instituto Nacional de Antropología e Historia (INAH, Mexico).
- **Norse Runes**: Based on the Elder Futhark archaeological runestones cataloged in Uppsala University's Rundata and the Arnamagnæan Manuscript Rune Poems.

---

## 📱 Application Architecture & Screens

1. **Daily Forecast (`TodayScreen`)**:
   - Live Oha Asa morning TV rankings (#1 to #12) with custom user hero card.
   - Interactive **Norse Rune of the Day** casting ritual with 3D-like flip animation.
   - Cross-Cultural Daily Transits carousel (BaZi Day Qi, Mayan Day Kin, Vedic Moon, Blood Type social tip, Arabian golden hours).
2. **My Cosmic Charts (`ProfileScreen`)**:
   - Universal Archetype Banner with cosmic synergy score (78–99%).
   - Universal Synthesis Mantra.
   - Rich interactive cards for all 11 traditions.
3. **Cross-Cultural Synthesis (`ComparisonScreen`)**:
   - Side-by-side comparative matrix filterable by geographic region.
   - 5-Element Radar Matrix (Fire, Earth, Air, Water, Ether) with dominant element resolution.
   - Alignment synergy insights comparing tropical vs sidereal, clans vs elements, and nahuals vs trees.
4. **Traditions Codex (`CodexScreen`)**:
   - Interactive historical compendium with origin lore, astronomical cycles, and clickable resource citations.

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: `^3.10.7` or later (tested on Flutter 3.47+)
- **Target Platforms**: Android (SDK 21+), Web (all modern browsers), Windows/macOS/Linux

### Local Development
```bash
# 1. Clone repository
git clone https://github.com/kisalnelaka/oha_asa_app.git
cd oha_asa_app

# 2. Fetch dependencies
flutter pub get

# 3. Verify static analysis and test suite
flutter analyze
flutter test

# 4. Run locally
flutter run -d chrome     # Web
flutter run -d android    # Android Device / Emulator
```

---

## 🌐 Deploying to GitHub Pages

The repository includes a ready-to-use GitHub Actions workflow (`.github/workflows/deploy.yml`).

### Automatic Deployment
1. Push your repository to GitHub (`master` or `main` branch).
2. In GitHub, navigate to **Settings** > **Pages**.
3. Under **Build and deployment**, select **Deploy from a branch** and choose the `gh-pages` branch.
4. Your application will automatically be live at:
   ```
   https://kisalnelaka.github.io/oha_asa_app/
   ```

### Manual Web Build
```bash
flutter build web --release --base-href "/oha_asa_app/"
```
The production bundle is generated inside `build/web`.

---

## 📦 Android Release Build

```bash
flutter build apk --release
```
*Output: `build/app/outputs/flutter-apk/app-release.apk`*

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for details.

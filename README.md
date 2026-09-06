# 🎨 Cosmic Compass: Oha Asa and Global Multi-Cultural Field Guide

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20Web%20(GitHub%20Pages)%20%7C%20Windows-6A11CB)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Cosmic Compass** is a handcrafted astrological field guide and daily companion built in Flutter. Designed with an authentic hand-drawn sketchbook aesthetic (warm paper texture, soft pencil sketch lines, red marker highlights, ballpoint blue notes, and tactile taped index cards), it maps your personal birth details across **11 world traditions**, calculates your unified cosmic profile, provides daily multi-cultural forecasts with live Japanese **Oha Asa** TV morning rankings, and lets you evaluate deep interpersonal synergy with your partner.

---

## 🧭 The 11 World Traditions

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
                                │ • Chaldean Hours   │            └────────────────┘
                                └────────────────────┘
                                          │
                                ┌──────────▼──────────┐
                                │  COSMIC SYNTHESIS   │
                                │  • Element Balance  │
                                │  • Synergy Score    │
                                │  • Universal Mantra │
                                └─────────────────────┘
```

| Tradition | Cultural Roots | Astronomical and Philosophical Basis | Key Insights |
| :--- | :--- | :--- | :--- |
| **Oha Asa** | Japan (TV Asahi) | Western Zodiac and Live TV Morning Rankings | Daily 1 to 12 rank, lucky item, lucky color, and 4 luck bars (Money, Love, Work, Health) |
| **Ketsuekigata** | Japan and East Asia | Biological ABO Antigen Typology | Temperament, daily interpersonal harmony, and collaborative role |
| **BaZi and Zodiac** | China (Han and Song) | 60-Year Sexagenary Cycle, 5 Elements, and Yin/Yang | 12 Animals, Four Pillars (Year, Month, Day, Hour), and Day Master balance |
| **Zi Wei Dou Shu** | Imperial China | Lunar Ephemeris, North Star, and 12 Life Palaces | Major Star archetype (Zi Wei, Tian Ji, etc.), Life and Career Palaces |
| **Vedic (Jyotish)** | India (Vedas) | Sidereal Zodiac (Lahiri Ayanamsa at 24.1 degrees) | Sidereal Rashi, 27 Nakshatras (Lunar Mansions), and Vimshottari Dasha |
| **Nadi Astrology** | South India | Ancient Rishi Palm-Leaf Manuscripts | 12 Kaanda Chapters, karmic archetype, destiny lesson, and remedial mantra |
| **Western Zodiac** | Greece and Alexandria | Tropical Solar Ecliptic and Seasonal Equinoxes | Sun, Moon, Ascendant estimates, Modality, and 4 Classical Elements |
| **Arabian and Persian** | Islamic Golden Age | Mathematical Lots and Chaldean Planetary Hours | Part of Fortune (*Pars Fortunae*), birth planetary hour, and golden activity window |
| **Mayan Tzolk'in** | Mesoamerica | Sacred 260-Day Count (13 Tones x 20 Solar Nahuals) | Kin Number (1 to 260), Galactic Tone (1 to 13), Solar Nahual, and Sacred Cardinal Direction |
| **Aztec Tonalpohualli** | Central Mexico | 260-Day Sacred Count of 20 Trecenas | 20 Day Signs (Cipactli, Ehecatl, etc.), Patron Deity, and Cardinal Lord |
| **Medicine Wheel** | Indigenous Americas | 12 Moons and 4 Elemental Clans Earth Wheel | Totem Animal (Hawk, Beaver, Bear, Wolf, etc.), Clan, Plant, and Mineral Guides |
| **Celtic Tree Calendar** | Ancient Britain and Gaul | 13 Lunar Tree Months and the Sacred Ogham Alphabet | Birth Tree (Birch, Rowan, Oak, etc.), Ogham glyph, and animal spirit companion |
| **Norse Runic Divination** | Scandinavia | 24 Elder Futhark Runes and 3 Aettir | Solar Birth Rune, Hour Rune, and interactive daily rune casting ceremony |

---

## ✨ Features Built for Mobile and Web

### 📱 Mobile Experience
- **Daily 7:00 AM Morning Reminders**: Powered by `flutter_local_notifications`, automatically scheduling daily updates when new Oha Asa fortunes go live.
- **Home Screen Quick Widgets**: Syncs your daily rank, star sign, lucky color, and lucky charm right to your home screen using `home_widget`.
- **Haptic Feedback and Touch Feel**: Tactile press animations and zero-blur hard offset shadows that feel like interacting with physical paper cards and stationery.

### 🌐 Web and Sharing Experience
- **One-Tap Clipboard Sharing**: Instantly format and copy clean, readable text summaries of your daily fortune or partner synastry score to send to friends via WhatsApp, Discord, or Messages.
- **Responsive Binder Layout**: Seamlessly transitions between a desktop field-journal notebook and a focused mobile handbook.
- **Fast Offline Fallback**: If the live TV Asahi morning horoscope scrape is blocked by CORS or network limits, the app immediately calculates authentic daily rankings so you never miss your fortune.

### 🤝 Cross-Cultural Partner Synergy
- Add your partner's name, birthday, birth time, and blood type.
- Analyzes compatibility across 5 distinct cultural perspectives:
  1. Western Elemental Harmony (Fire, Earth, Air, Water)
  2. Chinese BaZi 3-Harmony Trines (San He) and Secret Friends (Liu He)
  3. Japanese Blood Type Interpersonal Dynamics (Ketsuekigata matrix)
  4. Vedic Nakshatra Lunar Concordance (Kuta harmonics)
  5. Mayan Tzolk'in Galactic Kin Harmonics (Occult and Analog allies)
- Highlights clear practical advice across Communication, Shared Goals, and Growth Opportunities.

---

## 🏛️ Authoritative Data Standards and References

The app adheres to recognized astronomical and archival standards:
- **Oha Asa**: Direct scraping from [TV Asahi Good Morning Morning](https://www.tv-asahi.co.jp/goodmorning/uranai/) with seamless astronomical fallback for offline/CORS environments.
- **BaZi and Chinese Cycles**: Grounded in the [Hong Kong Observatory Gregorian-Lunar Conversion Tables (1901 to 2100)](https://www.hko.gov.hk/en/gts/time/conversion.htm) and Purple Mountain Observatory solar terms (*Jie Qi*).
- **Vedic and Sidereal**: Uses the official **Lahiri Ayanamsa** (*Chitra Paksha*) recognized by the Positional Astronomy Centre (Govt. of India) and [Astrodienst Swiss Ephemeris](https://www.astro.com/swisseph/).
- **Mayan Calendar**: Employs the **Goodman-Martínez-Thompson (GMT 584283) Correlation Constant** validated by the [Smithsonian National Museum of the American Indian](https://maya.nmai.si.edu/the-maya/maya-calendar) and [FAMSI](http://www.famsi.org/).
- **Aztec Tonalpohualli**: Based on the *Codex Borgia* and *Codex Borbonicus* records maintained by the Instituto Nacional de Antropología e Historia (INAH, Mexico).
- **Norse Runes**: Based on the Elder Futhark archaeological runestones cataloged in Uppsala University's Rundata and the Arnamagnaean Manuscript Rune Poems.

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: `^3.10.7` or later (tested on Flutter 3.47+)
- **Target Platforms**: Android (SDK 21+), Web (all modern browsers), Windows/macOS/Linux

### Local Development
```bash
# 1. Clone repository
git clone https://github.com/kisalnelaka/cosmic-compass.git
cd cosmic-compass

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
   https://kisalnelaka.github.io/cosmic-compass/
   ```

### Manual Web Build
```bash
flutter build web --release --base-href "/cosmic-compass/"
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

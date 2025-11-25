# Abir Rahman Portfolio

A responsive Flutter web experience for showcasing Abir Rahman’s mobile development work. It uses Material 3, animated sections, and data-driven content so updates stay simple.

## Highlights

- Hero, experience timeline, projects, skills, education, and contact CTA sections.
- Gradient-driven, animated UI powered by `flutter_animate` and Google’s Space Grotesk type.
- Content lives in a single JSON file (`assets/content/portfolio.json`) for quick edits without touching code.
- Responsive layout that adapts from phones to large monitors.

## Tech

- Flutter 3.9+
- `google_fonts`, `flutter_animate`, `url_launcher`
- Material 3 theme authored in `lib/theme/app_theme.dart`

## Running locally

```bash
flutter run -d chrome
# or
flutter run -d macos
```

## Updating content

1. Open `assets/content/portfolio.json`.
2. Update fields (summary, experience label, projects, etc.). Keep valid JSON.
3. Run `flutter pub get` (needed only if assets list changes) and hot-reload.
4. The app falls back to the embedded `PortfolioData.abir` if the JSON is missing or malformed.

### Hosting on Firebase

- Build the web app (`flutter build web`) and deploy the `build/web` folder with Firebase Hosting.
- Because the content is bundled as assets, no Firestore/Realtime Database setup is required and the site remains fully static/SEO-friendly.

## Customization tips

- Adjust gradients, shapes, or typography in `lib/theme/app_theme.dart`.
- Add new sections or widgets in `lib/portfolio_page.dart`.
- Extend `assets/content/portfolio.json` with new fields and parse them in `lib/data/profile.dart` if needed.
- Replace the placeholder headshot at `assets/images/profile.jpg` with your photo (same file name) to update the hero image.

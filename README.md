# What's in My Fridge?

Eine moderne Flutter-Web-App für Lebensmittelverwaltung, Ablaufdaten, Rezeptideen, Wochenplanung und Einkaufsliste.

## Funktionen

- Responsive Material-3-Oberfläche für Smartphone, Tablet und Desktop
- Heller, dunkler und systemabhängiger Darstellungsmodus
- Dashboard mit Kennzahlen und dringenden Ablaufdaten
- Durchsuchbares Inventar mit Kategorien und Löschfunktion
- Dialog zum Hinzufügen eigener Lebensmittel
- Rezeptideen mit Zutaten-Match und Favoriten
- Wochenplaner für Mahlzeiten
- Interaktive Einkaufsliste
- Automatisches Deployment über GitHub Actions auf GitHub Pages
- Quellcodeanalyse und automatischer Test bei jedem Push

## Lokaler Start

```bash
flutter pub get
flutter run -d chrome
```

## Produktions-Build

```bash
flutter build web --release --base-href "/whats-in-my-fridge/"
```

## GitHub Pages

Der Workflow unter `.github/workflows/deploy-pages.yml` baut und veröffentlicht die App automatisch nach jedem Push auf `main`.

Nach erfolgreichem Deployment ist die App unter folgender Adresse erreichbar:

`https://julik527.github.io/whats-in-my-fridge/`

## Projektstruktur

```text
lib/
├── application/        App-Zustand und Geschäftslogik
├── core/               Theme und Hilfsfunktionen
├── domain/             Datenmodelle
├── presentation/       Navigation, Screens und Widgets
├── app.dart            MaterialApp-Konfiguration
└── main.dart           Einstiegspunkt
```

## Aktueller Modus

Diese Version verwendet bewusst einen stabilen lokalen Demo-Modus ohne Firebase-Schlüssel. Dadurch lässt sie sich sofort bauen, testen und öffentlich vorführen. Ein echtes Backend kann später sauber ergänzt werden.

# Flutter-App auf GitHub Pages veröffentlichen

## 1. Neues Repository anlegen

1. Auf GitHub oben rechts auf **+** klicken.
2. **New repository** auswählen.
3. Zum Beispiel den Namen `whats-in-my-fridge` verwenden.
4. Repository auf **Public** stellen.
5. Kein zusätzliches README und keine zusätzliche `.gitignore` erzeugen.
6. Repository erstellen.

## 2. Projekt hochladen

Im Projektordner ein Terminal öffnen und folgende Befehle ausführen:

```bash
git init
git add .
git commit -m "Initial commit: What's in My Fridge"
git branch -M main
git remote add origin https://github.com/DEIN-BENUTZERNAME/whats-in-my-fridge.git
git push -u origin main
```

`DEIN-BENUTZERNAME` muss durch den eigenen GitHub-Namen ersetzt werden.

## 3. GitHub Pages aktivieren

1. Das Repository auf GitHub öffnen.
2. **Settings** öffnen.
3. Links auf **Pages** klicken.
4. Unter **Build and deployment** bei **Source** den Punkt **GitHub Actions** auswählen.

## 4. Veröffentlichung prüfen

1. Im Repository den Tab **Actions** öffnen.
2. Den Workflow **Deploy Flutter Web to GitHub Pages** auswählen.
3. Warten, bis Build und Deploy grün markiert sind.
4. Danach unter **Settings → Pages** die veröffentlichte Adresse öffnen.

Die Adresse sieht normalerweise so aus:

```text
https://DEIN-BENUTZERNAME.github.io/whats-in-my-fridge/
```

## Wichtig zu Firebase

GitHub Pages hostet nur die Flutter-Web-Oberfläche. Firebase Authentication, Firestore, Storage, Cloud Functions, KI und Push-Nachrichten werden nicht von GitHub Pages ausgeführt.

Ohne Firebase-Konfiguration startet dieses Projekt absichtlich im Demo-Modus. Für die echte Online-Funktionalität muss zusätzlich ein Firebase-Projekt eingerichtet und der Backendteil über Firebase bereitgestellt werden.

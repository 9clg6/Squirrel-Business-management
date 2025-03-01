# Squirrel, Business Manaegment
Application professionnelle de gestion de clients, commande en cours, archives et statistiques

# Générer les locales
fvm dart run easy_localization:generate --output-dir=lib/foundation/localizations --output-file=localizations.g.dart --format=json --source-dir=assets/translations && fvm dart run easy_localization:generate -f keys --output-dir=lib/foundation/localizations --output-file=locale_keys.g.dart --source-dir=assets/translations

# Générer l'installeur 
1) Build de Release : 
fvm flutter build macos --release --obfuscate --split-debug-info=/Users/x/Developer

2) cd /Users/x/Developer/aiir_gestion/build/macos/Build/Products/Release

3) Forcer signature
codesign --sign "Apple Development: filipzarago@gmail.com (HA4LLM4343)" Squirrel.app/ -f

4) Supprimer et créer un nouvel installeur à partir du build de Release
rm -rf Squirrel\ App.dmg ; appdmg config.json "Squirrel App.dmg"
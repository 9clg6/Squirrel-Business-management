# Squirrel, Business Manaegment
Application professionnelle de gestion de clients, commande en cours, archives et statistiques

# Générer les locales
fvm dart run easy_localization:generate --output-dir=lib/foundation/localizations --output-file=localizations.g.dart --format=json --source-dir=assets/translations && fvm dart run easy_localization:generate -f keys --output-dir=lib/foundation/localizations --output-file=locale_keys.g.dart --source-dir=assets/translations

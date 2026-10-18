# Fiabilisation d'une base patrimoniale de reseau d'assainissement

Rapport des anomalies d'un vrai reseau d'assainissement, en donnee ouverte, celui de Montpellier Mediterranee Metropole. Le projet reproduit la demarche d'un poste de technicien SIG reseaux, controler, fiabiliser et valoriser la donnee.

## La carte

La page `index.html` est un rapport interactif. Une carte des anomalies, le reseau en gris, le materiau manquant en orange, le diametre invalide en rouge, avec des indicateurs cles et une lecture. On coche et decoche les couches, on change de fond, on clique un point pour le detail.

## Le reseau

53 202 canalisations, 1 672 km, et 51 932 regards, en Lambert 93.

## La demarche

1. Integration des canalisations et des regards dans PostgreSQL et PostGIS, index spatial, longueur calculee.
2. Controle de topologie et de geometrie, geometries, doublons, raccordements aux regards.
3. Controle d'exhaustivite et de fiabilite par requetes SQL, 624 diametres invalides, 4 559 canalisations sans materiau, les cotes a moitie vides.
4. Valorisation, un indicateur de qualite, 90,8 pour cent du lineaire fiable, et des cartes thematiques.

## Les requetes SQL

Le dossier `scripts` contient les requetes PostGIS, dans l'ordre.

- `00_preparation.sql`, noms de colonnes apres import.
- `01_structuration.sql`, cle primaire, index spatial, longueur.
- `02_topologie.sql`, controles geometriques et topologiques.
- `03_qualite_attributs.sql`, exhaustivite et fiabilite.
- `04_indicateurs.sql`, indicateurs patrimoniaux.

## Outils

PostgreSQL, PostGIS, SQL, Python avec GeoPandas, QGIS.

## Donnee

Montpellier Mediterranee Metropole, open data, licence ODbL.

## Auteur

Victorine Maximilienne Djetcheu Toko, geomaticienne.
Portfolio, https://portfolio-victorine-djetcheu.netlify.app

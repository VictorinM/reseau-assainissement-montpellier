-- 00_preparation.sql
-- A lancer UNE FOIS, juste apres l'import des deux shapefiles dans PostGIS.
-- Le format shapefile raccourcit les noms de colonnes a 10 caracteres.
-- Ce script leur redonne des noms clairs, pour que les scripts 01 a 04 marchent tels quels.
-- Si une colonne a deja le bon nom, la ligne renvoie une erreur sans gravite, on continue.

-- Canalisations
ALTER TABLE canalisation RENAME COLUMN materiau_l TO materiau;
ALTER TABLE canalisation RENAME COLUMN modecirc_l TO mode_circulation;
ALTER TABLE canalisation RENAME COLUMN typereseau TO type_reseau;
ALTER TABLE canalisation RENAME COLUMN forme_libe TO forme;

-- Regards
ALTER TABLE regard RENAME COLUMN materiau_l TO materiau;
ALTER TABLE regard RENAME COLUMN typeregard TO type_regard;

-- Verifier que la colonne geometrie s'appelle bien geom.
-- Si elle s'appelle geometry, decommentez les deux lignes ci-dessous.
-- ALTER TABLE canalisation RENAME COLUMN geometry TO geom;
-- ALTER TABLE regard RENAME COLUMN geometry TO geom;

-- Verifier le systeme de coordonnees, on attend 2154 (Lambert 93).
SELECT DISTINCT ST_SRID(geom) FROM canalisation;

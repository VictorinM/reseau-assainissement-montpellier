-- 01_structuration.sql
-- Projet : fiabilisation d'une base patrimoniale de reseau d'assainissement
-- Donnee : Montpellier Mediterranee Metropole, open data ODbL
-- Objet : preparer la base, cle primaire, index spatial, longueur calculee
-- SGBD : PostgreSQL / PostGIS, geometries en Lambert 93 (EPSG 2154)

-- Cle primaire technique
ALTER TABLE canalisation ADD COLUMN IF NOT EXISTS gid serial PRIMARY KEY;
ALTER TABLE regard       ADD COLUMN IF NOT EXISTS gid serial PRIMARY KEY;

-- Index spatiaux, indispensables pour les controles de topologie
CREATE INDEX IF NOT EXISTS idx_canalisation_geom ON canalisation USING gist (geom);
CREATE INDEX IF NOT EXISTS idx_regard_geom       ON regard       USING gist (geom);

-- Longueur reelle de chaque troncon, en metres
ALTER TABLE canalisation ADD COLUMN IF NOT EXISTS longueur_m numeric;
UPDATE canalisation SET longueur_m = round(ST_Length(geom)::numeric, 2);

-- Controle du systeme de coordonnees
SELECT DISTINCT ST_SRID(geom) AS srid FROM canalisation;

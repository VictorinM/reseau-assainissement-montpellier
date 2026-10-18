-- 02_topologie.sql
-- Controles de coherence geometrique et topologique du reseau
-- Objet : detecter ce qui empeche le reseau de se tenir

-- 1. Geometries invalides
SELECT count(*) AS geometries_invalides
FROM canalisation
WHERE NOT ST_IsValid(geom);

-- 2. Troncons de longueur nulle ou quasi nulle (moins de 10 cm)
SELECT count(*) AS troncons_longueur_nulle
FROM canalisation
WHERE ST_Length(geom) < 0.1;

-- 3. Doublons geometriques stricts
SELECT count(*) AS doublons_geometriques
FROM (
  SELECT ST_AsBinary(geom) AS g, count(*) AS n
  FROM canalisation
  GROUP BY ST_AsBinary(geom)
  HAVING count(*) > 1
) d;

-- 4. Extremites de canalisation non raccordees a un regard
--    On extrait les deux extremites de chaque troncon, et on cherche
--    s'il existe un regard a moins de 1 metre. Sinon, extremite isolee.
WITH extremites AS (
  SELECT gid, ST_StartPoint(ST_LineMerge(geom)) AS pt FROM canalisation
  WHERE ST_GeometryType(ST_LineMerge(geom)) = 'ST_LineString'
  UNION ALL
  SELECT gid, ST_EndPoint(ST_LineMerge(geom)) AS pt FROM canalisation
  WHERE ST_GeometryType(ST_LineMerge(geom)) = 'ST_LineString'
)
SELECT count(*) AS extremites_sans_regard
FROM extremites e
WHERE NOT EXISTS (
  SELECT 1 FROM regard r
  WHERE ST_DWithin(e.pt, r.geom, 1.0)
);

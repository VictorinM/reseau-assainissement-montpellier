-- 04_indicateurs.sql
-- Valorisation, indicateurs patrimoniaux du reseau

-- 1. Lineaire total du reseau, en kilometres
SELECT round(sum(longueur_m)/1000.0, 1) AS lineaire_total_km FROM canalisation;

-- 2. Lineaire par type de reseau
SELECT coalesce(type_reseau,'Non renseigne') AS type_reseau,
       round(sum(longueur_m)/1000.0,1) AS km,
       count(*) AS nb_troncons
FROM canalisation GROUP BY 1 ORDER BY km DESC;

-- 3. Lineaire par materiau, principaux
SELECT coalesce(materiau,'Non renseigne') AS materiau,
       round(sum(longueur_m)/1000.0,1) AS km
FROM canalisation GROUP BY 1 ORDER BY km DESC LIMIT 10;

-- 4. Repartition par classe de diametre
SELECT CASE
         WHEN diametre IS NULL OR diametre <= 0 THEN 'inconnu ou invalide'
         WHEN diametre < 200  THEN 'moins de 200 mm'
         WHEN diametre < 400  THEN '200 a 400 mm'
         WHEN diametre < 800  THEN '400 a 800 mm'
         ELSE '800 mm et plus'
       END AS classe_diametre,
       round(sum(longueur_m)/1000.0,1) AS km,
       count(*) AS nb
FROM canalisation GROUP BY 1 ORDER BY km DESC;

-- 5. Indicateur de qualite patrimoniale
--    part du lineaire correctement renseigne, materiau present et diametre valide
SELECT round(100.0 * sum(longueur_m) FILTER (
         WHERE materiau IS NOT NULL AND diametre IS NOT NULL AND diametre > 0
       ) / sum(longueur_m), 1) AS pct_lineaire_fiable
FROM canalisation;

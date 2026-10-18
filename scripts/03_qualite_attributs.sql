-- 03_qualite_attributs.sql
-- Controle d'exhaustivite et de fiabilite des attributs
-- Exhaustivite : est-ce que tout est renseigne
-- Fiabilite : est-ce que ce qui est renseigne est credible

-- A. EXHAUSTIVITE, taux de remplissage par champ, canalisations
SELECT
  count(*) AS total,
  round(100.0*count(materiau)        /count(*),1) AS pct_materiau,
  round(100.0*count(diametre)        /count(*),1) AS pct_diametre,
  round(100.0*count(type_reseau)     /count(*),1) AS pct_type_reseau,
  round(100.0*count(mode_circulation)/count(*),1) AS pct_mode_circ,
  round(100.0*count(zamont)          /count(*),1) AS pct_cote_amont,
  round(100.0*count(zaval)           /count(*),1) AS pct_cote_aval,
  round(100.0*count(forme)           /count(*),1) AS pct_forme
FROM canalisation;

-- B. FIABILITE, valeurs aberrantes ou incoherentes, canalisations
SELECT
  count(*) FILTER (WHERE diametre IS NULL OR diametre <= 0) AS diametre_nul_ou_zero,
  count(*) FILTER (WHERE diametre > 2000)                   AS diametre_tres_eleve,
  count(*) FILTER (WHERE materiau IS NULL)                  AS materiau_manquant,
  count(*) FILTER (WHERE type_reseau IS NULL)               AS type_manquant,
  count(*) FILTER (WHERE materiau ILIKE '%inconnu%'
                      OR materiau ILIKE '%indetermin%')     AS materiau_indetermine
FROM canalisation;

-- C. EXHAUSTIVITE sur les regards
SELECT
  count(*) AS total,
  round(100.0*count(type_regard)/count(*),1) AS pct_type,
  round(100.0*count(diametre)   /count(*),1) AS pct_diametre,
  round(100.0*count(materiau)   /count(*),1) AS pct_materiau,
  round(100.0*count(ztn)        /count(*),1) AS pct_cote_terrain,
  round(100.0*count(zr)         /count(*),1) AS pct_cote_radier
FROM regard;

-- D. Liste de controle, les 20 troncons a corriger en priorite
--    diametre faux et aucun materiau, ce sont les plus urgents
SELECT idcana, diametre, materiau, type_reseau, longueur_m
FROM canalisation
WHERE (diametre IS NULL OR diametre <= 0) AND materiau IS NULL
ORDER BY longueur_m DESC
LIMIT 20;

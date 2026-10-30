CREATE SCHEMA IF NOT EXISTS compras_estado.landing;

CREATE OR REPLACE VIEW compras_estado.landing.adjudicaciones AS
SELECT *
FROM read_files(
  '/Volumes/compras_estado/landing/raw/Adjudicaciones.csv',
  format => 'csv',
  header => true,
  inferColumnTypes => false,
  schemaEvolutionMode => 'none'
);

CREATE OR REPLACE VIEW compras_estado.landing.convocatorias AS
SELECT *
FROM read_files(
  '/Volumes/compras_estado/landing/raw/Convocatorias.csv',
  format => 'csv',
  header => true,
  inferColumnTypes => false,
  schemaEvolutionMode => 'none'
);

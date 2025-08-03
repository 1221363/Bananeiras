-- View: Valor Aplicado por Terreno
CREATE OR REPLACE VIEW ValorAplicadoPorTerreno AS
SELECT
    a.Terrenonome                         AS terreno,
    p.nome                               AS produto,
    EXTRACT(YEAR FROM a.dataAplicacao)    AS ano,
    a.Temporada                           AS temporada,
    SUM(a.quantidade) * 25                AS total_kg
FROM Aplicacao a
JOIN Produto p ON a.Produtonome = p.nome
GROUP BY a.Terrenonome, p.nome, EXTRACT(YEAR FROM a.dataAplicacao), a.Temporada
ORDER BY a.Terrenonome, p.nome;
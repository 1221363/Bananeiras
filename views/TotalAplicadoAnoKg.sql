-- View: Total Aplicado por Ano em KG
CREATE OR REPLACE VIEW TotalAplicadoAnoKg AS
SELECT
    tp.nome AS tipo_produto,
    EXTRACT(YEAR FROM a.dataAplicacao) AS ano,
    SUM(a.quantidade) * 25 AS total_kg
FROM Aplicacao a
JOIN Produto p ON a.Produtonome = p.nome
JOIN TipoProduto tp ON p.TipoProdutonome = tp.nome
GROUP BY tp.nome, EXTRACT(YEAR FROM a.dataAplicacao);
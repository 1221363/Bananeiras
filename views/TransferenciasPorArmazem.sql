CREATE OR REPLACE VIEW ValorAplicadoPorTerreno_Ano AS
SELECT
    a.Terrenonome         AS terreno,
    tp.nome               AS tipo_produto,
    SUM(a.quantidade) * 25 AS total_kg
FROM Aplicacao a
JOIN Produto p ON a.Produtonome = p.nome
JOIN TipoProduto tp ON p.TipoProdutonome = tp.nome
GROUP BY a.Terrenonome, tp.nome
ORDER BY a.Terrenonome, tp.nome;


-- Como usar
DELETE FROM ParamAno;
INSERT INTO ParamAno VALUES (2025);
SELECT 'Ano: ' || ano AS info
FROM ParamAno;
SELECT * FROM ValorAplicadoPorTerreno_Ano;


-- View: Stock por Produto e Armazém
CREATE OR REPLACE VIEW StockPorProdutoArmazem AS
SELECT
    s.Armazemnome       AS armazem,
    s.Produtonome       AS produto,
    tp.nome             AS tipo_produto,
    s.quantidade        AS quantidade
FROM Stock s
JOIN Produto p ON s.Produtonome = p.nome
JOIN TipoProduto tp ON p.TipoProdutonome = tp.nome
ORDER BY s.Armazemnome, tp.nome, s.Produtonome;

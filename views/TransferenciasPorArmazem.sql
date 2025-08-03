-- View: Transferencias por Armazém
CREATE OR REPLACE VIEW TransferenciasPorArmazem AS
SELECT 
    t.armazemnome AS armazem,
    t.produtonome AS produto,
    t.quantidade AS quantidade,
    t.datatransferencia AS data
FROM Transferencia t
GROUP BY t.armazemnome, t.produtonome, t.quantidade, t.datatransferencia
ORDER BY t.datatransferencia;

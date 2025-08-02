CREATE OR REPLACE PROCEDURE InserirCompra(
    p_produtonome TEXT,
    p_quantidade  NUMERIC,
    p_data        DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_dummy         INTEGER;
    v_stock_casa    NUMERIC := 0;
BEGIN
    -- Verificar se o produto existe
    PERFORM 1 FROM Produto
    WHERE REPLACE(UPPER(nome), ' ', '') = REPLACE(UPPER(p_produtonome), ' ', '');
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Produto não encontrado.' USING ERRCODE = '22001';
    END IF;

    -- Verificar se o armazém "Casa" existe
    PERFORM 1 FROM Armazem
    WHERE REPLACE(UPPER(nome), ' ', '') = REPLACE(UPPER('Casa'), ' ', '');
    IF NOT FOUND THEN
        RAISE EXCEPTION 'O armazém "Casa" não existe.' USING ERRCODE = '22002';
    END IF;

    -- Atualizar ou inserir stock no armazém "Casa"
    SELECT quantidade INTO v_stock_casa
    FROM Stock
    WHERE REPLACE(UPPER(Armazemnome), ' ', '') = REPLACE(UPPER('Casa'), ' ', '')
      AND REPLACE(UPPER(Produtonome), ' ', '') = REPLACE(UPPER(p_produtonome), ' ', '')
    LIMIT 1;

    IF FOUND THEN
        UPDATE Stock
        SET quantidade = v_stock_casa + p_quantidade
        WHERE REPLACE(UPPER(Armazemnome), ' ', '') = REPLACE(UPPER('Casa'), ' ', '')
          AND REPLACE(UPPER(Produtonome), ' ', '') = REPLACE(UPPER(p_produtonome), ' ', '');
    ELSE
        INSERT INTO Stock (Armazemnome, Produtonome, quantidade)
        VALUES ('Casa', p_produtonome, p_quantidade);
    END IF;

    -- Inserir registo na tabela Compra
    INSERT INTO Compra (
        Produtonome, quantidade, dataCompra
    ) VALUES (
        p_produtonome, p_quantidade, p_data
    );
END;
$$;

-- Como usar:
-- CALL InserirCompra('Nitrofoska 14', 40, '2025-07-15');

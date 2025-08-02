CREATE OR REPLACE PROCEDURE InserirStock(
    IN p_armazem TEXT,
    IN p_produtonome TEXT,
    IN p_quantidade NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_dummy INT;
    v_existente NUMERIC;
BEGIN
    -- Verificar se o produto existe
    PERFORM 1 FROM Produto WHERE UPPER(nome) = UPPER(p_produtonome);
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Produto não encontrado.';
    END IF;

    -- Verificar se o armazém existe
    PERFORM 1 FROM Armazem WHERE UPPER(nome) = UPPER(p_armazem);
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Armazém não encontrado.';
    END IF;

    -- Atualizar ou inserir stock
    SELECT quantidade INTO v_existente
    FROM Stock
    WHERE UPPER(Armazemnome) = UPPER(p_armazem)
      AND UPPER(Produtonome) = UPPER(p_produtonome);

    IF FOUND THEN
        UPDATE Stock
        SET quantidade = v_existente + p_quantidade
        WHERE UPPER(Armazemnome) = UPPER(p_armazem)
          AND UPPER(Produtonome) = UPPER(p_produtonome);
    ELSE
        INSERT INTO Stock (Armazemnome, Produtonome, quantidade)
        VALUES (p_armazem, p_produtonome, p_quantidade);
    END IF;
END;
$$;

-- Como usar:
-- CALL InserirStock('Casa', 'PatentKali', 100);

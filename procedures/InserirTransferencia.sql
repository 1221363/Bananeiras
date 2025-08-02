CREATE OR REPLACE PROCEDURE InserirTransferencia(
    IN p_armazem_destino TEXT,
    IN p_produtonome TEXT,
    IN p_quantidade NUMERIC,
    IN p_data DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_stock_casa NUMERIC;
    v_stock_destino NUMERIC;
BEGIN
    -- Verificar se o produto existe
    PERFORM 1 FROM Produto WHERE UPPER(nome) = UPPER(p_produtonome);
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Produto não encontrado.' USING ERRCODE = 'P0001';
    END IF;

    -- Verificar se o armazém destino existe
    PERFORM 1 FROM Armazem WHERE UPPER(nome) = UPPER(p_armazem_destino);
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Armazém de destino não existe.' USING ERRCODE = 'P0002';
    END IF;

    -- Verificar stock disponível em "Casa"
    SELECT quantidade INTO v_stock_casa
    FROM Stock
    WHERE UPPER(Armazemnome) = 'CASA' AND UPPER(Produtonome) = UPPER(p_produtonome);

    IF v_stock_casa < p_quantidade THEN
        RAISE EXCEPTION 'Stock insuficiente no armazém "Casa".' USING ERRCODE = 'P0003';
    END IF;

    -- Atualizar stock de "Casa" (subtrair)
    UPDATE Stock
    SET quantidade = quantidade - p_quantidade
    WHERE UPPER(Armazemnome) = 'CASA' AND UPPER(Produtonome) = UPPER(p_produtonome);

    -- Atualizar ou criar stock no armazém destino
    SELECT quantidade INTO v_stock_destino
    FROM Stock
    WHERE UPPER(Armazemnome) = UPPER(p_armazem_destino) AND UPPER(Produtonome) = UPPER(p_produtonome);

    IF FOUND THEN
        UPDATE Stock
        SET quantidade = v_stock_destino + p_quantidade
        WHERE UPPER(Armazemnome) = UPPER(p_armazem_destino) AND UPPER(Produtonome) = UPPER(p_produtonome);
    ELSE
        INSERT INTO Stock (Armazemnome, Produtonome, quantidade)
        VALUES (p_armazem_destino, p_produtonome, p_quantidade);
    END IF;

    -- Inserir registo na tabela Transferencia
    INSERT INTO Transferencia (Armazemnome, Produtonome, quantidade, dataTransferencia)
    VALUES (p_armazem_destino, p_produtonome, p_quantidade, p_data);
END;
$$;

-- Como usar:
-- CALL InserirTransferencia('Arm. Qb', 'Entec Evo 24', 0.6, '2025-07-15');

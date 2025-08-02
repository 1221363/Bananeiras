CREATE OR REPLACE PROCEDURE InserirAplicacao(
    p_temporada    TEXT,
    p_terrenonome  TEXT,
    p_produtonome  TEXT,
    p_data         DATE,
    p_stock_final  NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_armazem_nome  TEXT;
    v_stock_inicial NUMERIC := 0;
    v_aplicado      NUMERIC;
    v_produtor      TEXT;
BEGIN
    -- Verificar se o produto existe
    PERFORM 1 FROM Produto
    WHERE REPLACE(UPPER(nome), ' ', '') = REPLACE(UPPER(p_produtonome), ' ', '');
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Produto não encontrado.';
    END IF;

    -- Obter armazém associado ao terreno
    SELECT Armazemnome INTO v_armazem_nome
    FROM Terreno
    WHERE REPLACE(UPPER(nome), ' ', '') = REPLACE(UPPER(p_terrenonome), ' ', '');

    -- Verificar se o armazém existe
    PERFORM 1 FROM Armazem
    WHERE REPLACE(UPPER(nome), ' ', '') = REPLACE(UPPER(v_armazem_nome), ' ', '');
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Armazém associado ao terreno não existe.';
    END IF;

    -- Obter stock inicial (se existir)
    BEGIN
        SELECT quantidade INTO v_stock_inicial
        FROM Stock
        WHERE REPLACE(UPPER(Armazemnome), ' ', '') = REPLACE(UPPER(v_armazem_nome), ' ', '')
          AND REPLACE(UPPER(Produtonome), ' ', '') = REPLACE(UPPER(p_produtonome), ' ', '');
    EXCEPTION WHEN NO_DATA_FOUND THEN
        v_stock_inicial := 0;
    END;

    -- Calcular aplicado
    v_aplicado := v_stock_inicial - p_stock_final;

    -- Determinar produtor
    IF REPLACE(UPPER(p_terrenonome), ' ', '') IN ('LEDO', 'T.TIOS', 'QC+QA') THEN
        v_produtor := 'MF';
    ELSE
        v_produtor := 'AF';
    END IF;

    -- Inserir aplicação
    INSERT INTO Aplicacao (
        Temporada, Terrenonome, Produtonome, dataAplicacao, quantidade, stock_final, produtor
    ) VALUES (
        p_temporada, p_terrenonome, p_produtonome, p_data, v_aplicado, p_stock_final, v_produtor
    );
END;
$$;

-- Exemplo de chamada:
-- CALL InserirAplicacao('Julho 2025', 'Ledo', 'Entec Evo 24', '2025-07-07', 15.6);

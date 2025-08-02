-- Inserir stock
CALL InserirStock('Casa', 'Entec Evo 24', 19);
CALL InserirStock('Casa', 'Nitrofoska 14', 10.3);
CALL InserirStock('Casa', 'Patentkali', 20.6);
CALL InserirStock('Arm. C. Tia', 'Entec Evo 24', 0.8);
CALL InserirStock('Arm. C. Tia', 'NovaTec Premium', 1.7);
CALL InserirStock('Arm. C. Tia', 'Patentkali', 0.4);
CALL InserirStock('Arm. Qc', 'Entec Evo 24', 0.05);
CALL InserirStock('Arm. Qc', 'NovaTec Premium', 4.4);
CALL InserirStock('Arm. Qc', 'Nitrofoska 14', 3);
CALL InserirStock('Arm. Qc', 'Patentkali', 2.6);

-- Inserir aplicações
CALL InserirAplicacao('Julho 2025', 'Ledo', 'Entec Evo 24', '2025-07-07', 17.4);
CALL InserirAplicacao('Julho 2025', 'T.Tios', 'Entec Evo 24', '2025-07-07', 15.6);
CALL InserirAplicacao('Julho 2025', 'Ledo', 'Nitrofoska 14', '2025-07-07', 6.55);
CALL InserirAplicacao('Julho 2025', 'T.Tios', 'Nitrofoska 14', '2025-07-07', 1.4);
CALL InserirAplicacao('Julho 2025', 'Ledo', 'Patentkali', '2025-07-07', 18.8);
CALL InserirAplicacao('Julho 2025', 'T.Tios', 'Patentkali', '2025-07-07', 16.9);
CALL InserirAplicacao('Julho 2025', 'C.Tia', 'Entec Evo 24', '2025-07-11', 0.3);
CALL InserirAplicacao('Julho 2025', 'C.Tia', 'NovaTec Premium', '2025-07-11', 0.6);
CALL InserirAplicacao('Julho 2025', 'C.Tia', 'Patentkali', '2025-07-11', 0.05);
CALL InserirAplicacao('Julho 2025', 'Qc+Qa', 'NovaTec Premium', '2025-07-14', 0);
CALL InserirAplicacao('Julho 2025', 'Qc+Qa', 'Nitrofoska 14', '2025-07-14', 1);
CALL InserirAplicacao('Julho 2025', 'Qc+Qa', 'Patentkali', '2025-07-14', 0.6);

-- Inserir compra
CALL InserirCompra('Nitrofoska Perfect', 40, '2025-07-15');

-- Inserções de stock adicionais
CALL InserirStock('Arm. Qb', 'Entec Evo 24', 2.4);
CALL InserirStock('Arm. Qb', 'NovaTec Premium', 3.1);
CALL InserirStock('Arm. Qb', 'Nitrofoska 14', 1);
CALL InserirStock('Arm. Qb', 'Nitrofoska Perfect', 0);
CALL InserirStock('Arm. Qb', 'Patentkali', 1.8);
CALL InserirStock('Arm. Fajã', 'NovaTec Premium', 1);
CALL InserirStock('Arm. Fajã', 'Nitrofoska Perfect', 0);
CALL InserirStock('Arm. Fajã', 'Patentkali', 0.8);

-- Inserir transferências
CALL InserirTransferencia('Arm. Qb', 'Entec Evo 24', 0.6, '2025-07-15');
CALL InserirTransferencia('Arm. Qb', 'Nitrofoska 14', 1.4, '2025-07-15');
CALL InserirTransferencia('Arm. Qb', 'Nitrofoska Perfect', 6, '2025-07-15');
CALL InserirTransferencia('Arm. Qb', 'Patentkali', 1.9, '2025-07-15');
CALL InserirTransferencia('Arm. Fajã', 'Nitrofoska Perfect', 3, '2025-07-16');
CALL InserirTransferencia('Arm. Fajã', 'Patentkali', 1, '2025-07-16');

-- Inserir Aplicações
CALL InserirAplicacao('Julho 2025', 'T+Qb', 'Entec Evo 24', '2025-07-15', 2);
CALL InserirAplicacao('Julho 2025', 'T+Qb', 'NovaTec Premium', '2025-07-15', 0);
CALL InserirAplicacao('Julho 2025', 'T+Qb', 'Nitrofoska 14', '2025-07-15', 0);
CALL InserirAplicacao('Julho 2025', 'T+Qb', 'Nitrofoska Perfect', '2025-07-15', 4.8);
CALL InserirAplicacao('Julho 2025', 'T+Qb', 'Patentkali', '2025-07-15', 2.2);
CALL InserirAplicacao('Julho 2025', 'Fajã', 'NovaTec Premium', '2025-07-16', 0);
CALL InserirAplicacao('Julho 2025', 'Fajã', 'Nitrofoska Perfect', '2025-07-16', 1.7);
CALL InserirAplicacao('Julho 2025', 'Fajã', 'Patentkali', '2025-07-16', 1.6);

-- Inserir Transferências
CALL InserirTransferencia('Arm. Fajã', 'Nitrofoska Perfect', 3, '2025-07-29');
CALL InserirTransferencia('Arm. Fajã', 'Entec Evo 24', 1, '2025-07-29');

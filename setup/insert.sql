-- Armazéns
INSERT INTO Armazem(nome) values ('Casa');
INSERT INTO Armazem(nome) values ('Arm. Qc');
INSERT INTO Armazem(nome) values ('Arm. Qb');
INSERT INTO Armazem(nome) values ('Arm. C. Tia');
INSERT INTO Armazem(nome) values ('Arm. Fajã');

-- Terrenos
INSERT INTO Terreno(nome, Armazemnome) values ('Ledo', 'Casa');
INSERT INTO Terreno(nome, Armazemnome) values ('Qc+Qa', 'Arm. Qc');
INSERT INTO Terreno(nome, Armazemnome) values ('T+Qb', 'Arm. Qb');
INSERT INTO Terreno(nome, Armazemnome) values ('T.Tios', 'Casa');
INSERT INTO Terreno(nome, Armazemnome) values ('C.Tia', 'Arm. C. Tia');
INSERT INTO Terreno(nome, Armazemnome) values ('Fajã', 'Arm. Fajã');

-- Tipo de produtos
INSERT INTO TipoProduto(nome) values ('Azoto');
INSERT INTO TipoProduto(nome) values ('NPK');
INSERT INTO TipoProduto(nome) values ('Potássio');

-- Produtos
INSERT INTO Produto(TipoProdutonome, nome) values ('Azoto', 'Entec 26');
INSERT INTO Produto(TipoProdutonome, nome) values ('Azoto', 'Entec Evo 24');
INSERT INTO Produto(TipoProdutonome, nome) values ('NPK', 'NovaTec Premium');
INSERT INTO Produto(TipoProdutonome, nome) values ('NPK', 'Nitrofoska 14');
INSERT INTO Produto(TipoProdutonome, nome) values ('Potássio', 'Patentkali');
INSERT INTO Produto(TipoProdutonome, nome) values ('NPK', 'Nitrofoska Perfect');

-- Produtores
INSERT INTO Produtor(nome) values ('MF');
INSERT INTO Produtor(nome) values ('AF');


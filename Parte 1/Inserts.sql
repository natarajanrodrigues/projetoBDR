-- caso precise acertar o formato da data usar: 
-- SET DATESTYLE TO 'SQL, DMY';

--TABLE PESSOA Inserts
INSERT INTO PESSOA VALUES('11111111111','111111111','Pedro','M','26/12/1996','Paraíba','Cajazeiras','Jardim Oasis','Jose Dantas Nobre',371);
INSERT INTO PESSOA VALUES('22222222222','222222222','João','M','25/07/1998','Paraíba','Cajazeiras','Pôr do Sol','Padre Rolim',222);
INSERT INTO PESSOA VALUES('33333333333','333333333','Francisco','M','22/05/1983','Paraíba','João Pessoa','Bancários','Serafim Bernardo',415);
INSERT INTO PESSOA VALUES('44444444444','444444444','Antônia','F','12/02/1972','Paraíba','João Pessoa','Juazeirinho','Cruzeiro Olinda',231);
INSERT INTO PESSOA VALUES('55555555555','555555555','Maria','F','08/05/1968','Ceará','Fortaleza','Cormecial','Av. Principal',1078);
INSERT INTO PESSOA VALUES('66666666666','666666666','Lucas','M','14/09/1991','Rio Grande do Norte','Natal','Lagoa Nova','	',133);
INSERT INTO PESSOA VALUES('77777777777','777777777','Fernanda','F','02/02/1972','Paraíba','João Pessoa','Bessa','Avenida Presidente Afonso Pena',791);
INSERT INTO PESSOA VALUES('88888888888','123456789','Natarajan','M','28/03/1984','Paraíba','Sousa','Centro','Rua Cel José Gomes de Sá',7);
INSERT INTO PESSOA VALUES('99999999999','909090909','Victor','M','08/05/1963','Paraíba','Cajazeiras','Centro','Rua Cel Antonio Silva',623);
INSERT INTO PESSOA VALUES('12121212121','121212121','Bruna','F','15/11/2003','Paraíba','Cajazeiras','Centro','Rua Hortelina de Sousa Lira',204);
INSERT INTO PESSOA VALUES('13131313131','131313131','Amanda','F','14/07/1996','Rio Grande do Norte','Caicó','Centro','Rua Serafim Bernardo',352);
INSERT INTO PESSOA VALUES('14141414141','141414141','José','M','20/02/1991','Pernambuco','Olinda','Centro','Av. Cel Batista',801);
INSERT INTO PESSOA VALUES('15151515151','151515151','Carlos','M','02/04/1995','Alagoas','Maceió','Santos','Av. Manel de Sousa',922);
INSERT INTO PESSOA VALUES('16161616161','161616161','Augusto','M','25/02/1992','Rio Grande do Norte','Caicó','Centro','Rua José Nilson de sá',406);
INSERT INTO PESSOA VALUES('17171717171','171717171','Caroline','F','23/02/2003','Rio Grande do Norte','Natal','Lagoa Nova','Av. Jardim Oásis',154);
INSERT INTO PESSOA VALUES('18181818181','181818181','Nicole','F','05/09/1985','São Paulo','Santos','Orla','Av. Cel Santos de Sá',829);
INSERT INTO PESSOA VALUES('40540540540','343434','Geny','F','18/10/1954','Paraíba','Sousa','Gato Preto','R. Cel José Gomes de Sá',7);


--TABLE TELEFONE_PESSOA Inserts
INSERT INTO TELEFONE_PESSOA VALUES('11111111111','(83)99365-5545');
INSERT INTO TELEFONE_PESSOA VALUES('11111111111','(83)99675-0936');
INSERT INTO TELEFONE_PESSOA VALUES('22222222222','(83)99655-4432');
INSERT INTO TELEFONE_PESSOA VALUES('22222222222','(83)99938-9930');
INSERT INTO TELEFONE_PESSOA VALUES('33333333333','(83)99105-3367');
INSERT INTO TELEFONE_PESSOA VALUES('44444444444','(83)99243-9987');
INSERT INTO TELEFONE_PESSOA VALUES('55555555555','(85)99103-5525');
INSERT INTO TELEFONE_PESSOA VALUES('66666666666','(84)99650-9112');
INSERT INTO TELEFONE_PESSOA VALUES('77777777777','(83)99361-6882');
INSERT INTO TELEFONE_PESSOA VALUES('99999999999','(83)99354-8893');
INSERT INTO TELEFONE_PESSOA VALUES('88888888888','(83)99302-3149');
INSERT INTO TELEFONE_PESSOA VALUES('12121212121','(83)99102-8196');
INSERT INTO TELEFONE_PESSOA VALUES('13131313131','(84)99654-9963');
INSERT INTO TELEFONE_PESSOA VALUES('13131313131','(83)99361-8867');
INSERT INTO TELEFONE_PESSOA VALUES('14141414141','(81)99455-9163');
INSERT INTO TELEFONE_PESSOA VALUES('15151515151','(82)99651-8255');
INSERT INTO TELEFONE_PESSOA VALUES('16161616161','(84)99934-0264');
INSERT INTO TELEFONE_PESSOA VALUES('17171717171','(84)99931-9067');
INSERT INTO TELEFONE_PESSOA VALUES('18181818181','(13)99933-5643');


--TABLE CLIENTE Inserts
INSERT INTO CLIENTE(cpf_pessoa,email) VALUES('33333333333','francisco@gmail.com');
INSERT INTO CLIENTE(cpf_pessoa,email) VALUES('22222222222','joao@hotmail.com');
INSERT INTO CLIENTE(cpf_pessoa,email) VALUES('14141414141','jose_farias@hotmail.com');
INSERT INTO CLIENTE(cpf_pessoa,email) VALUES('13131313131','Amanda_araujo@hotmail.com');
INSERT INTO CLIENTE(cpf_pessoa,email) VALUES('11111111111','pedro@gmail.com');
INSERT INTO CLIENTE(cpf_pessoa,email) VALUES('88888888888','natarajan@gmail.com');
INSERT INTO CLIENTE(cpf_pessoa,email) VALUES('18181818181','nicole@gmail.com');

--TABLE FUNCIONARIO Inserts
INSERT INTO FUNCIONARIO(matricula, cpf_pessoa,salario_base,comissao,salario_familia) VALUES('F0001', '44444444444',1200,1.10,1400);
INSERT INTO FUNCIONARIO(matricula, cpf_pessoa,salario_base,comissao,salario_familia) VALUES('F0002','99999999999',1200,1.10,1300);
INSERT INTO FUNCIONARIO(matricula, cpf_pessoa,salario_base,comissao,salario_familia) VALUES('F0003','66666666666',1200,1.10,1200);
INSERT INTO FUNCIONARIO(matricula, cpf_pessoa,salario_base,comissao,salario_familia) VALUES('F0004','55555555555',1200,1.10,1300);
INSERT INTO FUNCIONARIO(matricula, cpf_pessoa,salario_base,comissao,salario_familia) VALUES('F0005','77777777777',1200,1.10,1300);

--TABLE DEPENDENTE Inserts
INSERT INTO DEPENDENTE(cpf_dependente, matricula_funcionario, parentesco) VALUES('12121212121', 'F0001', 'Filho(a)');
INSERT INTO DEPENDENTE(cpf_dependente, matricula_funcionario, parentesco) VALUES('15151515151', 'F0001', 'Filho(a)');
INSERT INTO DEPENDENTE(cpf_dependente, matricula_funcionario, parentesco) VALUES('16161616161', 'F0005', 'Filho(a)');
INSERT INTO DEPENDENTE(cpf_dependente, matricula_funcionario, parentesco) VALUES('18181818181', 'F0005', 'Companheiro(a)');
INSERT INTO DEPENDENTE(cpf_dependente, matricula_funcionario, parentesco) VALUES('17171717171', 'F0002', 'Neto(a)');

--TABLE DEPARTAMENTO Inserts
INSERT INTO DEPARTAMENTO(id, descricao,nome) VALUES('DP001','Tudo relacionado a informática','informática e tablets');
INSERT INTO DEPARTAMENTO(id, descricao,nome) VALUES('DP002','Todos os celulares e telefones que você deseja encontrar','Celulares e telefonia fixa');
INSERT INTO DEPARTAMENTO(id, descricao,nome) VALUES('DP003','Tudo relacionado a eletrodomésticos','Eletrodomésticos');
INSERT INTO DEPARTAMENTO(id, descricao,nome) VALUES('DP004','Televisões, home theaters, DVDs, Blurays','Televisões, audio e home theaters');
INSERT INTO DEPARTAMENTO(id, descricao,nome) VALUES('DP005','Camas, Sofás, mesas, cozinha, etc','Móveis e Decoração');

--TABLE FORNECEDOR Inserts
INSERT INTO FORNECEDOR VALUES('62.288.584/0001-08','Motorola','Lucro real','São Paulo','São Paulo','Vila Olímpia','Rua Paes Leme',525);
INSERT INTO FORNECEDOR VALUES('09.509.531/0009-36','ASUS','Lucro real','São Paulo','São Paulo','CAJAMAR','Via de Acesso Norte KM 38',420);
INSERT INTO FORNECEDOR VALUES('62.058.318/0007-76','Consul','Lucro real','São Paulo','São Paulo','Jardim Santa Emília','Rua Olympia Semeraro',675);
INSERT INTO FORNECEDOR VALUES('61.086.336/0004-56','Philips','Lucro real','São Paulo','São Paulo','MAUÁ','Av. Comendador wolthers',500);
INSERT INTO FORNECEDOR VALUES('02.895.152/0001-25','Ortobom','Lucro real','Rio de Janeiro','Nova Iguaçu','Vila Três Corações','Av. Henrique Duque Estrada Mayer',1701);
INSERT INTO FORNECEDOR VALUES('00.623.904/0001-73','Apple Computer Brasil LTDA','Lucro real','São Paulo','São Paulo','ITAIM BIBI','R LEOPOLDO COUTO MAGALHAES JUNIOR',700);
INSERT INTO FORNECEDOR VALUES('00.280.273/0007-22','SAMSUNG ELETRÔNICA DA AMAZÔNIA LTDA', 'Lucro real','Amazonas', 'Manaus', 'Distrito Industrial', 'Av. dos Oitis', 1460);

--TABLE TELEFONE-FORNECEDOR Inserts
INSERT INTO TELEFONE_FORNECEDOR VALUES('62.288.584/0001-08','4003-8859');
INSERT INTO TELEFONE_FORNECEDOR VALUES('09.509.531/0009-36','3003-0398');
INSERT INTO TELEFONE_FORNECEDOR VALUES('62.058.318/0007-76','3003-0777');
INSERT INTO TELEFONE_FORNECEDOR VALUES('61.086.336/0004-56','2121-0203');
INSERT INTO TELEFONE_FORNECEDOR VALUES('02.895.152/0001-25','2221-1436');
INSERT INTO TELEFONE_FORNECEDOR VALUES('00.623.904/0001-73','4004-1005');


--TABLE PRODUTO Inserts
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000001','DP002','00.623.904/0001-73','Apple iPhone 6s', 'iOS 64GB 1 chip', 6, 0.5, 4000);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000002','DP002','00.623.904/0001-73','Apple iPhone 6', 'iOS 32GB 1 chip', 8, 0.5, 3000);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000003','DP002','09.509.531/0009-36','Asus Zen Fone 2', '6G545WW Intel 2.3Ghz, Android 5.0, Tela Full HD 5.5´, 32Gb', 10, 0.5, 1300);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000004','DP002','62.288.584/0001-08','Motorola Moto G', '2a geracao c/ 2 chips Android', 15, 0.5, 700);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000005','DP001','62.288.584/0001-08','Motorola Tablet M10', '1gb RAM 32gb de memória processador 1.5GHz', 4, 0.4, 850);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000006','DP001','00.623.904/0001-73','Macbook Pro Mid 2015 13pol', '13" I5 2.7ghz 8gb 128ssd Mf839', 2, 0.7, 5800);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000007','DP001','09.509.531/0009-36','Notebook Asus X550LA-BRA-XX392H', 'Intel Core i5 8GB 500GB Tela LED 15.6" Windows 8.1 - Preto', 4, 0.5, 1979.10);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000008','DP003','62.058.318/0007-76','Geladeira/Refrigerador Consul', 'Duplex Cycle Defrost - 450L CRD49AB', 10, 0.3, 1583.12);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000009','DP003','62.058.318/0007-76','Micro-ondas Consul', 'Consul Mais CME20 20 Litros Preto/Azul com função Tostex', 20, 0.3, 299.90);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000010','DP004','61.086.336/0004-56','DVD Player Philips', 'DVD DVP2850X/78 - Progressive Scan Conexão USB', 18, 0.3, 139);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000011','DP003','61.086.336/0004-56','Liquidificador 8 Velocidades Philips', 'Liquidificador c/ Jarra DuraVita', 30, 0.3, 90);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000012','DP004','61.086.336/0004-56','Home Theater Philips', 'Home Theater Philips HTB5580X/78 5.1 Canais com Blu-Ray 3D', 5, 0.35,  1489.90);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000013','DP004','61.086.336/0004-56','TV LED 43pol Philips Full HD', '43PFG5000/78 Full HD Conv. Dig 2 HDMI 1 USB 120Hz', 10, 0.35,  1250);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000014','DP004','00.280.273/0007-22','TV LED 48pol Samsung HD', 'TV LED 48pol Samsung UN48H4200 HD com Conversor Digital', 10, 0.4,  1399);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000015','DP002','00.280.273/0007-22','Smartphone Samsung Galaxy S6', 'Samsung Galaxy S6 32GB 4G Câm. 16MP Selfie 5MP Tela 5.1', 8, 0.4,  2199);
INSERT INTO PRODUTO(id, id_departamento, cnpj_fornecedor, nome, descricao, estoque, imposto, preco) VALUES('P-000016','DP005','02.895.152/0001-25','Cama Box (Box + Colchão)', 'Cama Box (Box+Colchão)Casal Mola 138x188cm Ortobom Physical Silve', 5, 0.2,  799);


-- TABLE FORMA DE PAGAMENTO Inserts
INSERT INTO FORMA_PAGAMENTO VALUES (1, 'DINHEIRO À VISTA', 1);
INSERT INTO FORMA_PAGAMENTO VALUES (2, 'CARTÃO DE DÉBITO', 1);
INSERT INTO FORMA_PAGAMENTO VALUES (11, 'CARTÃO DE CRÉDITO 1X', 1);
INSERT INTO FORMA_PAGAMENTO VALUES (12, 'CARTÃO DE CRÉDITO 2X', 2);
INSERT INTO FORMA_PAGAMENTO VALUES (13, 'CARTÃO DE CRÉDITO 3X', 3);
INSERT INTO FORMA_PAGAMENTO VALUES (14, 'CARTÃO DE CRÉDITO 3X', 4);
INSERT INTO FORMA_PAGAMENTO VALUES (15, 'CARTÃO DE CRÉDITO 3X', 5);
INSERT INTO FORMA_PAGAMENTO VALUES (16, 'CARTÃO DE CRÉDITO 3X', 6);
INSERT INTO FORMA_PAGAMENTO VALUES (17, 'CARTÃO DE CRÉDITO 3X', 7);
INSERT INTO FORMA_PAGAMENTO VALUES (18, 'CARTÃO DE CRÉDITO 3X', 8);
INSERT INTO FORMA_PAGAMENTO VALUES (19, 'CARTÃO DE CRÉDITO 3X', 9);
INSERT INTO FORMA_PAGAMENTO VALUES (20, 'CARTÃO DE CRÉDITO 3X', 10);
INSERT INTO FORMA_PAGAMENTO VALUES (30, 'CREDIARIO APROVADO 3X', 3);
INSERT INTO FORMA_PAGAMENTO VALUES (40, 'CREDIARIO APROVADO 4X', 4);
INSERT INTO FORMA_PAGAMENTO VALUES (50, 'CREDIARIO APROVADO 5X', 5);
INSERT INTO FORMA_PAGAMENTO VALUES (60, 'CREDIARIO APROVADO 6X', 6);


INSERT INTO VENDA VALUES ('12/10/2015', '08:59', '18181818181', '77777777777', );

CREATE TABLE PESSOA(
	CPF VARCHAR(11) NOT NULL,
	RG VARCHAR(9) NOT NULL,
	NOME VARCHAR(40) NOT NULL,
	SEXO VARCHAR(1) NOT NULL,
	DATA_NASCIMENTO DATE NOT NULL,
	ESTADO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(50) NOT NULL,
	RUA VARCHAR(50) NOT NULL,
	NUMERO INT NOT NULL,
	PRIMARY KEY(CPF)
);

CREATE TABLE TELEFONE_PESSOA(
	CPF_PESSOA VARCHAR(11) NOT NULL,
	TELEFONE VARCHAR(14) NULL,
	FOREIGN KEY(CPF_PESSOA) REFERENCES PESSOA(CPF),
	PRIMARY KEY(CPF_PESSOA,TELEFONE)
);

CREATE TABLE CLIENTE(
	CPF_PESSOA VARCHAR(11) NOT NULL,
	EMAIL VARCHAR(50) UNIQUE NOT NULL,
	PONTUACAO INT DEFAULT 0,
	FOREIGN KEY(CPF_PESSOA) REFERENCES PESSOA(CPF),
	PRIMARY KEY(CPF_PESSOA)
);

CREATE TABLE FUNCIONARIO(
	CPF_PESSOA VARCHAR(11) NOT NULL,
	MATRICULA VARCHAR(10) UNIQUE NOT NULL,
	SALARIO_BASE DOUBLE PRECISION NOT NULL,
	SALARIO_FAMILIA DOUBLE PRECISION NOT NULL DEFAULT 0,
	FOREIGN KEY(CPF_PESSOA) REFERENCES PESSOA(CPF),
	PRIMARY KEY(CPF_PESSOA)
);

CREATE TABLE DEPENDENTE(
	CPF_DEPENDENTE VARCHAR(11) NOT NULL,
	MATRICULA_FUNCIONARIO VARCHAR(10) NOT NULL,
	IDADE INT,
	PARENTESCO VARCHAR(15) NOT NULL,
	FOREIGN KEY(CPF_DEPENDENTE) REFERENCES PESSOA(CPF),
	FOREIGN KEY(MATRICULA_FUNCIONARIO) REFERENCES FUNCIONARIO(MATRICULA),
	PRIMARY KEY(CPF_DEPENDENTE)
);

CREATE TABLE FORNECEDOR(
	CNPJ VARCHAR(20) NOT NULL,
	NOME VARCHAR(40) NOT NULL,
	REGIME_TRIBUTARIO VARCHAR(40) NOT NULL,
	ESTADO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(50) NOT NULL,
	RUA VARCHAR(50) NOT NULL,
	NUMERO INT NOT NULL,
	PRIMARY KEY(CNPJ)
);

CREATE TABLE TELEFONE_FORNECEDOR(
	CNPJ_FORNECEDOR VARCHAR(20) NOT NULL,
	TELEFONE VARCHAR(14) NOT NULL,
	FOREIGN KEY(CNPJ_FORNECEDOR) REFERENCES FORNECEDOR(CNPJ),
	PRIMARY KEY(CNPJ_FORNECEDOR,TELEFONE)
);

CREATE TABLE DEPARTAMENTO(
	ID VARCHAR(5) UNIQUE NOT NULL,
	NOME VARCHAR(40) NOT NULL,
	DESCRICAO VARCHAR(60) NOT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE PRODUTO(
	ID VARCHAR(10) NOT NULL,
	ID_DEPARTAMENTO VARCHAR(5) NOT NULL,
	CNPJ_FORNECEDOR VARCHAR(20) NOT NULL,
	NOME VARCHAR(40) NOT NULL,
	DESCRICAO VARCHAR(80) NOT NULL,
	ESTOQUE INT NOT NULL,
	IMPOSTO FLOAT(3) NOT NULL,
	PRECO DOUBLE PRECISION NOT NULL,
	FOREIGN KEY(ID_DEPARTAMENTO) REFERENCES DEPARTAMENTO(ID),
	FOREIGN KEY(CNPJ_FORNECEDOR) REFERENCES FORNECEDOR(CNPJ),
	PRIMARY KEY(ID)
);


CREATE TABLE FORMA_PAGAMENTO(
	ID INT NOT NULL,
	TIPO VARCHAR(30) NOT NULL,
	Num_Parcelas INT NOT NULL,
	PRIMARY KEY(ID)
);


CREATE TABLE VENDA(
	ID VARCHAR(20) NOT NULL,
	STATUS VARCHAR(20) DEFAULT 'EM ABERTO',
	VALOR DOUBLE PRECISION DEFAULT 0,
	ID_FORMAPAGAMENTO INT,
	FOREIGN KEY(ID_formaPagamento) REFERENCES FORMA_PAGAMENTO(ID),
	PRIMARY KEY(ID)
);

CREATE TABLE ITEM_VENDA(
	ID_VENDA VARCHAR(20) NOT NULL,
	ID_PRODUTO VARCHAR(10) NOT NULL,
	QUANTIDADE INT NOT NULL,
	FOREIGN KEY(ID_VENDA) REFERENCES VENDA(ID),
	FOREIGN KEY(ID_PRODUTO) REFERENCES PRODUTO(ID),
	PRIMARY KEY(ID_VENDA,ID_PRODUTO)
);

CREATE TABLE REALIZA_VENDA(
	DATA DATE NOT NULL,
	HORA TIMESTAMP NOT NULL,
	CPF_CLIENTE VARCHAR(11) NOT NULL,
	CPF_FUNCIONARIO VARCHAR(11) NOT NULL,
	ID_VENDA VARCHAR(20), --transação está agora como NOT NULL
	FOREIGN KEY(CPF_CLIENTE) REFERENCES CLIENTE(CPF_PESSOA),
	FOREIGN KEY(CPF_FUNCIONARIO) REFERENCES FUNCIONARIO(CPF_PESSOA),
	FOREIGN KEY(ID_VENDA) REFERENCES VENDA(ID),
	PRIMARY KEY(DATA,HORA,CPF_CLIENTE,CPF_FUNCIONARIO,ID_VENDA)
);

CREATE TABLE NOTAFISCAL(
	NUMERO_NOTA SERIAL NOT NULL,
	SERIE VARCHAR(15) NOT NULL,
	ID_VENDA VARCHAR(20) NOT NULL,
	DATA_EMISSAO DATE NOT NULL,
	IMPOSTO DOUBLE PRECISION NOT NULL,
	FOREIGN KEY(ID_VENDA) REFERENCES VENDA(ID),
	PRIMARY KEY(NUMERO_NOTA,SERIE)
);

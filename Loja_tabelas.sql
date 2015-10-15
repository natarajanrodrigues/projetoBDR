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
	ID SERIAL NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	FOREIGN KEY(CPF_PESSOA) REFERENCES PESSOA(CPF),
	PRIMARY KEY(CPF_PESSOA)
);

CREATE TABLE FUNCIONARIO(
	CPF_PESSOA VARCHAR(11) NOT NULL,
	MATRICULA SERIAL NOT NULL,
	SALARIO_BASE DOUBLE PRECISION NOT NULL,
	COMISSAO FLOAT(3) NOT NULL,
	SALARIO_FAMILIA DOUBLE PRECISION NOT NULL,
	FOREIGN KEY(CPF_PESSOA) REFERENCES PESSOA(CPF),
	PRIMARY KEY(CPF_PESSOA)
);

CREATE TABLE DEPENDENTE(
	CPF_PESSOA VARCHAR(11) NOT NULL,
	ID SERIAL NOT NULL,
	IDADE INT NOT NULL,
	FOREIGN KEY(CPF_PESSOA) REFERENCES PESSOA(CPF),
	PRIMARY KEY(CPF_PESSOA)
);

CREATE TABLE FORNECEDOR(
	CNPJ VARCHAR(14) NOT NULL,
	NOME VARCHAR(40) NOT NULL,
	REGIME_TRIBUTARIO VARCHAR(40) NOT NULL,
	ESTADO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	CENTRO VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(50) NOT NULL,
	RUA VARCHAR(50) NOT NULL,
	NUMERO INT NOT NULL,
	PRIMARY KEY(CNPJ)
);

CREATE TABLE TELEFONE_FORNECEDOR(
	CNPJ_FORNECEDOR VARCHAR(14) NOT NULL,
	TELEFONE VARCHAR(14) NOT NULL,
	FOREIGN KEY(CNPJ_FORNECEDOR) REFERENCES FORNECEDOR(CNPJ),
	PRIMARY KEY(CNPJ_FORNECEDOR,TELEFONE)
);

CREATE TABLE DEPARTAMENTO(
	ID SERIAL NOT NULL,
	NOME VARCHAR(40) NOT NULL,
	DESCRICAO VARCHAR(60) NOT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE PRODUTO(
	ID SERIAL NOT NULL,
	ID_DEPARTAMENTO INT NOT NULL,
	CNPJ_FORNECEDOR VARCHAR(14) NOT NULL,
	NOME VARCHAR(40) NOT NULL,
	DESCRICAO VARCHAR(60) NOT NULL,
	ESTOQUE INT NOT NULL,
	IMPOSTO FLOAT(3) NOT NULL,
	PREÇO DOUBLE PRECISION NOT NULL,
	FOREIGN KEY(ID_DEPARTAMENTO) REFERENCES DEPARTAMENTO(ID),
	FOREIGN KEY(CNPJ_FORNECEDOR) REFERENCES FORNECEDOR(CNPJ),
	PRIMARY KEY(ID)
);

CREATE TABLE TRANSACAO(
	ID SERIAL NOT NULL,
	STATUS VARCHAR(20) NOT NULL,
	VALOR DOUBLE PRECISION NOT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE TRANSACAO_PRODUTO(
	ID_TRANSACAO INT NOT NULL,
	ID_PRODUTO INT NOT NULL,
	QUANTIDADE INT NOT NULL,
	FOREIGN KEY(ID_TRANSACAO) REFERENCES TRANSACAO(ID),
	FOREIGN KEY(ID_PRODUTO) REFERENCES PRODUTO(ID),
	PRIMARY KEY(ID_TRANSACAO,ID_PRODUTO)
);

CREATE TABLE REALIZA_VENDA(
	DATA DATE NOT NULL,
	HORA TIMESTAMP NOT NULL,
	CPF_CLIENTE VARCHAR(11) NOT NULL,
	CPF_FUNCIONARIO VARCHAR(11) NOT NULL,
	ID_TRANSACAO INT NOT NULL,
	FOREIGN KEY(CPF_CLIENTE) REFERENCES CLIENTE(CPF_PESSOA),
	FOREIGN KEY(CPF_FUNCIONARIO) REFERENCES FUNCIONARIO(CPF_PESSOA),
	FOREIGN KEY(ID_TRANSACAO) REFERENCES TRANSACAO(ID),
	PRIMARY KEY(DATA,HORA,CPF_CLIENTE,CPF_FUNCIONARIO,ID_TRANSACAO)
);

CREATE TABLE NOTAFISCAL(
	NUMERO_NOTA SERIAL NOT NULL,
	SERIE INT NOT NULL,
	ID_TRANSACAO INT NOT NULL,
	DATA_EMISSAO DATE NOT NULL,
	IMPOSTO DOUBLE PRECISION NOT NULL,
	FOREIGN KEY(ID_TRANSACAO) REFERENCES TRANSACAO(ID),
	PRIMARY KEY(NUMERO_NOTA,SERIE)
);

CREATE TABLE FORMA_PAGAMENTO(
	ID SERIAL NOT NULL,
	TIPO VARCHAR(30) NOT NULL,
	Num_Parcelas INT NOT NULL,
	PRIMARY KEY(ID)
);


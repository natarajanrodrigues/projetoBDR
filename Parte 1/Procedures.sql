--PROCEDURES--

--1. replace o maior codigo do produto, ou seja, o ultimo produto adicionado
CREATE OR REPLACE FUNCTION maiorCodigoProduto()
RETURNS INTEGER
AS'
   DECLARE 
      maxId INTEGER;
   BEGIN
      SELECT INTO maxId max(id) FROM Produto;
      RETURN maxId;
   END'
LANGUAGE plpgsql;

--2. retorna o lucro total
CREATE OR REPLACE FUNCTION getTotalLucro()
RETURNS DOUBLE PRECISION
AS'
   DECLARE
      total DOUBLE PRECISION;
   BEGIN
      SELECT INTO total SUM(v.valor) FROM Venda v
      RETURN total;
   END'
LANGUAGE plpgsql;

--3. retorna a quantidade de estoque do produto passado por parâmetro
CREATE OR REPLACE FUNCTION estoque_produto(INTEGER)
RETURNS INTEGER
AS'
   DECLARE
      estoque INTEGER;
      produto_id ALIAS FOR $1;
   BEGIN
      SELECT INTO estoque estoque FROM Produto WHERE id=produto_id;
      RETURN estoque;
   END'
LANGUAGE plpgsql;

--4. retorna idade de acordo com a data de nascimento da pessoa
CREATE OR REPLACE FUNCTION calcula_idade(DATE)
RETURNS INTEGER
AS'
   DECLARE
      idade INTEGER;
      dataAtual DATE;
      dataNascimento ALIAS FOR $1;
   BEGIN
      idade = (dataAtual - dataNascimento)/365;
      RETURN idade;
   END'
LANGUAGE plpgsql;
--PROCEDURES--

--1. replace o maior codigo do produto, ou seja, o ultimo produto adicionado
CREATE OR REPLACE FUNCTION maiorCodigoProduto()
RETURNS VARCHAR
AS'
   DECLARE 
      maxId VARCHAR;
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


-- 5. calcula valor da comissão de um vendedor de acordo com a quantidade de vendas de um funcionário
-- num determinado mes
CREATE OR REPLACE FUNCTION calcula_comissao(VARCHAR, INTEGER, FLOAT)
RETURNS FLOAT
AS'
   	DECLARE
      	comissao FLOAT;
      	vendas_mes DOUBLE PRECISION;
      	matricula ALIAS FOR $1;
      	mes ALIAS FOR $2;
      	percent ALIAS FOR $3;

   	BEGIN

   		SELECT INTO vendas_mes sum(valor)
   		FROM Realiza_venda rv join Venda v on rv.id_venda=v.id
   		WHERE rv.cpf_funcionario=matricula and extract(month from rv.data::timestamp) = mes::double precision;
      	

   		comissao = vendas_mes * percent;
    	RETURN comissao;
   	END'
LANGUAGE plpgsql;



-- 6. calcula o valor do salário família com base na quantidade de dependentes que o funcionário tem

CREATE OR REPLACE FUNCTION calcula_salarioFamilia(VARCHAR, DOUBLE PRECISION)
RETURNS DOUBLE PRECISION
AS'
   	DECLARE
      	qnt_dependentes int;
      	uma_matricula ALIAS FOR $1;
      	vlr_por_dependente ALIAS FOR $2;

   	BEGIN

   		SELECT INTO qnt_dependentes count(*)
   		FROM Dependente d join Funcionario f on d.matricula_funcionario = f.matricula
   		WHERE f.matricula = uma_matricula;
      	
    	RETURN qnt_dependentes * vlr_por_dependente;
   	END'
LANGUAGE plpgsql;



-- 7. coloca um departamento todo em promoção (x% de desconto em todos os produtos do departamento)
CREATE OR REPLACE FUNCTION promocao_departamento(VARCHAR, DOUBLE PRECISION)
RETURNS VOID
AS'
   	DECLARE
      	uma_departamento ALIAS FOR $1;
      	desconto ALIAS FOR $2;

   	BEGIN

   		SELECT INTO qnt_dependentes count(*)
   		FROM Dependente d join Funcionario f on d.matricula_funcionario = f.matricula
   		WHERE f.matricula = uma_matricula;
      	
    	RETURN NULL;
   	END'
LANGUAGE plpgsql;



-- 8. 


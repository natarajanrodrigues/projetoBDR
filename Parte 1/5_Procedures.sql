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
      SELECT INTO total SUM(v.valor) FROM Venda v;
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
      dataAtual = now();
      idade = (dataAtual - dataNascimento)/365;
      RETURN idade;
   END'
LANGUAGE plpgsql;




-- 5. calcula o valor do salário família com base na quantidade de dependentes que o funcionário tem

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


-- 6. Retorna total da folha de pagamento
CREATE OR REPLACE FUNCTION calcula_folha () RETURNS  DOUBLE PRECISION 
AS '
    DECLARE
	    c1 REFCURSOR;
	    sb DOUBLE PRECISION := 0;
	    sf DOUBLE PRECISION := 0;
		folha DOUBLE PRECISION := 0;
    BEGIN

       OPEN c1 FOR SELECT salario_base, salario_familia FROM Funcionario;
                    
       FETCH c1 INTO sb, sf;
       WHILE FOUND LOOP
          folha := folha + sb + sf;
       FETCH c1 INTO sb, sf;
       END LOOP;

       CLOSE c1;
       RETURN folha;
	END' 
LANGUAGE plpgsql;



-- 6b. Retorna total da folha de pagamento (usando FOR) 

CREATE OR REPLACE FUNCTION calcula_folha2() RETURNS  FLOAT (2)
AS '
    DECLARE
	    
		folha FLOAT := 0;
		func Funcionario%RowType;
    BEGIN

       FOR func IN SELECT * FROM FUNCIONARIO
       		LOOP
       			folha := folha + func.salario_base + func.salario_familia;
       		END LOOP;

       RETURN folha;
	END' 
LANGUAGE plpgsql;



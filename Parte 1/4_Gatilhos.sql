--1. Ao adicionar um dependente, automaticamente seta a idade correspondente
CREATE OR REPLACE FUNCTION setIdadeDependente()
RETURNS TRIGGER
AS'
   DECLARE
        auxIdade INTEGER;
        data DATE;
   BEGIN
        SELECT INTO auxIdade calcula_idade(p.DATA_NASCIMENTO) 
        FROM Pessoa p WHERE NEW.cpf_dependente = p.cpf;
        UPDATE Dependente SET idade=auxIdade WHERE cpf_dependente = NEW.cpf_dependente;
        RETURN NEW;
   END'
LANGUAGE plpgsql;


CREATE TRIGGER TriggerSetIdadeDependente
AFTER INSERT ON Dependente
FOR EACH ROW
EXECUTE PROCEDURE setIdadeDependente();


--2. Atualiza ao valor da compra ao adicionar um novo produto à tabela Item_venda
CREATE OR REPLACE FUNCTION incrementaValorVenda() RETURNS TRIGGER
AS'
  DECLARE
      produto_preco DOUBLE PRECISION;
  BEGIN
      SELECT INTO produto_preco p.preco
      FROM Produto p WHERE p.id = NEW.id_produto;
      UPDATE Venda SET valor=valor+produto_preco*NEW.quantidade WHERE id=NEW.id_venda;
      RETURN NEW;
  END'
LANGUAGE plpgsql;

CREATE TRIGGER TriggerIncrementaValorVenda
AFTER INSERT ON Item_venda
FOR EACH ROW
EXECUTE PROCEDURE incrementaValorVenda();



/*3. seta o status da venda como "finalizada" assim que uma é adicionado um novo "realiza_venda" 
  com referencia a venda
*/
CREATE OR REPLACE FUNCTION finalizaVenda() RETURNS TRIGGER
AS'
  	BEGIN
     	UPDATE Venda SET status=''Finalizada'' 
     	WHERE id=NEW.id_venda;
     	RETURN NEW;
  	END'
LANGUAGE plpgsql;


CREATE TRIGGER TriggerFinalizaVenda
AFTER INSERT ON Realiza_Venda
FOR EACH ROW 
EXECUTE PROCEDURE finalizaVenda();



--4. Ao adicionar um dependente, automaticamente calcula o salário família do funcionario
CREATE OR REPLACE FUNCTION setSalarioFamilia()
RETURNS TRIGGER
AS'
   DECLARE
        qntDependentes INTEGER;
        vlr_por_dependente DOUBLE PRECISION := 100;
   BEGIN
        SELECT INTO qntDependentes count(*)
        FROM Dependente d WHERE d.matricula_funcionario = NEW.matricula_funcionario;
        
        UPDATE Funcionario SET salario_familia=qntDependentes*vlr_por_dependente 
        WHERE matricula = NEW.matricula_funcionario;
        RETURN NEW;
   END'
LANGUAGE plpgsql;


CREATE TRIGGER TriggerSetSalarioFamilia
AFTER INSERT ON Dependente
FOR EACH ROW
EXECUTE PROCEDURE setSalarioFamilia();




/* 5. seta atualiza a pontuacao do cliente assim que uma é adicionado um novo "realiza_venda".
*/
CREATE OR REPLACE FUNCTION calculaPontos() RETURNS TRIGGER
AS'
	DECLARE
        pontosAnteriores INT;
        soma_compra double precision;
        pontosNovaVenda INT;


  	BEGIN
  		SELECT INTO pontosAnteriores c.pontuacao
  		FROM Cliente c WHERE c.cpf_pessoa = NEW.cpf_cliente;

  		SELECT INTO soma_compra sum(v.valor)
  		FROM Venda v join realiza_venda rv on v.id = rv.id_venda
  		WHERE rv.cpf_cliente = NEW.cpf_cliente;

  		pontosNovaVenda := round(soma_compra / 100);

     	UPDATE CLIENTE SET pontuacao=pontosAnteriores + pontosNovaVenda
     	WHERE cpf_pessoa=NEW.cpf_cliente;
     	RETURN NEW;
  	END'
LANGUAGE plpgsql;


CREATE TRIGGER TriggerCalculaPontos
AFTER INSERT ON Realiza_Venda
FOR EACH ROW 
EXECUTE PROCEDURE calculaPontos();

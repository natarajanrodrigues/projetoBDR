--1. Ao adicionar um dependente, automaticamente seta a idade correspondente
CREATE OR REPLACE FUNCTION setIdadeDependente()
RETURNS TRIGGER
AS'
   DECLARE
        auxIdade INTEGER;
        data DATE;
   BEGIN
        SELECT INTO auxIdade calcula_idade(DATA_NASCIMENTO) 
        FROM Pessoa p WHERE NEW.cpf_dependente = p.cpf;
        UPDATE Dependente SET idade=auxIdade WHERE cpf_dependente = NEW.cpf_dependente;
        RETURN NEW;
   END'
LANGUAGE plpgsql;


CREATE TRIGGER TriggerSetIdadeDependente
AFTER INSERT ON Dependente
FOR EACH ROW
EXECUTE PROCEDURE setIdadeDependente();


--2. Atualiza ao valor da compra ao adicionar um novo produto à tabel a Item_venda
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


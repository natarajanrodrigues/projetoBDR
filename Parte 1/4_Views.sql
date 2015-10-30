---VIEWS---

--1. Exibe o cpf, o nome e a função da pessoa no sistema.
CREATE VIEW funcaoPessoa AS
SELECT DISTINCT p.cpf, p.nome, 
CASE 
   WHEN p.cpf = f.cpf_pessoa THEN 'Funcionario'
   WHEN p.cpf = c.cpf_pessoa THEN 'Cliente'
   WHEN p.cpf = d.cpf_dependente THEN 'Dependente'
END funcao 
FROM Pessoa p, Funcionario f, Cliente c, Dependente d 
WHERE p.cpf = f.cpf_pessoa OR p.cpf = c.cpf_pessoa OR p.cpf = d.cpf_dependente
ORDER BY funcao DESC;

--2. Exibe o cpf, o nome, o salarioBase e a quantidade de vendas efetuadas pelos funcionarios
CREATE VIEW funcionarioQtVenda AS
SELECT p.cpf,p.nome vendedor, COUNT(id_venda) num_vendas
FROM Funcionario f JOIN Pessoa p ON f.cpf_pessoa = p.cpf 
LEFT OUTER JOIN Realiza_Venda rv ON f.cpf_pessoa = rv.cpf_funcionario 
GROUP BY p.cpf;


--3. Departamento juntamente com a média dos preços dos produtos de cada
CREATE VIEW departamentoAVGPreco AS
SELECT d.id depto_id, d.nome depto, AVG(p.preco) 
FROM Departamento d JOIN Produto p ON d.id = p.id_departamento
GROUP BY d.id;


--4 produtos por fornecedores
CREATE VIEW produto_fornecedor AS
SELECT f.cnpj, f.nome fornecedor, p.id id_produto, p.nome produto, p.preco
FROM Fornecedor f JOIN Produto p ON f.cnpj = p.cnpj_fornecedor;


--5. id, produto, quantidade de unidades vendidas Ordenado pela quantidade
CREATE VIEW prod_Vendas AS
SELECT DISTINCT q.id,q.nome,q.vendas*iv.quantidade unidades_vendidas
FROM (SELECT p.id,p.nome,COUNT(*)vendas 
	FROM Produto p JOIN Item_Venda iv ON p.id = iv.id_produto GROUP BY p.id) AS q
JOIN Item_Venda iv ON q.id = iv.id_produto ORDER BY unidades_vendidas DESC;

--CONSULTAS

/*
	Por medidas de organização e praticidade na hora de ler as consultas
	Seria bom colocarmos uma(s) linha(s) comentada(s) antes da consulta
	indicando do que se trata a mesma.
*/

--1. Quantos funcionários trabalham na loja
SELECT COUNT(*) FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa

--2. Clientes que moram em Cajazeiras
SELECT c.nome FROM Cliente c JOIN Pessoa p ON c.cpf_pessoa = p.cpf
WHERE p.cidade='Cajazeiras'

--3. Clientes que possuem dois ou mais telefones
SELECT c.nome 
FROM Cliente c JOIN Pessoa p ON c.cpf_pessoa = p.cpf
WHERE (SELECT COUNT(*) FROM Telefone_Pessoa tp 
WHERE tp.cpf_pessoa = c.cpf_pessoa) > 1

--4. Funcionários que não realizaram nenhuma venda
SELECT p.nome
FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
WHERE NOT EXISTS (SELECT * FROM Realiza_Venda rv 
WHERE rv.cpf_funcionario = p.cpf_pessoa)

--5. Funcionários que realizaram duas ou mais vendas
SELECT p.nome
FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
WHERE (SELECT COUNT(*) FROM Realiza_Venda rv 
WHERE rv.cpf_funcionario = f.cpf_pessoa) > 1

--6. Exibir produtos pelo departamento
SELECT p.nome produto, d.nome departamento
FROM Produto p JOIN Departamento d ON p.id_departamento = d.id

--7. Quantidade de cidades diferentes dos clientes
SELECT COUNT(DISTINCT p.cidade) tipos_cidades 
FROM Pessoa p JOIN Cliente c ON p.cpf = c.cpf_pessoa

--8. Exibir lucro por forma de pagamento
SELECT fp.tipo formaPagamento, SUM(tp.quantidade * p.preco) valor_total
FROM Forma_Pagamento fp JOIN Transacao t ON fp.id = t.id_formaPagamento
JOIN Transacao_Produto tp ON tp.id_transacao = t.id 
JOIN Produto p ON tp.id_produto = p.id
GROUP BY fp.id

--9. Clientes que compraram por cartão
SELECT p.nome 
FROM Pessoa p JOIN Transacao t ON p.cpf = t.cpf_cliente
JOIN Forma_Pagamento fp ON t.id_formaPagamento = t.id
WHERE fp.tipo ILIKE '%cartao%'

--10. Exibir Produto mais caro
SELECT p.nome produto FROM Produto p
WHERE p.preco = (SELECT MAX(preco) FROM Produto)

--11. Cidade que mais tem pessoas
SELECT cidade, COUNT(*) quantidade 
FROM Pessoa p 
GROUP BY cidade 
ORDER BY quantidade DESC
LIMIT 1

--12. Produto que mais vendeu
SELECT p.nome, COUNT(*) vendas 
FROM Produto p JOIN Transacao_Produto tp
ON p.id = tp.produto_id 
GROUP BY p.id
ORDER BY vendas DESC
LIMIT 1

--13. nome do funcionário seguido do nome do dependente correspondente
SELECT f.nome, d.nome 
FROM (SELECT f.matricula,p.nome FROM Funcionario f JOIN Pessoa p ON f.cpf_pessoa = p.cpf) as f
JOIN (SELECT d.matricula,p.nome FROM Dependente d JOIN Pessoa p ON d.cpf_pessoa = p.cpf) as d 
ON f.matricula = d.matricula

--14. funcionários que não possuem dependentes
SELECT p.nome funcionario
FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa 
WHERE NOT EXISTS(SELECT * FROM Dependente d
WHERE d.cpf_funcionario = f.cpf_pessoa)


--15. funcionários que possuem um ou mais dependentes
SELECT p.nome FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
WHERE (SELECT COUNT(*) FROM Dependente d WHERE d.matricula = f.matricula)>1

--16. funcionários cujo os dependentes não moram na mesma cidade
SELECT f.nome 
FROM (SELECT f.matricula,p.nome,p.cidade FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa) as f 
JOIN (SELECT d.matricula,p.nome,p.cidade FROM Pessoa p JOIN Dependente d ON p.cpf = d.cpf_pessoa) as d 
ON f.matricula = d.matricula
WHERE f.cidade != d.cidade

--17. Pessoas e seus "cargos" na loja
SELECT DISTINCT p.nome,
CASE
   WHEN p.cpf = f.cpf_pessoa THEN 'Funcionario'
   WHEN p.cpf = d.cpf_pessoa THEN 'Dependente'
   WHEN p.cpf = c.cpf_pessoa THEN 'Cliente'
END tipo
FROM Pessoa p, Funcionario f, Dependente d, Cliente c
WHERE p.cpf = f.cpf_pessoa OR p.cpf = d.cpf_pessoa OR p.cpf = c.cpf_pessoa

--18. Clientes que usam gmail
SELECT p.nome FROM Pessoa p JOIN Cliente c
ON p.cpf = c.cpf_pessoa
WHERE c.email ILIKE '%GMAIL%'

--19. Funcionario que ganha mais
SELECT p.nome, (f.salario_familia*f.comissao) salarioTotal FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
ORDER BY salarioTotal DESC
LIMIT 1

--20. Funcionário com mais dependentes
SELECT f.nome as funcionario, COUNT(*) as qt_dependentes 
FROM (SELECT matricula,nome FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa) as f
JOIN Dependente d ON f.matricula = d.matricula
GROUP BY f.nome
ORDER BY qt_dependentes DESC LIMIT 1

--21. Qual "Cargo" tem mais pessoas
SELECT nome_cargo.tipo, COUNT(*) pessoas FROM (SELECT DISTINCT p.nome,
CASE
   WHEN p.cpf = f.cpf_pessoa THEN 'Funcionário'
   WHEN p.cpf = d.cpf_pessoa THEN 'Dependente'
   WHEN p.cpf = c.cpf_pessoa THEN 'Cliente'
END tipo
FROM Pessoa p, Funcionario f, Dependente d, Cliente c
WHERE p.cpf = f.cpf_pessoa OR p.cpf = d.cpf_pessoa OR p.cpf = c.cpf_pessoa
order by tipo ASC) AS nome_cargo GROUP BY nome_cargo.tipo 
ORDER BY pessoas DESC
LIMIT 1

--22. fornecedores que possuem um ou mais telefones
SELECT f.nome FROM Fornecedor f
WHERE (SELECT COUNT(*) FROM Telefone_fornecedor tf WHERE tf.cnpj_fornecedor = f.cpnj)>1

--23. fornecedores em conjunto com o departamento de produtos que eles fornecem
SELECT f.cnpj, f.nome fornecedor, d.nome departamento 
FROM Fornecedor f JOIN Produto p ON f.cnpj = p.cnpj_fornecedor
JOIN Departamento d ON d.ID = p.departamento_id

--24. fornecedores que fornecem mais produtos de um mesmo tipo
SELECT f.cnpj, f.nome, COUNT(*) qtde FROM Fornecedor f
JOIN Produto p ON f.cnpj = p.cnpj_fornecedor
JOIN Departamento d ON d.id = p.departamento_id
group by f.cnpj, d.id
ORDER BY qtde DESC
LIMIT 1

--25. Departamento e a quantidade de produtos do mesmo
SELECT d.nome departamento, COUNT(*) qtde_produtos 
FROM Departamento d JOIN Produto p ON d.id = p.departamento_id
GROUP BY d.id

--26. Departamento com menor quantidade de produtos
SELECT d.nome departamento, COUNT(*) qtde_produtos
FROM Departamento d JOIN Produto p ON d.id = p.departamento_id
GROUP BY d.id
ORDER BY qtde_produtos ASC
LIMIT 1

--27. Clientes que realizaram uma transacao no dia 19/10/15
--28. Clientes que efetuaram uma compra no dia 19/10/15
--29. Clientes que realizaram uma transacao que não foi aceita
--30. Clientes que compraram algo a vista
--31. Clientes que efetuaram alguma compra cujo algum dos produtos comprados tenha sido da fornecedora ASUS
--32. Clientes que compraram mais de um produto numa mesma compra
--33. Clientes que efetuaram uma compra dividido em 12x
--34. diminuir o salario em 100 reais para os funcionários que não tiverem realizado nem uma venda
--35. dar desconto de 10% no valor total da compra de um cliente que tiver comprado mais de 1 produto da motorola

--36. Funcionario que vendeu mais de 5 produtos em um único dia
SELECT p.nome 
FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
JOIN realiza_venda rv ON f.cpf_pessoa = rv.cpf_funcionario
JOIN Transacao t ON rv.id_transacao = t.id 
JOIN Transacao_produto tp ON t.id = tp.id_transacao
WHERE (SELECT COUNT(*) FROM Produto p WHERE tp.id_produto = p.id GROUP BY rv.data)>5


--37. Clientes mulher seguido dos produtos comprados
SELECT pe.nome 
FROM Pessoa pe JOIN Cliente c ON pe.cpf = c.cpf_pessoa
JOIN realiza_venda rv ON c.cpf_pessoa = rv.cpf_cliente
JOIN Transacao t ON rv.id_transacao = t.id
JOIN Transacao_produto tp ON t.id = tp.id_transacao
JOIN Produto pr ON tp.id_produto = pr.id
WHERE pe.sexo='F'

--38. Cliente que mais consumiu na loja
SELECT pe.nome, sum(tp.quantidade*pr.preco) consumo_total
FROM Pessoa pe JOIN Cliente c ON pe.cpf = c.cpf_pessoa
JOIN realiza_venda rv ON c.cpf_pessoa = rv.cpf_cliente
JOIN Transacao t ON rv.id_transacao = t.id
JOIN Transacao_produto tp ON t.id = tp.id_transacao
JOIN Produto pr ON tp.id_produto = pr.id
GROUP BY pe.cpf ORDER BY consumo_total DESC LIMIT 1

--39. media dos preços dos produtos fornecidos pela Motorola
SELECT avg(p.preco) media_preco
FROM Fornecedor f JOIN Produto p ON f.cnpj = p.cnpj_fornecedor
WHERE f.nome='Motorola'

--40. Transacao com maior custo
SELECT sum(tp.quantidade*p.preco) custo
FROM Transacao t JOIN Transacao_produto tp ON t.id = tp.id_transacao JOIN Produto p ON tp.id_produto = p.id
GROUP BY t.id
ORDER BY custo DESC
LIMIT 1

--41. Produto com maior quantidade de estoque
SELECT p.nome FROM Produto p
WHERE p.estoque = (SELECT MAX(estoque) FROM Produto)

--42. Exibir o nome do produto seguido do valor total do estoque
SELECT nome, SUM(preco*estoque) FROM Produto
GROUP BY id

--43. Funcionarios que contenham a letra M em seu nome
SELECT p.nome FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
WHERE p.nome ILIKE '%M%';

--44. Exibir ranking dos items mais presentes nas vendas
SELECT p.nome, SUM(tp.quantidade) quantidade FROM Produto p JOIN Transacao_Produto tp ON p.id = tp.id_produto
GROUP BY p.id 
ORDER BY quantidade DESC

--45. Identificar quais Funcionarios venderam aos clientes de João Pessoa
SELECT p.nome FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
JOIN realiza_venda rv ON f.cpf_pessoa = rv.cpf_funcionario 
JOIN (SELECT cpf, cidade FROM Pessoa JOIN Cliente ON cpf = cpf_pessoa) as c ON c.cpf = rv.cpf_cliente
WHERE c.cidade = 'João Pessoa'



---VIEWS---

--1. Exibe o cpf, o nome e a função da pessoa no sistema.
CREATE VIEW funcaoPessoa AS
SELECT DISTINCT p.cpf, p.nome, 
CASE 
   WHEN p.cpf = f.cpf_pessoa THEN 'Funcionario'
   WHEN p.cpf = c.cpf_pessoa THEN 'Cliente'
   WHEN p.cpf = d.cpf_pessoa THEN 'Dependente'
END funcao 
FROM Pessoa p, Funcionario f, Cliente c, Dependente d 
WHERE p.cpf = f.cpf_pessoa OR p.cpf = c.cpf_pessoa OR p.cpf = d.cpf_pessoa
ORDER BY funcao DESC
















	
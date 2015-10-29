--CONSULTAS

/*
   Por medidas de organização e praticidade na hora de ler as consultas
   Seria bom colocarmos uma(s) linha(s) comentada(s) antes da consulta
   indicando do que se trata a mesma.
*/

--1. Quantos funcionários trabalham na loja
SELECT COUNT(*) FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa

--2. Clientes que moram em Cajazeiras
SELECT p.nome FROM Cliente c JOIN Pessoa p ON c.cpf_pessoa = p.cpf
WHERE p.cidade='Cajazeiras'

--3. Clientes que possuem dois ou mais telefones
SELECT p.nome 
FROM Cliente c JOIN Pessoa p ON c.cpf_pessoa = p.cpf
WHERE (SELECT COUNT(*) FROM Telefone_Pessoa tp 
WHERE tp.cpf_pessoa = c.cpf_pessoa) > 1

--4. Funcionários que não realizaram nenhuma venda
SELECT p.nome
FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
WHERE NOT EXISTS (SELECT * FROM Realiza_Venda rv 
WHERE rv.cpf_funcionario = f.cpf_pessoa)

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
SELECT fp.tipo formaPagamento, SUM(iv.quantidade * p.preco) valor_total
FROM Forma_Pagamento fp JOIN Venda v ON fp.id = v.id_formaPagamento
JOIN Item_venda iv ON iv.id_venda = v.id 
JOIN Produto p ON iv.id_produto = p.id
GROUP BY fp.id

--9. Clientes que compraram por cartão
SELECT p.nome 
FROM Pessoa p JOIN Realiza_Venda rv ON p.cpf = rv.cpf_cliente
JOIN Venda v ON rv.id_venda = v.id
JOIN Forma_Pagamento fp ON v.id_formaPagamento = fp.id
WHERE fp.tipo ILIKE '%cartão%'

--10. Exibir Produto mais caro
SELECT p.nome produto, p.preco FROM Produto p
WHERE p.preco = (SELECT MAX(preco) FROM Produto)

--11. Cidade que mais tem pessoas
SELECT cidade, COUNT(*) quantidade 
FROM Pessoa p 
GROUP BY cidade 
ORDER BY quantidade DESC
LIMIT 1

--12. Produto que mais vendeu prod_Venda é uma VIEW
SELECT * FROM prod_Vendas LIMIT 1

--13. nome do funcionário seguido do nome do dependente correspondente
SELECT f.nome, d.nome 
FROM (SELECT f.matricula,p.nome FROM Funcionario f JOIN Pessoa p ON f.cpf_pessoa = p.cpf) as f
JOIN (SELECT d.matricula_funcionario,p.nome FROM Dependente d JOIN Pessoa p ON d.cpf_dependente = p.cpf) as d 
ON f.matricula = d.matricula_funcionario

--14. funcionários que não possuem dependentes
SELECT p.nome funcionario FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
WHERE NOT EXISTS(SELECT * FROM Dependente d WHERE f.matricula = d.matricula_funcionario)

--15. funcionários que possuem um ou mais dependentes
SELECT p.nome FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
WHERE (SELECT COUNT(*) FROM Dependente d WHERE d.matricula_funcionario = f.matricula)>1

--16. funcionários cujo os dependentes não moram na mesma cidade
SELECT distinct f.nome 
FROM (SELECT f.matricula,p.nome,p.cidade FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa) as f 
JOIN (SELECT d.matricula_funcionario,p.nome,p.cidade FROM Pessoa p JOIN Dependente d ON p.cpf = d.cpf_dependente) as d 
ON f.matricula = d.matricula_funcionario
WHERE f.cidade != d.cidade

--17. Pessoas e seus "cargos" na loja *funcaoPessoa É UMA VIEW*
SELECT * FROM funcaoPessoa;

--18. Clientes que usam gmail
SELECT p.nome FROM Pessoa p JOIN Cliente c
ON p.cpf = c.cpf_pessoa
WHERE c.email ILIKE '%GMAIL%'

--19. Funcionario que ganha mais
SELECT p.nome, (f.salario_base + f.salario_familia + f.comissao) salarioTotal FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
ORDER BY salarioTotal DESC
LIMIT 1

--20. Funcionário com mais dependentes
SELECT f.nome as funcionario, COUNT(*) as qt_dependentes 
FROM (SELECT matricula,nome FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa) as f
JOIN Dependente d ON f.matricula = d.matricula_funcionario
GROUP BY f.nome
ORDER BY qt_dependentes DESC LIMIT 1

--21. Qual "Cargo" tem mais pessoas *funcaoPessoa É UMA VIEW*
SELECT f.funcao, COUNT(funcao) qtde FROM funcaoPessoa f
GROUP BY f.funcao ORDER BY qtde DESC LIMIT 1

--22. fornecedores que possuem um ou mais telefones
SELECT f.nome FROM Fornecedor f
WHERE (SELECT COUNT(*) FROM Telefone_fornecedor tf WHERE tf.cnpj_fornecedor = f.cnpj)>1

--23. fornecedores em conjunto com o departamento de produtos que eles fornecem
SELECT f.cnpj, f.nome fornecedor, d.nome departamento 
FROM Fornecedor f JOIN Produto p ON f.cnpj = p.cnpj_fornecedor
JOIN Departamento d ON d.ID = p.id_departamento

--24. fornecedores que fornecem mais produtos de um mesmo tipo
SELECT f.cnpj, f.nome, COUNT(*) qtde FROM Fornecedor f
JOIN Produto p ON f.cnpj = p.cnpj_fornecedor
JOIN Departamento d ON d.id = p.id_departamento
group by f.cnpj, d.id
ORDER BY qtde DESC LIMIT 1

--25. Departamento e a quantidade de produtos do mesmo
SELECT d.nome departamento, COUNT(*) qtde_produtos 
FROM Departamento d JOIN Produto p ON d.id = p.id_departamento
GROUP BY d.id

--26. Departamento com menor quantidade de produtos
SELECT d.nome departamento, COUNT(*) qtde_produtos
FROM Departamento d JOIN Produto p ON d.id = p.id_departamento
GROUP BY d.id
ORDER BY qtde_produtos ASC
LIMIT 1

--27. Clientes que realizaram uma transacao no dia 19/10/15
SELECT p.nome cliente FROM Pessoa p JOIN Realiza_Venda rv ON p.cpf = rv.cpf_cliente
WHERE rv.data='15/10/15';

--28. Clientes que efetuaram uma compra no dia 19/10/15
SELECT p.nome cliente FROM Pessoa p JOIN Realiza_Venda rv ON p.cpf = rv.cpf_cliente
JOIN Venda v ON rv.id_venda = v.id WHERE rv.data='15/10/2015' AND v.status='Finalizada';

--30. Clientes que compraram algo a vista
SELECT p.nome cliente FROM Pessoa p JOIN Realiza_Venda rv ON p.cpf = rv.cpf_cliente
JOIN Venda v ON rv.id_venda = v.id JOIN Forma_Pagamento fp ON fp.id = v.id_formaPagamento
WHERE tipo ILIKE 'Dinheiro à vista';

--31. Clientes que efetuaram alguma compra cujo algum dos produtos comprados tenha sido da fornecedora ASUS
SELECT p.nome cliente FROM Pessoa p JOIN Realiza_Venda rv ON p.cpf = rv.cpf_cliente
JOIN Venda v ON rv.id_venda = v.id JOIN Item_Venda iv ON v.id = iv.id_venda
JOIN Produto pr ON iv.id_produto = pr.id JOIN Fornecedor f ON f.cnpj = pr.cnpj_fornecedor
WHERE f.nome ILIKE 'ASUS';

--32. Clientes que compraram mais de um produto numa mesma compra
SELECT p.nome cliente FROM Pessoa p JOIN Realiza_Venda rv ON p.cpf = rv.cpf_cliente
JOIN Venda v ON rv.id_venda = v.id JOIN Item_Venda iv ON iv.id_venda = v.id
WHERE iv.quantidade>1

--33. Clientes que efetuaram uma compra dividido em 12x
SELECT p.nome cliente FROM Pessoa p JOIN Realiza_Venda rv ON p.cpf = rv.cpf_cliente
JOIN Venda v ON rv.id_venda = v.id JOIN Forma_Pagamento fp ON fp.id = v.id_formaPagamento
WHERE num_parcelas=10;

--34. diminuir o salario em 100 reais para os funcionários que não tiverem realizado nem uma venda
UPDATE FUNCIONARIO f SET salario_Base=salario_Base-100 WHERE cpf_pessoa NOT IN
(SELECT rv.cpf_funcionario FROM Realiza_Venda rv);

--35. dar desconto de 10% no valor total da compra de um cliente que tiver comprado mais de 1 produto da motorola
UPDATE valor=valor*0.85 FROM Venda JOIN Item_Venda iv ON id = iv.id_venda
JOIN Produto p ON iv.id_produto = p.id JOIN Fornecedor f ON p.cnpj_fornecedor = f.cnpj
WHERE f.nome ILIKE 'MOTOROLA';

--36. Funcionario que vendeu mais de 2 produtos em um único dia
SELECT p.nome, SUM(iv.quantidade)
FROM Pessoa p JOIN Realiza_Venda rv ON p.cpf = rv.cpf_funcionario
JOIN Venda v ON rv.id_venda = v.id JOIN Item_venda iv ON v.id = iv.id_venda
GROUP BY p.nome, rv.data HAVING COUNT(*)>2

--37. Clientes mulher seguido dos produtos comprados
SELECT pe.nome cliente, pr.nome produto
FROM Pessoa pe JOIN Cliente c ON pe.cpf = c.cpf_pessoa
JOIN realiza_venda rv ON c.cpf_pessoa = rv.cpf_cliente
JOIN Venda v ON rv.id_venda = v.id
JOIN Item_venda iv ON v.id = iv.id_venda
JOIN Produto pr ON iv.id_produto = pr.id
WHERE pe.sexo='F'

--38. Cliente que mais consumiu na loja
SELECT pe.nome, sum(iv.quantidade*pr.preco) consumo_total
FROM Pessoa pe JOIN Cliente c ON pe.cpf = c.cpf_pessoa
JOIN realiza_venda rv ON c.cpf_pessoa = rv.cpf_cliente
JOIN Venda v ON rv.id_venda = v.id
JOIN Item_venda iv ON v.id = iv.id_venda
JOIN Produto pr ON iv.id_produto = pr.id
GROUP BY pe.cpf ORDER BY consumo_total DESC LIMIT 1

--39. media dos preços dos produtos fornecidos pela Motorola
SELECT avg(p.preco) media_preco
FROM Fornecedor f JOIN Produto p ON f.cnpj = p.cnpj_fornecedor
WHERE f.nome='Motorola'

--40. Venda de maior custo
SELECT id, valor FROM Venda ORDER BY valor DESC LIMIT 1

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
SELECT p.nome, SUM(iv.quantidade) quantidade FROM Produto p JOIN Item_venda iv ON p.id = iv.id_produto
GROUP BY p.id 
ORDER BY quantidade DESC

--45. Identificar quais Funcionarios venderam aos clientes de João Pessoa
SELECT p.nome FROM Pessoa p JOIN Funcionario f ON p.cpf = f.cpf_pessoa
JOIN realiza_venda rv ON f.cpf_pessoa = rv.cpf_funcionario 
JOIN (SELECT cpf, cidade FROM Pessoa JOIN Cliente ON cpf = cpf_pessoa) as c ON c.cpf = rv.cpf_cliente
WHERE c.cidade = 'João Pessoa'

--46. Produto que é mais comprado por clientes do sexo feminino
SELECT b.nome, b.quantidade_venda*iv.quantidade quantidade FROM (SELECT pr.id,pr.nome, COUNT(pr.id) quantidade_venda
FROM Pessoa pe JOIN Cliente c ON pe.cpf = c.cpf_pessoa JOIN realiza_venda rv ON c.cpf_pessoa = rv.cpf_cliente
JOIN Venda v ON rv.id_venda = v.id JOIN Item_venda iv ON v.id = iv.id_venda
JOIN Produto pr ON iv.id_produto = pr.id WHERE pe.sexo='F' GROUP BY pr.id) as b 
JOIN Item_venda iv ON b.id = iv.id_produto ORDER BY quantidade DESC LIMIT 1

--47. Média do consumo dos clientes do sexo feminino
SELECT p.nome cliente, AVG(v.valor) media_gasto
FROM Pessoa p JOIN Realiza_Venda rv ON p.cpf = rv.cpf_cliente
JOIN Venda v ON rv.id_venda = v.id WHERE p.sexo='F'
GROUP BY p.nome

--48. Produto que cuja que deu mais lucro a loja *prod_Vendas é uma VIEW*
SELECT p.nome, p.unidades_vendidas*pr.preco valor_total 
FROM prod_Vendas p NATURAL JOIN Produto pr
ORDER BY valor_total DESC LIMIT 1

--Outras Consultas para Mostrar a Janderson

-- 1) Mostre como ficaria o nome, a descrição e os preços de TV que não são FULL HD e o nome, descrição e -- preços com 5% de desconto de TV que são FULL HD
select nome, descricao, preco
from produto 
where nome ilike'%TV%' and descricao not ilike '%FULL HD%'
UNION
select nome, descricao, preco * .95
from produto 
where nome ilike'%TV%' and descricao ilike '%FULL HD%'

-- 2) Quais os fornecedores tem produtos presentes em apenas 1 departamento da loja? 
select f.nome, count (distinct d.id) as num_dep
from produto p, fornecedor f, departamento d
where p.id_departamento=d.id and p.cnpj_fornecedor = f.cnpj
group by f.nome
having count (distinct d.id) = 1


-- 3) Qual a média de vendas do mês de Outubro
select avg(v.valor) as media_vendas
from venda v, realiza_venda rv
where v.id = rv.id_venda and 
   rv.data between to_date('01/10/2015', 'dd/mm/yyyy') and to_date('30/10/2015', 'dd/mm/yyyy')


-- 4) Mostre o numero de vendas e o valor total delas agrupado por data e funcionário responsavel pela venda
select data, nome as vendedor, count(id) as num_vendas, sum(valor) as total_vendas 
from realiza_venda join venda on id_venda = id 
   join funcionario on cpf_funcionario = cpf_pessoa join pessoa on cpf=cpf_pessoa
group by data, nome


-- 5) Mostre o numero total de vendas que cada funcionário fez. Se um funcionario nao fez nenhuma venda, imprimir
-- seu nome seguido do valor 0
select nome as vendedor, count (id_venda) as num_vendas
from funcionario join pessoa on cpf_pessoa = cpf left outer join realiza_venda on cpf_pessoa=cpf_funcionario
group by nome


-- 6) Qual departamento teve menor numero de itens de vendas (volume de vendas)?
select d.nome, sum(iv.quantidade)
from item_venda iv join produto p on iv.id_produto = p.id 
   join departamento d on p.id_departamento = d.id 
group by d.nome
order by sum(iv.quantidade) 
limit 1


-- 7) Mostrar total de itens vendidos por departamento
select d.nome, sum(iv.quantidade)
from item_venda iv join produto p on iv.id_produto = p.id 
   join departamento d on p.id_departamento = d.id 
group by d.nome


-- 8) Mostrar a quantidade de pagamento que os utilizaram uma determinada forma de pagamento e a media 
-- do valor das vendas de cada tipo de forma de pagamento. 
select fp.tipo as forma_pagmto, count (*) as qnt_vendas
from item_venda iv join venda v on iv.id_venda = v.id 
join forma_pagamento fp on fp.id = v.id_formapagamento
group by fp.tipo


-- 9) mostre o nome e cpf dos clientes que nao fizeram nenhuma venda
select nome as cliente, cpf_pessoa as cpf
from pessoa join 
(
(select cpf_pessoa from cliente)
except 
(select c.cpf_pessoa
from cliente c, realiza_venda rv
where c.cpf_pessoa = rv.cpf_cliente)
) as clientes_sem_venda
on cpf = clientes_sem_venda.cpf_pessoa










   
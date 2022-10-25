-- Trigger 
-- -----------------------------------------------------------------------------------------------
create table historicoF_S(
	id int not null auto_increment,
	id_FS int not null,
    serie_filme varchar(45),
    nome varchar(80) not null,
    ano int not null,
    classificacao char(2) not null,
    preco_locacao decimal(5,2) not null,
    num_tem int,
    produtora int not null,
    genero int not null,
    acao varchar(20),
    data_modificacao varchar(45),
    primary key(id)
);

-- -----------------------------------------------------------------------------------------------
delimiter $
create trigger tgg_historico_filme 
before delete on filme
for each row
begin
	insert into historicoF_S
    set acao = 'Delete',
    id_FS = old.id,
    serie_filme = 'Filme',
	nome = old.nome,
    ano = old.ano,
    classificacao = old.classificacao,
    preco_locacao = old.preco_locacao,
    produtora = old.produtora_id,
    genero = old.genero_id,
    data_modificacao = now();
end $
delimiter ;

-- -------------------------------------------------------------------------------------------------
delimiter $
create trigger tgg_historico_serie
before delete on serie
for each row
begin
	insert into historicoF_S
    set acao = 'Delete',
    id_FS = old.id,
    serie_filme = 'Série',
	nome = old.nome,
    ano = old.ano,
    classificacao = old.classificacao,
    preco_locacao = old.preco_locacao,
    num_tem = old.num_temp,
    produtora = old.produtora_id,
    genero = old.genero_id,
    data_modificacao = now();
end $
delimiter ;

-- -------------------------------------------------------------------------------------------------
delimiter $
create trigger tgg_historico_serieUp
before update on serie
for each row
begin
	insert into historicoF_S
    set acao = 'Update',
    id_FS = old.id,
    serie_filme = 'Série',
	nome = old.nome,
    ano = old.ano,
    classificacao = old.classificacao,
    preco_locacao = old.preco_locacao,
    num_tem = old.num_temp,
    produtora = old.produtora_id,
    genero = old.genero_id,
    data_modificacao = now();
end $
delimiter ;

-- -------------------------------------------------------------------------------------------------
delimiter $
create trigger tgg_historico_filmeUp
before update on filme
for each row
begin
	insert into historicoF_S
    set acao = 'Update',
    id_FS = old.id,
    serie_filme = 'Filme',
	nome = old.nome,
    ano = old.ano,
    classificacao = old.classificacao,
    preco_locacao = old.preco_locacao,
    produtora = old.produtora_id,
    genero = old.genero_id,
    data_modificacao = now();
end $
delimiter ;

-- -------------------------------------------------------------------------------------------------
-- Prcedure 

DELIMITER $
CREATE PROCEDURE sp_historico_cliente(in nome_cliente VARCHAR(45))
BEGIN
	select c.nome as cliente, count(l.id) as qt_locaçâo, l.valor as valor_total 
	from cliente c left join locacao l on c.id = l.cliente_id
    where c.nome = nome_cliente
	group by c.nome;
    
END $
DELIMITER ;

CALL sp_historico_cliente("Ruan Ian Moura");

-- -------------------------------------------------------------------------------------------------

-- VIEW

-- A VIEW retorna o nome dos clientes o nome do filme alugado e o valor unitário de cada filme.
create view vw_filmes_alugados_clientes as
select c.nome as cliente, f.nome as filme, f.preco_locacao as preco_un
from cliente c inner join locacao l on c.id = l.cliente_id
inner join locacao_filme lf on l.id = lf.locacao_id 
inner join filme f on lf.filme_id = f.id
order by c.nome;

SELECT * FROM vw_filmes_alugados_clientes;


-- A VIEW retorna o nome dos clientes o nome do serie alugada e o valor unitário de cada serie.


create view vw_series_alugadas_clientes as
select c.nome as cliente, f.nome as serie, f.preco_locacao as preço_un
from cliente c inner join locacao l on c.id = l.cliente_id
inner join locacao_filme lf on l.id = lf.locacao_id 
inner join serie f on lf.filme_id = f.id
order by c.nome;

SELECT * FROM vw_series_alugadas_clientes;


-- A VIEW vai retornar os filmes que foram alugados entre 2021 até a data atual 

create view vw_filme_alugado_data as
select f.nome as filme, l.data_inicio as data_locação from locacao l 
inner join locacao_filme lf on l.id = lf.locacao_id
inner join filme f on lf.filme_id = f.id
where l.data_inicio between ('2021-01-01') and (curdate())
order by f.nome;

SELECT * FROM vw_filme_alugado_data;
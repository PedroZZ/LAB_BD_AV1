create database paulista
go
use paulista

create table times(
codigoTime int not null,
nomeTime varchar(100) not null,
cidade varchar(100) not null,
estadio varchar(100) not null
primary key (codigoTime))

create table grupos(
id int,
grupo varchar(1) check (grupo = 'A' or grupo = 'B'
				 or grupo = 'C' or grupo = 'D') not null,
codigoTime int not null
primary key(id,codigoTime)
foreign key ( codigoTime ) references times(codigoTime)) 

create table jogos(
codigoJogo int identity not null,
codigoTimeA int not null,
codigoTimeB int not null,
golsTimeA int,
golsTimeB int,
data datetime not null	
primary key (codigoJogo))

insert into times values
( 1, 'Audax', 'São Paulo', 'José Liberatti' ),
( 2, 'Botafogo', 'Ribeirão Preto', 'Santa Cruz' ),
( 3, 'Bragantino', 'Bragança Paulista', 'Nabi Abi Chedid' ),
( 4, 'Capivariano', 'Capivari', 'Arena Capivari' ),
( 5, 'Corinthians', 'São Paulo', 'Arena Corinthians' ),
( 6, 'Ituano', 'Itu', 'Novelli Júnior' ),
( 7, 'Linense', 'Lins', 'Gilberto Siqueira Lopes' ),
( 8, 'Marília', 'Marília', 'Bento de Abreu' ),
( 9, 'Mogi Mirim', 'Mogi Mirim', 'Vail Chaves' ),
( 10, 'Palmeiras', 'São Paulo', 'Allians Parque' ),
( 11, 'Penapolense', 'Penápolis', 'Tenente Carriço' ),
( 12, 'Ponte Preta', 'Campinas', 'Moisés Lucarelli' ),
( 13, 'Portuguesa', 'São Paulo', 'Canindé' ),
( 14, 'Red Bull Brasil', 'Campinas', 'Moisés Lucarelli' ),
( 15, 'Rio Claro', 'Rio Claro', 'Augusto Schmidt Filho' ),
( 16, 'Santos', 'Santos', 'Vila Belmiro' ),
( 17, 'São Bento', 'Sorocaba', 'Walter Ribeiro' ),
( 18, 'São bernardo', 'São Bernardo do Campo', 'Primeiro de Maio' ),
( 19, 'São Paulo', 'São Paulo', 'Morumbi' ),
( 20, 'XV de Piracicaba', 'Piracicaba', 'Barão de Serra Negra' )
	
-----------------------------------------------------------------------------------------------

create procedure sp_sorteioGrupos
as

truncate table grupos
    declare @grupo varchar(1)
	declare @cod int
	declare @id int
	delete grupos
	delete jogos
	set @grupo = 'A'
	set @id = 1
	--cabeça de grupo

	while ( (select count(codigoTime) from grupos) < 4 )
	begin

		set @cod = (select top 1 codigoTime from times where nomeTime like 'São Paulo' or
	    nomeTime like 'Santos' or nomeTime like 'Palmeiras' or nomeTime like 'Corinthians' order by newid())

		if not ( exists(select codigoTime from grupos where codigoTime = @cod) )
		begin
			insert into grupos values (@id,@grupo, @cod)

			if(@grupo like 'A')
			begin
				set @grupo = 'B'
				set @id = 2
			end
			else if(@grupo like 'B')
			begin
				set @grupo = 'C'
				set @id = 3
			end
			else if(@grupo like 'C')
			begin
				set @grupo = 'D'
				set @id = 4
			end
			else if(@grupo like 'D')
			begin
				set @grupo = 'A'
				set @id = 1
			end
		end

	end

	--grupo

	while ( (select count(codigoTime) from grupos) < 20 )
	begin
		set @cod = (select top 1 codigoTime from times order by newid())
		if not ( exists(select codigoTime from grupos where codigoTime = @cod) )
		begin
		   insert into grupos values (@id,@grupo, @cod)

		   	if(@grupo like 'A')
			begin
				set @grupo = 'B'
				set @id = 2
			end
			else if(@grupo like 'B')
			begin
				set @grupo = 'C'
				set @id = 3
			end
			else if(@grupo like 'C')
			begin
				set @grupo = 'D'
				set @id = 4
			end
			else if(@grupo like 'D')
			begin
				set @grupo = 'A'
				set @id = 1
			end
		end
	end

	select * from grupos 
	

----------------------fim da sp

-----------------------------------------

create procedure sp_jogos(@data datetime)
as

declare @timeA int, @timeB int
declare @count int, @count2 int
set @count = 1
set @count2 = 1
--enquanto não acontecer 10 jogos nesta data
while ( (select count(codigoJogo) from jogos where data = @data) < 10 )
begin
    --randomiza os 2 times
	set @timeA = (select cast(RAND()*20 as int)+1)
	set @timeB = (select cast(RAND()*20 as int)+1)

	--verifica se são o mesmo time
	while (@timeA = @timeB or

	--verifica se são do mesmo grupo
	((select id from grupos where codigoTime = @timeA) = (select id from grupos where codigoTime = @timeB)) or 

	--verifica se já joraram na data
	(exists(select codigoTimeA from jogos where (codigotimeA = @timeA) and data = @data) or
	exists(select codigoTimeA from jogos where (codigotimeA = @timeb) and data = @data) or
	exists(select codigoTimeB from jogos where (codigoTimeB = @timeA) and data = @data) or
	exists(select codigoTimeB from jogos where (codigoTimeB = @timeB) and data = @data) ) or

	--verica se ambos times já se enfrentaram  
	( exists(select codigoJogo from jogos where codigoTimeA = @timeA and codigoTimeB = @timeB) or
	exists(select codigoJogo from jogos where codigoTimeA = @timeB and codigoTimeB = @timeA)) 
	)
	begin
	    set @timeA = (select cast(RAND()*20 as int)+1)
		set @timeB = (select cast(RAND()*20 as int)+1)
		set @count = @count +1
		--print convert(varchar(5), @count)
		--Caso a query entre em loop pelo motivo de
		--o ultimo confronto, a ser sorteado na rodada,
		--não pode ser sorteado pq já ocorreu em outra data
		if(@count = 1500) --validação
		begin
		if not((select count(codigoJogo) from jogos) = 149 or (select count(codigoJogo) from jogos) = 139)
			begin
				delete from jogos where data = @data
				set @count = (select count(codigoJogo) from jogos)
				DBCC CHECKIDENT ('jogos', RESEED, @count) --reseta o indice identity das chaves
				print 'resetado'
				set @count = 1
			end
			else --caso o ultimo jogo não possa ser efetuado
			begin
				if ((select count(codigoJogo) from jogos) = 139) --da uma chance ao 139 se recompor
					begin
					set @count2 = @count2 + 1
					if(@count2 = 15)
					begin
						truncate table jogos
						DBCC CHECKIDENT ('jogos', RESEED, 1) --reseta o indice identity das chaves
						exec sp_datasJogos
						return
					end
					else
					begin
					   	delete from jogos where data = @data
						set @count = (select count(codigoJogo) from jogos)
						DBCC CHECKIDENT ('jogos', RESEED, @count) --reseta o indice identity das chaves
						print 'resetado'
                    end
				end
				else
					begin
					truncate table jogos
					DBCC CHECKIDENT ('jogos', RESEED, 1) --reseta o indice identity das chaves
					exec sp_datasJogos
					return
				end
			end
			
		end
	end
				insert into jogos values (@timeA, @timeb, null, null, @data) -- INSERIDO
				print 'inserido'
end

select * from jogos where data = @data
------------------------
/* BACKUP
alter procedure sp_jogos(@data datetime)
as

declare @timeA int, @timeB int
declare @count int
set @count = 1
--enquanto não acontecer 10 jogos nesta data
while ( (select count(codigoJogo) from jogos where data = @data) < 10 )
begin
    --randomiza os 2 times
	set @timeA = (select cast(RAND()*20 as int)+1)
	set @timeB = (select cast(RAND()*20 as int)+1)

	--verifica se são o mesmo time
	while (@timeA = @timeB or

	--verifica se são do mesmo grupo
	((select id from grupos where codigoTime = @timeA) = (select id from grupos where codigoTime = @timeB)) or 

	--verifica se já joraram na data
	(exists(select codigoTimeA from jogos where (codigotimeA = @timeA) and data = @data) or
	exists(select codigoTimeA from jogos where (codigotimeA = @timeb) and data = @data) or
	exists(select codigoTimeB from jogos where (codigoTimeB = @timeA) and data = @data) or
	exists(select codigoTimeB from jogos where (codigoTimeB = @timeB) and data = @data) ) or

	--verica se ambos times já se enfrentaram  
	( exists(select codigoJogo from jogos where codigoTimeA = @timeA and codigoTimeB = @timeB) or
	exists(select codigoJogo from jogos where codigoTimeA = @timeB and codigoTimeB = @timeA)) 
	)
	begin
	    set @timeA = (select cast(RAND()*20 as int)+1)
		set @timeB = (select cast(RAND()*20 as int)+1)
		set @count = @count +1
		--print convert(varchar(5), @count)
		--Caso a query entre em loop pelo motivo de
		--o ultimo confronto, a ser sorteado na rodada,
		--não pode ser sorteado pq já ocorreu em outra data
		if(@count = 1500) --validação
		begin
		--	if(not(select count(codigoJogo) from jogos) = 149 or (select count(codigoJogo) from jogos) = 139)
		--	begin
				delete from jogos where data = @data
				set @count = (select count(codigoJogo) from jogos)
				DBCC CHECKIDENT ('jogos', RESEED, @count) --reseta o indice identity das chaves
				print 'resetado'
				set @count = 1
			--end
			--else --caso o ultimo jogo não possa ser efetuado
			--begin
			--	truncate table jogos
			--	DBCC CHECKIDENT ('jogos', RESEED, 1) --reseta o indice identity das chaves
		--	end
			
		end
	end
				insert into jogos values (@timeA, @timeb, null, null, @data) -- INSERIDO
				print 'inserido'
end

select * from jogos where data = @data

*/
------------------------ fim da sp

--------------------------
create procedure sp_datasJogos
as

truncate table jogos
declare @data date, @dataInicio date, @dataFim date

set @dataInicio = '01/02/2015'
set @dataFim = '22/03/2015'
set @data = @dataInicio

exec sp_jogos @dataInicio

while (@data < @dataFim)
begin
	if(datename(WEEKDAY, @data) like 'Domingo')
	begin
		set @data = (select dateadd(day,3,@data))
		exec sp_jogos @data
	end
	else
	begin
		set @data =(select dateadd(day,4,@data))
		exec sp_jogos @data
	end
end

-------------fim da sp

--   P2  -----------------------------------------------------

--pausar a trigger
disable trigger t_jogos on jogos
disable trigger t_times on times
disable trigger t_grupos on grupos


--voltar a trigger
enable trigger t_jogos on jogos
enable trigger t_times on times
enable trigger t_grupos on grupos


------------------------
create trigger t_times
on times
instead of insert, update, delete
as
begin
	raiserror('Impossível Interagir com os dados',16,1)
end
------------------------
create trigger t_grupos
on grupos
instead of insert, update, delete
as
begin
	raiserror('Impossível Interagir com os dados',16,1)
end
------------------------
create trigger t_jogos
on jogos
instead of insert, delete
as
begin
	raiserror('Impossível Inserir ou deletar dados!',16,1)
end

----------------
--calcula o numero de jogos disputados por um determinado time
create function fn_numJogosDisputados(@codigoTime int)
returns int
as
begin
	return (select count(codigoJogo) from jogos jg where jg.codigoTimeA = @codigoTime and jg.golsTimeA is not null)+
	(select count(codigoJogo) from jogos jg where jg.codigoTimeB = @codigoTime and jg.golsTimeB is not null)
end
---------------
--calcula as vitorias de um determinado time
create function fn_vitorias(@codigoTime int)
returns int
as
begin
	declare @A int
	declare @B int
	set @A = (select count(codigoJogo) from jogos where codigoTimeA = @codigoTime and golsTimeA is not null and golsTimeA > golsTimeB)
	set @B = (select count(codigoJogo) from jogos where codigoTimeB = @codigoTime and golsTimeB is not null and golsTimeB > golsTimeA)
	
	if(@A is null)
	begin
		set @A = 0
	end
	if(@B is null)
	begin
		set @B = 0
	end

	return @A+@B

end
------------------------
--calcula os empates de um determinado time
create function fn_empates(@codigoTime int)
returns int
as
begin
	declare @A int
	declare @B int
	set @A = (select count(codigoJogo) from jogos where codigoTimeA = @codigoTime and golsTimeA is not null and golsTimeA = golsTimeB)
	set @B = (select count(codigoJogo) from jogos where codigoTimeB = @codigoTime and golsTimeB is not null and golsTimeB = golsTimeA)
	
	if(@A is null)
	begin
		set @A = 0
	end
	if(@B is null)
	begin
		set @B = 0
	end

	return @A+@B

end
------------------------
--calcula as derrotas de um determinado time
create function fn_derrotas(@codigoTime int)
returns int
as
begin
	declare @A int
	declare @B int
	set @A = (select count(codigoJogo) from jogos where codigoTimeA = @codigoTime and golsTimeA is not null and golsTimeA < golsTimeB)
	set @B = (select count(codigoJogo) from jogos where codigoTimeB = @codigoTime and golsTimeB is not null and golsTimeB < golsTimeA)
	
	if(@A is null)
	begin
		set @A = 0
	end
	if(@B is null)
	begin
		set @B = 0
	end

	return @A+@B

end
------------------------

--calcula a quantidade de gols marcados por um determinado time
alter function fn_gols_marcados(@codigoTime int)
returns int
as
begin
	declare @A int
	declare @B int

	set @A = (select sum(golsTimeA) from jogos where codigoTimeA = @codigoTime and golsTimeA is not null)
	set @B = (select sum(golsTimeB) from jogos where codigoTimeB = @codigoTime and golsTimeB is not null)

	if(@A is null)
	begin
		set @A = 0
	end
	if(@B is null)
	begin
		set @B = 0
	end

	return @A+@B
end

------------------------
--calcula a quantidade de gols sofridos por um determinado time
create function fn_gols_sofrido(@codigoTime int)
returns int
as
begin
	declare @A int
	declare @B int

	set @A = (select sum(golsTimeB) from jogos where codigoTimeA = @codigoTime and golsTimeB is not null)
	set @B = (select sum(golsTimeA) from jogos where codigoTimeB = @codigoTime and golsTimeA is not null)

	if(@A is null)
	begin
		set @A = 0
	end
	if(@B is null)
	begin
		set @B = 0
	end

	return @A+@B
end
--------------------------------
--calcula os pontos
create function fn_pontos(@codigoTime int)
returns int
as
begin
	declare @vitoria int
	declare @empate int
	declare @derrota int
	set @vitoria = (select dbo.fn_vitorias(@codigoTime)) 
	set @empate = (select dbo.fn_empates(@codigoTime))
	set @derrota= (select dbo.fn_derrotas(@codigoTime))

	return ((@vitoria*3)+@empate)
--(Vitória = 3 pontos, Empate = 1 ponto , Derrota = 0 pontos)
end

------------------------

--retorna um grupo ordenado pelos pontos
create function fn_grupo(@grupo varchar(1))
returns @tabela table(
nome_time varchar(100),
num_jogos_disputados int,
vitorias int,
empates int,
derrotas int,
gols_marcados int,
gols_sofridos int,
saldo_gols int,
pontos int)
as

begin

	insert into @tabela
	select tm.nomeTime, (select dbo.fn_numJogosDisputados(tm.codigoTime)) as num_jogos_disputados,
	(select dbo.fn_vitorias(tm.codigoTime)) as vitorias,
	(select dbo.fn_empates(tm.codigoTime)) as empates,
	(select dbo.fn_derrotas(tm.codigoTime)) as derrotas,
	(select dbo.fn_gols_marcados(tm.codigoTime)) as gols_marcados,
	(select dbo.fn_gols_sofrido(tm.codigoTime)) as gols_sofrido,
	((select dbo.fn_gols_marcados(tm.codigoTime)) - (select dbo.fn_gols_sofrido(tm.codigoTime))) as saldo_gols,
	(select dbo.fn_pontos(tm.codigoTime)) as pontos from times tm
	inner join grupos gp
	on gp.codigoTime = tm.codigoTime 
	where gp.grupo like @grupo
	order by pontos desc

	return

end

select * from dbo.fn_campeonato()
-----------------
--retorna o rank do campeonato a partir dos pontos
create function fn_campeonato()
returns @tabela table(
nome_time varchar(100),
num_jogos_disputados int,
vitorias int,
empates int,
derrotas int,
gols_marcados int,
gols_sofridos int,
saldo_gols int,
pontos int)
as

begin

	insert into @tabela
	select tm.nomeTime, (select dbo.fn_numJogosDisputados(tm.codigoTime)) as num_jogos_disputados,
	(select dbo.fn_vitorias(tm.codigoTime)) as vitorias,
	(select dbo.fn_empates(tm.codigoTime)) as empates,
	(select dbo.fn_derrotas(tm.codigoTime)) as derrotas,
	(select dbo.fn_gols_marcados(tm.codigoTime)) as gols_marcados,
	(select dbo.fn_gols_sofrido(tm.codigoTime)) as gols_sofrido,
	((select dbo.fn_gols_marcados(tm.codigoTime)) - (select dbo.fn_gols_sofrido(tm.codigoTime))) as saldo_gols,
	(select dbo.fn_pontos(tm.codigoTime)) as pontos from times tm order by pontos desc

	return

end

-----------------

--Retorna em 1 linha os times de um determinado grupo que irão se enfrentar nas quartas
create function fn_quartas(@grupo varchar(1))
returns @tabela table(
timeA varchar(100),
timeB varchar(100)
)
begin
	declare @timeA varchar(100)
	declare @timeB varchar(100)
	set @timeA = (select top 1 nome_time from (select * from dbo.fn_quartasdefinal(@grupo)) as timeA order by pontos desc, vitorias desc, gols_marcados desc, saldo_gols desc)
	set @timeB = ((select top 2 nome_time from (select * from dbo.fn_quartasdefinal(@grupo)) as timeB
	order by pontos asc, vitorias asc, gols_marcados asc, saldo_gols asc)
	EXCEPT 
	(select top 1 nome_time from (select * from dbo.fn_quartasdefinal(@grupo)) as timeA order by pontos desc, vitorias desc, gols_marcados desc, saldo_gols desc))
	insert into @tabela values (@timeA, @timeB)
	return

end

---------------------------------
--retorna os 2 times que irão particiar de quarta de final(por grupo)
--ou seja, deve ser executada 4 vezes, uma para cara grupo como parametro
create function fn_quartasdefinal(@grupo varchar(1))
returns @tabela table(
nome_time varchar(100),
num_jogos_disputados int,
vitorias int,
empates int,
derrotas int,
gols_marcados int,
gols_sofridos int,
saldo_gols int,
pontos int)
as
begin 

	insert into @tabela
	select top 2 tm.nomeTime, (select dbo.fn_numJogosDisputados(tm.codigoTime)) as num_jogos_disputados,
	(select dbo.fn_vitorias(tm.codigoTime)) as vitorias,
	(select dbo.fn_empates(tm.codigoTime)) as empates,
	(select dbo.fn_derrotas(tm.codigoTime)) as derrotas,
	(select dbo.fn_gols_marcados(tm.codigoTime)) as gols_marcados,
	(select dbo.fn_gols_sofrido(tm.codigoTime)) as gols_sofridos,
	((select dbo.fn_gols_marcados(tm.codigoTime)) - (select dbo.fn_gols_sofrido(tm.codigoTime))) as saldo_gols,
	(select dbo.fn_pontos(tm.codigoTime)) as pontos from times tm
		inner join grupos gp
	on gp.codigoTime = tm.codigoTime 
	where gp.grupo like @grupo
	order by pontos desc, vitorias desc, gols_marcados desc, saldo_gols desc
	return
end
-----------------
--rebaixados
--retorna os 4 times rebaixados
create function fn_rebaixados()
returns @tabela table(
nome_time varchar(100),
num_jogos_disputados int,
vitorias int,
empates int,
derrotas int,
gols_marcados int,
gols_sofridos int,
saldo_gols int,
pontos int)

begin
	insert into @tabela
	select top 4 tm.nomeTime, (select dbo.fn_numJogosDisputados(tm.codigoTime)) as num_jogos_disputados,
	(select dbo.fn_vitorias(tm.codigoTime)) as vitorias,
	(select dbo.fn_empates(tm.codigoTime)) as empates,
	(select dbo.fn_derrotas(tm.codigoTime)) as derrotas,
	(select dbo.fn_gols_marcados(tm.codigoTime)) as gols_marcados,
	(select dbo.fn_gols_sofrido(tm.codigoTime)) as gols_sofrido,
	((select dbo.fn_gols_marcados(tm.codigoTime)) - (select dbo.fn_gols_sofrido(tm.codigoTime))) as saldo_gols,
	(select dbo.fn_pontos(tm.codigoTime)) as pontos from times tm
    inner join grupos gp
	on gp.codigoTime = tm.codigoTime 
	order by pontos, vitorias, gols_marcados, saldo_gols
	return
end
----------------


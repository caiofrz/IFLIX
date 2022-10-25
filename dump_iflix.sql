CREATE DATABASE iflix;
-- ----------------------------------------------------
CREATE TABLE cliente(
	id INT NOT NULL AUTO_INCREMENT, 
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    cpf VARCHAR(15) NOT NULL,
	data_nasc DATE NOT NULL,
    telefone VARCHAR(13),
    PRIMARY KEY(id)
);
-- ----------------------------------------------------
CREATE TABLE login(
	cliente_id INT AUTO_INCREMENT, 
    usuario VARCHAR(20),
    senha VARCHAR(20),
    PRIMARY KEY(cliente_id),
    FOREIGN KEY(cliente_id) REFERENCES cliente(id)
);
-- ----------------------------------------------------
CREATE TABLE locacao(
	id INT NOT NULL AUTO_INCREMENT,
	data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    valor DECIMAL(5,2),
    cliente_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY (cliente_id) REFERENCES cliente (id)
);
-- ----------------------------------------------------
CREATE TABLE produtora(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45),
    PRIMARY KEY(id)
);
-- ----------------------------------------------------
CREATE TABLE genero(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45),
    PRIMARY KEY(id)
);
-- ----------------------------------------------------
CREATE TABLE filme(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80),
    ano INT,
    classificacao CHAR(2),
    preco_locacao DECIMAL(5,2),
    produtora_id INT,
    genero_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY (produtora_id) REFERENCES produtora(id),
    FOREIGN KEY (genero_id) REFERENCES genero(id)
);
-- ----------------------------------------------------
CREATE TABLE serie(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80),
    ano INT,
    classificacao CHAR(2),
    preco_locacao DECIMAL(5,2),
    num_temp INT,
    produtora_id INT,
    genero_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY (produtora_id) REFERENCES produtora(id),
    FOREIGN KEY (genero_id) REFERENCES genero(id)
);
-- ----------------------------------------------------
CREATE TABLE locacao_filme(
	locacao_id INT NOT NULL,
    filme_id INT NOT NULL,
    PRIMARY KEY(locacao_id, filme_id),
    FOREIGN KEY (locacao_id) REFERENCES locacao (id),
    FOREIGN KEY (filme_id) REFERENCES filme (id)
);
-- ----------------------------------------------------
CREATE TABLE locacao_serie(
	locacao_id INT NOT NULL,
    serie_id INT NOT NULL,
    PRIMARY KEY(locacao_id, serie_id),
    FOREIGN KEY (locacao_id) REFERENCES locacao (id),
    FOREIGN KEY (serie_id) REFERENCES serie (id)
);
-- ----------------------------------------------------------------------------------------------------------------------------------
create table historicoF_S(
	id int not null auto_increment,
    id_filme int,
	id_serie int,
    nome varchar(80) not null,
    ano int not null,
    classificacao char(2) not null,
    preco_locacao decimal(5,2) not null,
    num_tem int,
    produtora int not null,
    genero int not null,
    acao varchar(20),
    data_modificacao varchar(45),
    primary key(id),
    foreign key(id_filme) references filme (id),
    foreign key(id_serie) references serie (id),
    foreign key(produtora) references produtora (id),
    foreign key(genero) references genero (id)
);
-- ----------------------------------------------------------------------------------------------------------------------------------
INSERT INTO cliente VALUES 
(default,'Ruan Ian Moura', 'ruanianmoura@gmail.com.br', '171.646.227-44','1990-04-24', '(84)2906-5319'),
(default,'Filipe Daniel Martin Gonçalves', 'filipe_daniel_goncalves@gmail.com', '815.421.475-06', '1964-03-26', '(31)2519-8745'),
(default,'Danilo Nathan Melo', 'danilo-melo97@gmail.com', '746.333.082-62', '1960-05-02', '(21)3667-2177'),
(default,'Oliver Carlos Teixeira', 'oliver_carlos_teixeira@gmail.com', '265.713.174-35', '1986-04-02', '(51)3908-1726'),
(default,'Kevin Ian da Rocha', 'keviniandarocha@gmail.com.br', '520.940.857-40', '1996-07-15', '(73)9494-6891'),
(default,'Flávio Nunes Costa','flavionunes446@gmail.com', '467.021.836-62', '1996-01-13', '(33)987267512'),
(default,'Edson Anthony Kaique Araújo', 'edson.anthony.araujo@gmail.com', '469.729.585-47', '1998-01-28', '(95)2668-4437'),
(default,'Arthur Lucca Manuel da Conceição', 'arthur.lucca.daconceicao@gmail.com', '032.333.473-32', '1986-03-05', '(61)8203-4523'),
(default,'Giovanni Bernardo Nicolas Assunção', 'giovanni-assuncao93@hotmail.com', '778.599.281-91', '1970-06-15', '(68)3533-8751'),
(default,'Kauê Pietro Santos', 'kauepietrosantos@gmail.com', '946.927.051-75', '1989-02-11', '(67)3907-8334'),
(default,'Vitor Severino Aragão', 'vitor_aragao@hotmail.com.br', '342.719.189-38', '1963-02-01', '(62)3783-8020'),
(default,'Otávio Márcio Pinto', 'otavio.marcio.pinto@gmail.com', '181.872.626-21', '1976-07-20', '(49)2629-1926'),
(default,'Eloá Sônia Silva', 'eloa-silva83@gmail.com.br', '928.448.697-18', '1969-09-10', '(31)2883-5388'),
(default,'Melissa Brenda Carvalho', 'melissa_carvalho@hotmail.com.br', '922.368.167-74', '1998-11-02', '(11)2811-9508'),
(default,'Teresinha Andrea Gomes', 'teresinha_andrea_gomes@gmail.com', '793.576.796-34', '1990-12-25', '(92)2894-6709'),
(default,'Agatha Fátima Isabel Moraes', 'agatha.fatima.moraes@gmail.com', '228.349.169-00', '1985-04-22', '(81)3683-1335'),
(default,'Raimunda Rebeca Brito', 'raimunda_rebeca_brito@hotmail.com.br', '678.067.393-51', '1987-05-01', '(96)3940-7216'),
(default,'Kamilly Giovanna Camila Moura', 'kamillygiovannamoura@gmail.com.br', '750.155.946-58', '2000-02-12', '(95)2564-0025'),
(default,'Sara Brenda Isabel Drumond', 'sara_drumond@gmail.com', '669.108.557-44', '2002-07-24', '(79)2935-1785'),
(default,'Sophie Marcela Viana', 'sophie-viana81@gmail.com', '387.691.331-40', '1996-01-09', '(92)2713-0336'),
(default,'Márcia Ayla da Rocha', 'marcia-darocha74@gmail.com', '836.342.483-86', '1968-01-16', '(69)2891-6777'),
(default,'Cauã Marcos Nunes', 'caua.marcos.nunes@gmail.com.br', '388.979.412-22', '2002-02-06', '(96)2917-2070'),
(default,'Lívia Fátima Tereza Pinto', 'livia.fatima.pinto@hotmail.com', '903.075.584-95', '1991-04-25', '(79)2882-1397'),
(default,'Rita Caroline Lívia Ribeiro', 'rita-ribeiro92@gmail.com', '059.132.585-33', '1985-10-12', '(89)2929-5374'),
(default,'Francisco Augusto Leonardo Duarte', 'francisco_duarte@gmail.com.br', '167.108.976-64', '1950-07-26', '(69)2648-8343'),
(default,'Emanuel Antonio Brito', 'emanuelantoniobrito@hotmail.com', '958.807.663-30', '1961-10-01', '(51)2910-3599'),
(default,'Nelson Enrico Melo', 'nelsonenricomelo@gmail.com.br', '310.358.328-10', '1994-06-16', '(98)3507-9370'),
(default,'Bruna Mirella Jennifer Cavalcanti', 'brunamirellacavalcanti@hotmail.com', '568.451.791-90', '1977-06-07', '(91)3666-0382'),
(default,'Renan Calebe Joaquim Novaes', 'renan-novaes98@gmaill.com', '714.647.240-08', '1989-04-09', '(43)2589-8685'),
(default,'Juan Samuel Iago dos Santos', 'juan-dossantos72@gmail.com.br', '924.553.987-30', '1989-04-15', '(85)9948-6795'),
(default,'Jorge Martin Lima', 'jorge_lima@gmail.com', '477.748.430-00', '1991-01-16', '(42)2665-6564'),
(default,'Cláudio Carlos da Mota', 'claudio_damota@gmaili.com.br', '261.474.760-25', '1960-09-15', '(99)3573-6479'),
(default,'Nina Jéssica Teixeira', 'nina-teixeira89@lexos.com.br', '050.594.508-80', '1974-08-09', '(68)3530-4746'),
(default,'Carolina Kamilly Priscila Peixoto', 'carolina_peixoto@hotmail.com.br', '556.862.485-24', '1981-08-08', '(95)3647-1476'),
(default,'Heloisa Stella Laís Oliveira', 'heloisa.stella.oliveira@gmail.com', '661.825.988-67', '1970-07-07', '(67)3572-2781'),
(default,'Paulo Arthur Miguel Nogueira', 'pauloarthurnogueira@hotmail.com', '074.427.283-16', '1994-02-04', '(98)3612-0576'),
(default,'Fernanda Helena Nair da Cunha', 'fernanda_dacunha@gmail.com.br', '852.218.493-30', '1978-09-09', '(45)2558-5079'),
(default,'Raimundo Hugo Nascimento', 'raimundo_hugo_nascimento@gmail.com', '105.776.171-09', '1984-05-05', '(84)2729-3178'),
(default,'Nair Vera Porto', 'nair-porto85@life.com', '071.846.678-08', '1991-05-25', '(91)9921-1010'),
(default,'Breno Benedito Castro', 'breno.benedito.castro@hotmail.com.br', '104.408.011-68', '2002-03-14', '(21)3561-7228'),
(default,'Andrea Nair Beatriz da Luz', 'andreanairdaluz@gmail.com.br', '730.520.021-20', '1981-05-27', '(96)9890-8925'),
(default,'Luiz Cláudio Almada', 'luiz_claudio_almada@gmail.com.br', '531.939.951-00', '1974-02-11', '(84)2737-7410'),
(default,'Enrico Nelson da Paz', 'enrico-dapaz71@hotmail.com.br', '874.715.135-86', '1996-05-05', '(69)9914-6022'),
(default,'Marcela Louise Corte Real', 'marcela_louise_cortereal@gmail.com.br', '437.259.395-35', '1979-01-18', '(95)2683-1167');
-- ---------------------------------------------------------------------------------------------------------------------------------

INSERT INTO login VALUES 
(default, 'Ruan', 'timao2022'),
(default, 'Filipe', 'BR2002'),
(default, 'Dan22', 'rapH2o'),
(default, 'Oliver', 'olv1990'),
(default, 'Kevin', 'dgwub89'),
(default, 'FNC16', 'VapoCor22'),
(default, 'Edson', 'Edson2022'),
(default, 'Arthur', 'thur1212'),
(default, 'Giovanni', 'gio4522'),
(default, 'Kauê99', 'jujuba22'),
(default, 'Vitor', 'Guedes123'),
(default, 'Otávio', 'Otv4455'),
(default, 'Eloá', 'DeusEFiel'),
(default, 'Melissa', 'djavu2013'),
(default, 'Teresinha', 'Tere0007'),
(default, 'Agatha', 'gata1996'),
(default, 'Raimunda', '345fdrt'),
(default, 'Kamilly', 'Kll4637'),
(default, 'SaraBI', 'sasa6734'),
(default, 'Sophie','Gfhaj5326'),
(default, 'Marcia AR', 'vdxafr12'),
(default, 'Mr.Cau', 'rdtgte23'),
(default, 'Livia91', 'fcd43ds'),
(default, 'Ritinha', '123abc'),
(default, 'Cisco_Duarte', 'Fran2221'),
(default, 'Emanuel446', 'gg2323gg'),
(default, 'Nelson15', 'eu98765'),
(default, 'Bruna_MJC', '8978ET'),
(default, 'RenanCalebe', '9090ixi'),
(default, 'Juan_Muel', 'wxc2324'),
(default, 'Jorge-Martin', 'DDff235'),
(default, 'Cl.Carlos', '323fdcSS'),
(default, 'Ninas2', 'rrrttt263'),
(default, 'Rol_cat', 'swydbe326'),
(default, 'Loi987', 'rta674'),
(default, 'Paulo A.', 'tutu4332'),
(default, 'Nanda22', 'fsxkd837'),
(default, 'Raimundo892', 'szdac33'),
(default, 'Nair77', '77889966'),
(default, 'Breno.BC', 'UY43hbd'),
(default, 'Andrea_Nai', 'yusbd647'),
(default, 'Luiz_CA', 'SDa324ed'),
(default, 'Rico_N.Paz', 'TsbsYZ09'),
(default, 'Marcela LC', 'sdeew332');
-- ---------------------------------------------------------------------------------------------------------------------------------

INSERT INTO genero VALUES 
(default,'Ação'),(default,'Aventura'),(default,'Comédia'),(default,'Anime'),(default,'Documentário'),(default,'Drama'),(default,'Ficção científica'),
(default,'Fantasia'),(default,'Terror'),(default,'Infantil'),(default,'Romance'),(default,'Suspense'),(default,'Policial'),(default,'Militar e Guerra');
-- ---------------------------------------------------------------------------------------------------------------------------------

INSERT INTO produtora VALUES
(default, 'Dreamworks'), (default, 'MGM (Metro Goldwyn Mayer)'), (default, 'The Weinstein Company'), (default, 'Lions Gate'), 
(default, 'Paramount'), (default, 'Century Fox'), (default, 'Universal'), (default, 'Walt Disney'), (default, 'Warner Bros.'), 
(default, 'Sony Pictures'), (default, 'Marvel'), (default, 'Netflix');

-- ----------------------------------------------------------------------------------------------------------------------------------
INSERT INTO filme VALUES
(default,'Como Treinar o Seu Dragão 3: O Mundo Escondido', 2019, 'L', 6.90, 1, 10),
(default,'007 - Sem Tempo para Morrer', 2021, '14', 11.90, 2, 1),
(default,'Django Livre', 2012, '16', 6.90, 3, 6),
(default,'Jogos Mortais VI', 2009, '18', 7.80, 4, 9),
(default,'Sonic 2 - O Filme', 2022, '10', 14.90, 5, 2),
(default,'Era uma Vez um Deadpool', 2018, '16', 8.50, 6, 1),
(default,'Minions 2: A Origem de Gru', 2022, 'L', 16.90, 7, 3),
(default,'Thor Amor e Trovão', 2022, '14', 17.50, 8, 1),
(default,'Matrix Resurrections', 2021, '14', 19.90, 9, 7),
(default,'Venom: Tempo de Carnificina', 2021, '14', 24.90, 10, 1),
(default,'Eternos', 2021, '12', 11.50, 11, 8),
(default, 'Doutor Estranho no Multiverso da Loucura', 2022, '14', 25.00, 11, 2),
(default, 'Homem-Aranha: Sem Volta para Casa', 2021, '12', 19.99, 11, 2),
(default, 'Viúva Negra', 2021, '12', 19.99, 11, 1),
(default, 'Shang-Chi e a Lenda dos Dez Anéis', 2021, '12', 19.99, 11, 1),
(default, 'Homem-Aranha: Longe de Casa', 2019, '10', 17.99, 11, 2),
(default, 'Homem-Aranha: De Volta ao Lar', 2017, '12', 15.99, 11, 2),
(default, 'Pantera Negra: Wakanda Para Sempre', 2022, '10', 25.00, 11, 1),
(default, 'Capitã Marvel', 2019, '12', 15.99, 11, 1),
(default, 'Vingadores: Ultimato', 2019, '12', 15.99, 11, 1),
(default, 'Resgate', 2020, '16', 14.99, 12, 1),
(default, 'Okja', 2017, '14', 11.99, 12, 2),
(default, 'Alerta Vermelho', 2021, '12', 16.99, 12, 1),
(default, 'Os Meyerowitz: Família Não Se Escolhe ', 2017, 'L', 5.90, 12, 3),
(default, 'O Tigre Branco', 2021, '18', 19.99, 12, 6),
(default, 'Klaus', 2019, '10', 9.80, 12, 10),
(default, 'Bird Box', 2018, '16', 8.70, 12, 9),
(default, 'Sand Castle', 2017, '16', 7.99, 12, 14),
(default, 'Esquadrão 6', 2019, '18', 12.99, 12, 12),
(default, 'Noite no Paraíso', 2020, '16', 14.99, 12, 13);

-- ----------------------------------------------------------------------------------------------------------------------------------
-- nome, ano, classificação, preço, num temporada, produtora, genero
INSERT INTO serie VALUES
(default,'iCarly', 2021, 'L', 15.90, 2, 6, 10),
(default,'O Dono de Kingstown', 2021, '18', 16.99, 1, 6, 12),
(default,'Moon Knight', 2022, '12', 19.99, 1, 11, 1),
(default,'WandaVision', 2021, '13', 18.90, 1, 11, 11),
(default,'Loki', 2021, '14', 19.50, 1, 11, 1),
(default,'Gavião Arqueiro', 2021, '14', 18.90, 1, 11,1),
(default,'Demolidor', 2015, '18', 20.60, 3, 11, 1),
(default,'Lupin', 2021, '16', 19.99, 2, 12, 12),
(default,'BoJack Horseman', 2014, '16', '15.99', 6, 12, 3),
(default,'Peaky Blinders', 2013, '18', 21.99, 6, 12, 6),
(default,'Os Feiticeiros de Waverly Place', 2007, 'L', 8.99, 4, 11, 3),
(default,'Elite', 2018, '18', 11.90, 5, 12, 6),
(default,'Cobra Kai', 2022, '14', 24.99, 5, 12, 3),
(default,'Stranger Things', 2022, '16', 24.99, 4, 12, 7),
(default,'Bem-Vindos á Vizinhança', 2022, '16', 24.99, 7, 12, 12),
(default,'Dahmer: Um Canibal Americano', 2022, '18', 24.99, 10, 12, 9),
(default,'La casa de papel', 2021, '16', 21.99, 5, 12, 12),
(default,'Titãs', 2021, '18', 22.99, 3, 12, 7),
(default,'Lucifer', 2021, '16', 22.99, 6, 12, 8),
(default,'Round 6', 2021, '18', 22.99, 9, 12, 12);

-- ----------------------------------------------------------------------------------------------------------------------------------
INSERT INTO locacao VALUES (default,'2019-03-15', '2019-04-15', 00.00, 1), (default, '2019-05-06', '2019-06-06', 00.00, 2),
(default, '2019-07-19', '2019-08-19', 00.00, 3), (default, '2019-09-01', '2019-10-01', 00.00, 4), (default, '2020-03-13', '2020-04-13', 00.00, 5), 
(default, '2021-06-29', '2021-07-29', 00.00, 6), (default, '2021-01-13', '2021-02-13', 00.00, 7), (default, '2019-04-06', '2019-05-06', 00.00, 8), 
(default, '2021-02-22', '2021-03-22', 00.00, 9), (default, '2022-02-08', '2022-03-22', 00.00, 10), (default, '2022-04-17', '2022-05-17', 00.00, 11),
(default, '2022-01-18', '2022-02-18', 00.00, 12), (default, '2022-05-17', '2022-06-17', 00.00, 13), (default, '2022-09-05', '2022-10-05', 00.00, 14),
(default, '2021-08-24', '2021-09-24', 00.00, 15), (default, '2021-06-06', '2021-07-06', 00.00, 16), (default, '2019-11-17', '2019-12-17', 00.00, 17), 
(default, '2020-04-04', '2020-05-04', 00.00, 18), (default, '2020-01-30', '2020-03-02', 00.00, 19), (default, '2022-09-16', '2022-10-16', 0.00, 20),
(default, '2021-02-22', '2021-03-22', 00.00, 9), (default, '2019-07-19', '2019-08-19', 00.00, 3), (default, '2022-09-16', '2022-10-16', 00.00, 21), 
(default,'2022-10-19', '2022-11-19', 00.00, 22), (default,'2021-06-06', '2021-07-06', 00.00, 16), (default,'2022-08-22', '2022-09-22', 00.00, 23),
(default,'2021-07-04', '2021-08-04', 00.00, 24), (default,'2022-09-05', '2022-10-05', 00.00, 25), (default,'2022-11-09', '2022-12-09', 00.00, 26),
(default,'2022-05-02', '2022-06-02', 00.00, 27), (default,'2020-01-30', '2020-03-01', 00.00, 28), (default,'2021-06-05', '2021-07-05', 00.00, 29),
(default,'2022-10-18', '2022-11-18', 00.00, 30), (default,'2022-08-22', '2022-09-22', 00.00, 31), (default,'2021-12-06', '2022-01-06', 00.00, 32),
(default,'2022-09-16', '2022-10-16', 00.00, 20), (default,'2022-05-02', '2022-06-02', 00.00, 33), (default,'2022-09-12', '2022-10-12', 00.00, 34),
(default,'2021-04-19', '2021-05-19', 00.00, 35), (default,'2022-09-03', '2022-10-03', 00.00, 36), (default,'2022-02-13', '2022-03-13', 00.00, 37),
(default,'2022-06-20', '2022-07-20', 00.00, 38), (default,'2022-08-10', '2022-08-10', 00.00, 39), (default,'2021-09-16', '2021-10-16', 00.00, 40),
(default,'2022-05-26', '2022-06-26', 00.00, 41), (default,'2022-06-07', '2022-07-07', 00.00, 42), (default,'2022-01-22', '2022-02-22', 00.00, 43),
(default,'2022-04-28', '2022-05-28', 00.00, 44), (default,'2022-09-18', '2022-10-18', 00.00, 40);
-- ----------------------------------------------------------------------------------------------------------------------------------
INSERT INTO locacao_filme VALUES 
(1, 8), (2, 7), (3, 1), (4, 4), (5, 3), (6, 11), (7, 9), (8, 2), (9, 10), (10, 5), (11, 6),
(21, 12), (22, 5), (23, 13), (24, 25), (25, 15), (26, 30), (27, 21), (28, 16), (29, 19), (30, 23),
(31, 12), (32, 28), (33, 20), (34, 18), (35, 26), (36, 17), (37, 22), (38, 14), (39, 24);

-- ----------------------------------------------------------------------------------------------------------------------------------
INSERT INTO locacao_serie VALUES 
(12, 5),(13, 1),(14, 7),(15, 9),(16, 3), (17, 4),(18, 2),(19, 10),(20, 6), (40, 11), (41, 12),
(42, 16), (43, 19), (44, 20), (45, 18), (46, 13), (47, 15), (48, 17), (49, 14);

-- ----------------------------------------------------------------------------------------------------------------------------------


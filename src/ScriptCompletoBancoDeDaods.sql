	DROP TABLE IF EXISTS CONVIDADOPRESENTE;
	DROP TABLE IF EXISTS CONVIDADO;
	DROP TABLE IF EXISTS PRESENTE;
	DROP TABLE IF EXISTS DESTINOLUADEMEL;

	-- Extensão para gerar UUIDs automaticamente
	CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

	-- Criação da tabela DestinosLuaDeMel
	CREATE TABLE DestinoLuaDeMel (
		Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
		Nome TEXT NOT NULL,
		ValorNecessario DECIMAL(10, 2) NOT NULL,
		URLFoto TEXT
	);
	
	-- Tabela Presente (sem mudanças no relacionamento)
	CREATE TABLE Presente (
		Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
		Nome TEXT NOT NULL,
		Valor DECIMAL(10, 2) NOT NULL,
		ValorObtido DECIMAL(10, 2) NOT NULL,
		PresenteUnico BOOLEAN NOT NULL,
		DestinoId UUID,
		URLFoto TEXT,
		URLLoja TEXT,
		CONSTRAINT FK_Presente_DestinoLuaDeMel FOREIGN KEY (DestinoId) REFERENCES DestinoLuaDeMel(Id) ON DELETE SET NULL
	);
	
	-- Tabela Convidado (removendo PresenteId e ValorConcedido)
	CREATE TABLE Convidado (
		Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
		Nome TEXT NOT NULL,
		PresencaConfirmada BOOLEAN NOT NULL
	);
	
	-- Nova tabela de associação: ConvidadoPresente
	CREATE TABLE ConvidadoPresente (
		Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
		ConvidadoId UUID NOT NULL,
		PresenteId UUID NOT NULL,
		ValorConcedido DOUBLE PRECISION NOT NULL,
		CONSTRAINT FK_ConvidadoPresente_Convidado FOREIGN KEY (ConvidadoId) REFERENCES Convidado(Id) ON DELETE CASCADE,
		CONSTRAINT FK_ConvidadoPresente_Presente FOREIGN KEY (PresenteId) REFERENCES Presente(Id) ON DELETE CASCADE
	);

INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Hemilly Reis', TRUE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Rosimar Reis', TRUE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Claudio Garcia', TRUE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('José Mario Vilaverde', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Cássio Garcia', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Valquíria dos Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Lara Cristine', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Mozielly Cristina', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Paulo Henrique', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Dagmar Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('João Fatal', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Rayene Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Chayene Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Kawã Henrique Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Juliana', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Romar Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Nicole', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Luiz Henrique Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Lazaro Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Tauany', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Arthur', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Hortelino Vilaverde', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Hélida Vilaverde', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Nilva Vilaverde', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Marcilene Garcia', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Edmar Andrade', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Juninho Andrade', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Ellen', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Marcos Antônio', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Karla', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Gleibison Garcia', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Kauã Garcia', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Edilene', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Lídia Aparecida', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Divino Fernandes', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Maria Eduarda Fernandes', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Cauan (Maria)', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Vó Badia', TRUE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Vô Paulo', TRUE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Agmar Otim', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Ana Lucia', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Lucas Garcia', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Luciene (Lucas)', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Celma Otim', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Delma Otim', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Omir', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Rozilley Otim', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Daniel Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Gabriel Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Lucimar Otim', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Geane Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Thiago', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Isabela', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Gabriela', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Luzimar Otim', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Evillyn Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Wayne Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Leonardo Reis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Geovana (Leonardo)', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Weligton Garcia', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Luciene Garcia (Nenê)', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Maycon Douglas', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Mikael Garcia', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Maria Helena Garcia', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Padico', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Enedir nedim', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Alrrany', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Mônica Garcia', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Maria Eduarda (Alrrany)', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Maria Clara (Allrany)', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Douglas Jorge', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Virgícia Camargo', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Miguel Ribeiro', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Lara Pires', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('João Victor Fernandes', TRUE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Maria Cecília', TRUE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Otávio Camargo', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Paola', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Juarez Neto', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Radharani Claro', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Isaac Brasil', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Ingridy (Isaac)', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Lucas Rios', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Max Lobo', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Pedro Sanches', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Caio Januário', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Brenda', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Elvis Noleto', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Jackeline', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Hellys', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Hellys - acompanhante', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Tatiana', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Matheus', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Miriã', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Miriã - acompanhante', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('André Mano', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Clarissa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Mia', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Christian', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Christian - esposa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Christian - filhos', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Luciene Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Jussara Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Célio Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Célio Vittor Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Grazy Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Jéssica Batista', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Lyvia Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Ricardo Oliveira', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Gabriel Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Célia Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('João Pedro Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Mirtis', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Janaína Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Luca Gusmão', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Davi Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Felipe Costa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Marcos Filho Calassa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Dani Calassa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Maria Alice Calassa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Daniel Calassa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Cida', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Jeferson', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Guilherme', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Julia (Guilherme)', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Eduardo Neves', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Jéssica Esthefanny', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Madrinha Marli', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Patrícia Santos', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Bruna Letícia Carvalho', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Luiz Schneiders', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Rafael Santos', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Claudia Paula', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Barbara Caetano', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Lucas Nogueira', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('João Ferreira - Juninho', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Lara Leal', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Marco (Lara)', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Nicholas Trigueiro', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Gabriella Marinho', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Gessilma Dias', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Márcio', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Marines', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Stefany', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Cavalcante', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Dorinha', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Sandro', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Ketlen', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Kaique', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Amanda Ximenes', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Pedro Ivo', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Natália Calassa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Bruno', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Cecília Calassa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Heitor Calassa', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Julia Oliveira', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('João Vitor', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Anny', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Erick', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Sabrina', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Carol', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Roger', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Diego', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Léo', FALSE);
INSERT INTO Convidado (Nome, PresencaConfirmada) VALUES ('Léo - Acompanhante', FALSE);

INSERT INTO DestinoLuaDeMel (Nome, ValorNecessario, URLFoto) VALUES ('Faina', 0, 'https://s2-g1.glbimg.com/d5EuyCTGZxq8_W9BAqVdDlz4mwg=/0x0:1700x1065/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2019/T/0/J37nGjQ0Ov4cC87pUICA/entrada-faina.jpg');
INSERT INTO DestinoLuaDeMel (Nome, ValorNecessario, URLFoto) VALUES ('Caldas Novas', 200, 'https://www.alugueleconomico.com.br/media/614370dc077ce4089f36544f/md');
INSERT INTO DestinoLuaDeMel (Nome, ValorNecessario, URLFoto) VALUES ('Piri', 500, 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/a1/8d/e6/portal-de-entrada-da.jpg?w=900&h=500&s=1');
INSERT INTO DestinoLuaDeMel (Nome, ValorNecessario, URLFoto) VALUES ('Chapada do Veadeiros', 800, 'https://i0.wp.com/pisa.tur.br/blog/wp-content/uploads/2021/04/melhor_epoca_veadeiros_capablog.jpg?fit=1920%2C840&ssl=1');
INSERT INTO DestinoLuaDeMel (Nome, ValorNecessario, URLFoto) VALUES ('Gramado', 1000, 'https://www.melhoresdestinos.com.br/wp-content/uploads/2019/02/passagens-aereas-gramado-capa2019-04-820x430.jpg');


-- Inserir Presentes
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Purificador de água',  1269.52, 0, false, NULL, 'https://cdn.awsli.com.br/2500x2500/99/99337/produto/34804019/4e7d6a8563.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Lua de mel', 1500.00, 0, false, (Select Id from DestinoLuaDeMel where Nome = 'Faina'), '');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Máquina de lavar', 1799.00, 0, false, NULL, 'https://m.media-amazon.com/images/I/41+50Z4TgEL._AC_SL1200_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Jogo de talheres', 106.00, 0, true, NULL, 'https://m.media-amazon.com/images/I/61NlXehlnBL._AC_SL1094_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Jogo de facas', 194.00, 0, true, NULL, 'https://m.media-amazon.com/images/I/61RqbpPpt5L._AC_SL1200_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Guarda-roupas', 1799.00, 0, false, NULL, 'https://a-static.mlcdn.com.br/800x560/guarda-roupa-casal-com-espelho-3-portas-de-correr-6-gavetas-demobile-londres/magazineluiza/237139700/85ee84cd1cbdffb76e464b44ffdaac0d.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Kit tábuas de petiscos', 78.87, 0, true, NULL, 'https://m.media-amazon.com/images/I/61g1+1qW6CL._AC_SL1215_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Porta tempero', 107.00, 0, true, NULL, 'https://m.media-amazon.com/images/I/61OG7XRQh5L._AC_SL1200_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Forno elétrico', 479.00, 0, false, NULL, 'https://m.media-amazon.com/images/I/61cqfHB8XNL._AC_SL1200_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Batedeira', 118.22, 0, true, NULL, 'https://m.media-amazon.com/images/I/71a-aiH-n+L._AC_SY300_SX300_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Cafeteira', 424.00, 0, false, NULL, 'https://m.media-amazon.com/images/I/51GFyrWfdbS._AC_SL1181_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Varal de roupas', 157.90, 0, true, NULL, 'https://m.media-amazon.com/images/I/51F+bU8iqzL._AC_SL1000_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Tapete Felpudo', 169.00, 0, true, NULL, 'https://m.media-amazon.com/images/I/71mYs37EHML._AC_SL1280_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Jogo de xícaras', 122.90, 0, true, NULL, 'https://m.media-amazon.com/images/I/51u2fMIZM4L._AC_SL1200_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Jantar para os noivos', 250.00, 0, true, NULL, 'https://aceitosim.com.br/wp-content/uploads/2018/06/vinho-em-jantar-romantico.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Aspirador de pó', 239.00, 0, true, NULL, 'https://m.media-amazon.com/images/I/71zOYFOSMqL._AC_SL1500_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Espelho', 179.00, 0, true, NULL, 'https://m.media-amazon.com/images/I/51TT+ILSY3S._AC_SL1000_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Miniprocessador', 189.0, 0, true, NULL, 'https://m.media-amazon.com/images/I/81E0aTRgrmL._AC_SL1500_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Jogos de pratos', 139.00, 0, true, NULL, 'https://m.media-amazon.com/images/I/51a+GLzT65L._AC_SL1000_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Chapa de ferro lisa', 139.70, 0, true, NULL, 'https://m.media-amazon.com/images/I/51NT3BkKROL._AC_SL1500_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Mala para lua de mel - Noivo', 218.00, 0, true, NULL, 'https://m.media-amazon.com/images/I/71Dxn+5N6FL._AC_SL1500_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Mala para lua de mel - Noiva', 218.00, 0, true, NULL, 'https://m.media-amazon.com/images/I/71Dxn+5N6FL._AC_SL1500_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Umidificador de ar', 171.24,0, true, NULL, 'https://m.media-amazon.com/images/I/71DXDe5YcbL._AC_SL1500_.jpg');
INSERT INTO Presente (Nome, Valor, ValorObtido, PresenteUnico, DestinoId, URLFoto) VALUES ('Site de casamento', 2000,0, true, NULL, 'https://suaempresanainternet.net/wp-content/uploads/2023/12/site.png');

DROP FUNCTION IF EXISTS atualizar_valor_obtido_presente();
CREATE OR REPLACE FUNCTION atualizar_valor_obtido_presente()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Presente
    SET ValorObtido = ValorObtido + NEW.ValorConcedido
    WHERE Id = NEW.PresenteId;
  RETURN NULL; -- Não precisa retornar uma nova linha
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_convidado_presente_insert ON ConvidadoPresente;
CREATE TRIGGER trg_convidado_presente_insert
AFTER INSERT ON ConvidadoPresente
FOR EACH ROW
EXECUTE FUNCTION atualizar_valor_obtido_presente();

INSERT INTO ConvidadoPresente (ConvidadoId,PresenteId,ValorConcedido) Values ((Select Id from Convidado where Nome = 'João Victor Fernandes'), (Select Id from Presente where Nome = 'Site de casamento'), 2000);

SELECT * FROM PRESENTE
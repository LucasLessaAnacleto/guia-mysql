DROP DATABASE IF EXISTS demonstracao;

CREATE DATABASE IF NOT EXISTS demonstracao;

USE demonstracao;

-- Tabela de clientes
CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    senha VARCHAR(20) NOT NULL
);

-- Tabela de produtos
CREATE TABLE IF NOT EXISTS produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    categoria ENUM("eletrônicos", "domésticos", "vestimentas", "calçados"),
    preco DECIMAL(10, 2) NOT NULL
);

-- Tabela de pedidos
CREATE TABLE IF NOT EXISTS pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido DATE DEFAULT (CURRENT_DATE()),
    total DECIMAL(10, 2) DEFAULT 0,
    CONSTRAINT fk_cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE
);

-- Tabela de itens do pedido
CREATE TABLE IF NOT EXISTS itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_pedido_id FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    CONSTRAINT fk_produto_id FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);

-- TRIGGER: INSERT - ITENS_PEDIDO
DROP TRIGGER IF EXISTS demonstracao.TG_itens_pedido_BEFORE_INSERT;
DELIMITER $
CREATE TRIGGER demonstracao.TG_itens_pedido_BEFORE_INSERT
BEFORE INSERT ON itens_pedido FOR EACH ROW
BEGIN
	DECLARE subtotal DECIMAL(10,2);
    SET subtotal = NEW.quantidade * (
		SELECT preco FROM produtos 
        WHERE id = NEW.produto_id
	);
    
	SET NEW.subtotal = subtotal;
    UPDATE pedidos SET total = (total + subtotal) WHERE id = NEW.pedido_id;
END$
DELIMITER ;

-- TRIGGER: UPDATE - ITENS_PEDIDO
DROP TRIGGER IF EXISTS TG_itens_pedido_BEFORE_UPDATE;
DELIMITER $
CREATE TRIGGER TG_itens_pedido_BEFORE_UPDATE
BEFORE UPDATE ON itens_pedido FOR EACH ROW
BEGIN
	DECLARE subtotal DECIMAL(10,2);
    SET subtotal = NEW.quantidade * (SELECT preco FROM produtos WHERE id = NEW.produto_id);
    
    IF OLD.subtotal != subtotal THEN
		SET NEW.subtotal = subtotal;
		UPDATE pedidos SET total = (total + (subtotal - OLD.subtotal)) WHERE id = NEW.pedido_id;
	END IF;
END$
DELIMITER ;

-- Inserir clientes americanos
INSERT INTO clientes (nome, email, telefone, senha) VALUES
('John Smith', 'john@example.com', '1198765-4321', 'John123'),
('Mary Johnson', 'mary@example.com', '1198765-4321', 'mary456'),
('James Williams', 'james@example.com', '1198765-4321', 'password789'),
('Patricia Brown', 'patricia@example.com', '1198765-4321', 'brown123'),
('Michael Jones', 'michael@example.com', '1198765-4321', 'michael456'),
('Jennifer Miller', 'jennifer@example.com', '1198765-4321', 'password789'),
('David Davis', 'david@example.com', '1198765-4321', 'david123'),
('Linda Garcia', 'linda@example.com', '1198765-4321', 'garcia456'),
('Robert Rodriguez', 'robert@example.com', '1198765-4321', 'password789'),
('Barbara Martinez', 'barbara@example.com', '1198765-4321', 'barbara123'),
('John Doe', 'john@example.com', '1298765-4321', '123456'),
('Jane Smith', 'jane@example.com', '1298765-4321', 'password456'),
('Michael Johnson', 'michael@example.com', '1398765-4321', 'michael789'),
('Emily Davis', 'emily@example.com', '1298765-4321', 'emily123'),
('Christopher Brown', 'christopher@example.com', '1198765-4321', 'brown456'),
('Jessica Martinez', 'jessica@example.com', '1398765-4321', 'password789'),
('David Wilson', 'david@example.com', '1298765-4321', 'wilson123'),
('Ashley Anderson', 'ashley@example.com', '1398765-4321', 'ashley456'),
('James Taylor', 'james@example.com', '1398765-4321', 'password789'),
('Sarah Garcia', 'sarah@example.com', '1198765-4321', 'sarah123'),
('José Silva', 'jose@example.com', '4798765-4321', 'Jose123'),
('Ana Oliveira', 'ana@example.com', '4898765-4321', 'ana456'),
('Carlos Souza', 'carlos@example.com', '4998765-4321', 'Neymar789'),
('Mariana Santos', 'mariana@example.com', '5398765-4321', 'sakura123'),
('Ricardo Pereira', 'ricardo@example.com', '5498765-4321', 'CR71234'),
('Amanda Almeida', 'amanda@example.com', '4598765-4321', 'Amanda456'),
('Paulo Costa', 'paulo@example.com', '4698765-4321', 'paulo789'),
('Fernanda Lima', 'fernanda@example.com', '4798765-4321', 'fernanda10'),
('Marcos Rocha', 'marcos@example.com', '4898765-4321', 'goku456'),
('Juliana Martins', 'juliana@example.com', '4998765-4321', 'Juliana789'),
('Antônio Santos', 'antonio@example.com', '5398765-4321', 'Naruto123'),
('Camila Oliveira', 'camila@example.com', '5498765-4321', 'ozil456'),
('Lucas Silva', 'lucas@example.com', '4598765-4321', 'lucas789'),
('Patrícia Souza', 'patricia@example.com', '4698765-4321', 'Patricia10'),
('Fábio Pereira', 'fabio@example.com', '4798765-4321', 'benzema456'),
('Gabriela Almeida', 'gabriela@example.com', '4898765-4321', 'Gabriela789'),
('Marcelo Costa', 'marcelo@example.com', '4998765-4321', 'CR71234'),
('Isabela Lima', 'isabela@example.com', '5398765-4321', 'kuririn123'),
('Rodrigo Rocha', 'rodrigo@example.com', '5498765-4321', 'rodrigo456'),
('Sandra Martins', 'sandra@example.com', '4598765-4321', 'dimaria789'),
('Tiago Santos', 'tiago@example.com', '4698765-4321', 'Tiago10'),
('Vivian Oliveira', 'vivian@example.com', '4798765-4321', 'Neymar456'),
('Anderson Silva', 'anderson@example.com', '4898765-4321', 'anderson789'),
('Carla Souza', 'carla@example.com', '4998765-4321', 'sakura123'),
('Márcia Lima', 'marcia@example.com', '5398765-4321', 'CR71234'),
('Eduardo Pereira', 'eduardo@example.com', '5498765-4321', 'eduardo456'),
('Fernando Almeida', 'fernando@example.com', '4598765-4321', 'goku789'),
('Vanessa Costa', 'vanessa@example.com', '4698765-4321', 'Vanessa10'),
('Roberto Rocha', 'roberto@example.com', '4798765-4321', 'ozil456'),
('Patrícia Martins', 'patricia@example.com', '4898765-4321', 'Patricia789'),
('Daniel Santos', 'daniel@example.com', '4998765-4321', 'Naruto123'),
('Tatiane Oliveira', 'tatiane@example.com', '5398765-4321', 'tatiane10'),
('Luciana Lima', 'luciana@example.com', '5498765-4321', 'CR71234'),
('Alexandre Rocha', 'alexandre@example.com', '4598765-4321', 'kuririn123'),
('Renata Martins', 'renata@example.com', '4698765-4321', 'renata789'),
('Rafael Souza', 'rafael@example.com', '4798765-4321', 'Neymar10'),
('Caroline Almeida', 'caroline@example.com', '4898765-4321', 'caroline456'),
('Gustavo Costa', 'gustavo@example.com', '4998765-4321', 'gustavo789'),
('Fabiana Lima', 'fabiana@example.com', '5398765-4321', 'fabiana10'),
('Henrique Pereira', 'henrique@example.com', '5498765-4321', 'henrique123'),
('Natália Oliveira', 'natalia@example.com', '4598765-4321', 'Natalia456'),
('Leonardo Silva', 'leonardo@example.com', '4698765-4321', 'Neymar789'),
('André Souza', 'andre@example.com', '4798765-4321', 'andre10'),
('Carolina Martins', 'carolina@example.com', '4898765-4321', 'CR71234'),
('Tatiana Lima', 'tatiana@example.com', '4998765-4321', 'kuririn123'),
('Vinícius Rocha', 'vinicius@example.com', '5398765-4321', 'vinicius789'),
('Jéssica Santos', 'jessica@example.com', '5498765-4321', 'Jéssica10'),
('Diego Oliveira', 'diego@example.com', '4598765-4321', 'Neymar456'),
('Fernanda Silva', 'fernanda@example.com', '4698765-4321', 'fernanda789'),
('Michael Schmidt', 'michael@example.com', '442345678901', 'Schmidt123'),
('Emma Weber', 'emma@example.com', '442345678901', 'emma456'),
('Daniel Becker', 'daniel@example.com', '443456789012', 'password789'),
('Laura Wagner', 'laura@example.com', '444567890123', 'laura123'),
('David Schmitt', 'david@example.com', '445678901234', 'Schmitt456'),
('Sophie Müller', 'sophie@example.com', '446789012345', 'password789'),
('Paul Fischer', 'paul@example.com', '447890123456', 'Fischer123'),
('Isabella Richter', 'isabella@example.com', '448901234567', 'isabella456'),
('James Schulz', 'james@example.com', '449012345678', 'password789'),
('Hannah Zimmermann', 'hannah@example.com', '451234567890', 'Hannah123'),
('Lucas Schneider', 'lucas@example.com', '452345678901', 'Schneider456'),
('Amelia Huber', 'amelia@example.com', '453456789012', 'password789'),
('Benjamin Wagner', 'benjamin@example.com', '454567890123', 'Wagner123'),
('Mia Lange', 'mia@example.com', '455678901234', 'password456'),
('Ethan Becker', 'ethan@example.com', '456789012345', 'Becker123'),
('Olivia Schäfer', 'olivia@example.com', '457890123456', 'password789'),
('Noah Neumann', 'noah@example.com', '458901234567', 'Neumann123'),
('Emily Braun', 'emily@example.com', '459012345678', 'password789'),
('Liam Hoffmann', 'liam@example.com', '461234567890', 'Hoffmann123'),
('Ella Zimmermann', 'ella@example.com', '462345678901', 'Ella456'),
('Alexander Krüger', 'alexander@example.com', '463456789012', 'password789'),
('Ava Fischer', 'ava@example.com', '464567890123', 'Ava123'),
('Mason Vogel', 'mason@example.com', '465678901234', 'password456'),
('Sophia Becker', 'sophia@example.com', '466789012345', 'Becker789'),
('Logan Braun', 'logan@example.com', '467890123456', 'Logan123'),
('Amelia Schulz', 'amelia@example.com', '468901234567', 'password789'),
('Oliver Schäfer', 'oliver@example.com', '469012345678', 'Schäfer123'),
('Charlotte Meyer', 'charlotte@example.com', '471234567890', 'Charlotte456'),
('Aiden Richter', 'aiden@example.com', '472345678901', 'Richter789'),
('Aria Becker', 'aria@example.com', '473456789012', 'password789'),
('Sebastian Fischer', 'sebastian@example.com', '474567890123', 'Sebastian123'),
('Grace Lange', 'grace@example.com', '475678901234', 'password789'),
('Lucas Zimmermann', 'lucas@example.com', '476789012345', 'Zimmermann123'),
('Scarlett Hoffmann', 'scarlett@example.com', '477890123456', 'Scarlett456'),
('Carter Vogt', 'carter@example.com', '478901234567', 'password789'),
('Madison Meier', 'madison@example.com', '479012345678', 'Meier123'),
('Henry Schäfer', 'henry@example.com', '481234567890', 'Schäfer789'),
('Lily Meier', 'lily@example.com', '482345678901', 'Lily123'),
('Elijah Hoffmann', 'elijah@example.com', '483456789012', 'Hoffmann789'),
('Harper Jung', 'harper@example.com', '484567890123', 'Harper123'),
('Matthew Meier', 'matthew@example.com', '485678901234', 'Meier789'),
('Addison Schäfer', 'addison@example.com', '486789012345', 'Schäfer123'),
('Owen Schäfer', 'owen@example.com', '487890123456', 'Schäfer789'),
('Chloe Jung', 'chloe@example.com', '488901234567', 'Chloe123'),
('Jackson Jung', 'jackson@example.com', '489012345678', 'Jung789'),
('Avery Vogt', 'avery@example.com', '491234567890', 'Avery123'),
('Evelyn Schäfer', 'evelyn@example.com', '492345678901', 'Schäfer789'),
('Daniel Schmitt', 'daniel@example.com', '493456789012', 'Schmitt123');

-- Inserindo produtos
INSERT INTO produtos (nome, descricao, categoria, preco) VALUES
('Smartphone Galaxy S22', 'Smartphone com tela Super AMOLED de 6.6 polegadas, processador octa-core e câmera tripla de 108MP.', 'eletrônicos', 999.99),
('Notebook Dell XPS 15', 'Notebook premium com tela OLED de 15 polegadas, processador Intel Core i7 e placa de vídeo NVIDIA GeForce RTX 3050 Ti.', 'eletrônicos', 1899.99),
('Mouse Logitech MX Master 3', 'Mouse ergonômico com conexão Bluetooth e USB-C, sensor de alta precisão e rolagem ultrarrápida.', 'eletrônicos', 99.99),
('Monitor LG UltraWide 34"', 'Monitor ultrawide com resolução QHD de 3440x1440, tecnologia IPS e taxa de atualização de 75Hz.', 'eletrônicos', 599.99),
('Smart TV Samsung 55"', 'Smart TV 4K com tela QLED de 55 polegadas, sistema operacional Tizen e suporte a assistentes de voz.', 'eletrônicos', 799.99),
('Caixa de Som JBL Charge 5', 'Caixa de som portátil à prova d\'água com Bluetooth, bateria de longa duração e JBL PartyBoost.', 'eletrônicos', 149.99),
('Fone de Ouvido Sony WH-1000XM4', 'Fone de ouvido over-ear com cancelamento de ruído, compatível com áudio de alta resolução e até 30 horas de bateria.', 'eletrônicos', 349.99),
('Câmera Canon EOS R5', 'Câmera mirrorless profissional com sensor full-frame de 45MP, gravação de vídeo em 8K e estabilização de imagem de 5 eixos.', 'eletrônicos', 3499.99),
('Roteador TP-Link Archer AX6000', 'Roteador Wi-Fi 6 com velocidade de até 6Gbps, cobertura de sinal em toda a casa e suporte a múltiplos dispositivos.', 'eletrônicos', 249.99),
('Console PlayStation 5', 'Console de última geração com SSD ultra-rápido, gráficos em 4K e áudio 3D, compatível com jogos de PS4 e PS5.', 'eletrônicos', 499.99),
('Teclado Mecânico Corsair K95 RGB', 'Teclado mecânico para jogos com switches Cherry MX Speed, iluminação RGB por tecla e descanso de pulso removível.', 'eletrônicos', 179.99),
('Monitor Gamer Asus ROG Swift PG279Q', 'Monitor gaming de 27 polegadas com resolução WQHD de 2560x1440, taxa de atualização de 165Hz e tecnologia G-Sync.', 'eletrônicos', 699.99),
('Câmera GoPro Hero 10 Black', 'Câmera de ação com vídeo 5.3K60, estabilização HyperSmooth 4.0 e streaming ao vivo em 1080p.', 'eletrônicos', 399.99),
('Drone DJI Air 2S', 'Drone dobrável com câmera de 20MP, gravação de vídeo 5.4K e sensores de obstáculos para voos seguros.', 'eletrônicos', 999.99),
('Smartwatch Apple Watch Series 7', 'Smartwatch com tela Retina sempre ativa, monitoramento avançado de saúde e resistência à água.', 'eletrônicos', 399.99),
('Câmera Mirrorless Sony Alpha a7 IV', 'Câmera mirrorless full-frame de 33MP, gravação de vídeo 4K e estabilização de imagem de 5 eixos.', 'eletrônicos', 2499.99),
('Console Xbox Series X', 'Console com SSD de 1TB, gráficos em 4K, taxa de atualização de até 120fps e compatibilidade com jogos de todas as gerações.', 'eletrônicos', 599.99),
('Caixa de Som Bluetooth Bose SoundLink Revolve+', 'Caixa de som portátil com som de 360 graus, resistente à água e até 17 horas de reprodução.', 'eletrônicos', 199.99),
('Fone de Ouvido Bluetooth Apple AirPods Pro', 'Fones de ouvido sem fio com cancelamento ativo de ruído, modo ambiente e ajuste personalizado.', 'eletrônicos', 249.99),
('Câmera Nikon Z7 II', 'Câmera mirrorless full-frame de 45.7MP, gravação de vídeo 4K e foco automático de detecção de fase com 493 pontos.', 'eletrônicos', 2999.99),
('Monitor Ultrawide Samsung Odyssey G9', 'Monitor curvo de 49 polegadas com resolução QHD de 5120x1440, taxa de atualização de 240Hz e HDR1000.', 'eletrônicos', 1499.99),
('Smart TV LG OLED C1 65"', 'Smart TV 4K OLED de 65 polegadas, processador α9 Gen4 AI, Dolby Vision IQ e som Dolby Atmos.', 'eletrônicos', 1999.99),
('Câmera de Segurança Ring Spotlight Cam', 'Câmera de segurança externa com visão noturna, luz LED integrada e detecção de movimento personalizável.', 'eletrônicos', 199.99),
('Roteador Mesh Google Nest Wifi', 'Sistema Wi-Fi mesh com roteador e pontos de acesso, cobertura em toda a casa e controle por aplicativo.', 'eletrônicos', 299.99),
('Console Nintendo Switch OLED', 'Console híbrido com tela OLED de 7 polegadas, controles Joy-Con destacáveis e modo de mesa ou portátil.', 'eletrônicos', 349.99),
('Caixa de Som Sonos Move', 'Caixa de som inteligente com Wi-Fi e Bluetooth, resistente a choques e à prova de água, até 11 horas de bateria.', 'eletrônicos', 399.99),
('Fone de Ouvido Gaming HyperX Cloud II', 'Fone de ouvido com som surround virtual 7.1, drivers de 53mm e microfone removível com cancelamento de ruído.', 'eletrônicos', 99.99),
('Câmera Sony A7S III', 'Câmera mirrorless full-frame de 12.1MP, gravação de vídeo 4K 120fps e sensibilidade ISO de até 409600.', 'eletrônicos', 3499.99),
('Monitor Gamer MSI Optix MAG341CQ', 'Monitor curvo ultrawide de 34 polegadas com resolução WQHD de 3440x1440, taxa de atualização de 100Hz e AMD FreeSync.', 'eletrônicos', 499.99),
('Projetor Epson Home Cinema 5050UB', 'Projetor 4K PRO-UHD com tecnologia HDR, contraste dinâmico de 1.000.000:1 e lente motorizada.', 'eletrônicos', 1999.99),
('Console Sega Genesis Mini', 'Console retro compacto com 42 jogos clássicos, saída HDMI e design inspirado no console original.', 'eletrônicos', 79.99),
('Caixa de Som Bluetooth Ultimate Ears BOOM 3', 'Caixa de som portátil com som envolvente de 360 graus, à prova d\'água e flutuante.', 'eletrônicos', 129.99),
('Fone de Ouvido JBL Tune 750BTNC', 'Fones de ouvido sem fio com cancelamento de ruído ativo, bateria de até 15 horas e design dobrável.', 'eletrônicos', 79.99),
('Câmera de Ação DJI Osmo Action', 'Câmera de ação com tela frontal, resistente à água até 11m, gravação de vídeo 4K e estabilização RockSteady.', 'eletrônicos', 299.99),
('Monitor LG UltraGear 27GN950-B', 'Monitor gaming de 27 polegadas com resolução 4K UHD, taxa de atualização de 144Hz e tecnologia Nano IPS.', 'eletrônicos', 799.99),
('Câmera Canon EOS RP', 'Câmera mirrorless full-frame de 26.2MP, gravação de vídeo 4K e Dual Pixel CMOS AF para foco rápido e preciso.', 'eletrônicos', 999.99),
('Console Atari Flashback 9', 'Console retro com 110 jogos clássicos da Atari, saída HDMI e dois controles sem fio.', 'eletrônicos', 49.99),
('Caixa de Som Sonos One', 'Caixa de som inteligente com controle por voz, compatível com Amazon Alexa e Google Assistant.', 'eletrônicos', 199.99),
('Fone de Ouvido Beats Studio Buds', 'Fones de ouvido sem fio com cancelamento de ruído ativo, até 8 horas de bateria e resistência à água.', 'eletrônicos', 149.99),
('Câmera Panasonic Lumix GH5', 'Câmera mirrorless 4K com estabilização de imagem de 5 eixos, gravação em 4K 60fps e modo de foto em 6K.', 'eletrônicos', 1499.99),
('Monitor Samsung Odyssey G7', 'Monitor curvo de 32 polegadas com resolução QHD de 2560x1440, taxa de atualização de 240Hz e tempo de resposta de 1ms.', 'eletrônicos', 799.99),
('Console Retro-Bit Super Retro Trio', 'Console retro compatível com jogos de NES, SNES e Genesis, com dois controles e saída HDMI.', 'eletrônicos', 99.99),
('Caixa de Som Bose Soundbar 700', 'Soundbar com som surround Dolby Atmos, calibração de áudio adaptável e controle por voz.', 'eletrônicos', 799.99),
('Fone de Ouvido Sennheiser HD 660 S', 'Fones de ouvido abertos com som natural e detalhado, drivers de alta qualidade e almofadas confortáveis.', 'eletrônicos', 499.99),
('Câmera Fujifilm X-T4', 'Câmera mirrorless APS-C de 26.1MP, gravação de vídeo DCI 4K e estabilização de imagem de 6.5 pontos.', 'eletrônicos', 1499.99),
('Monitor Acer Predator X38', 'Monitor ultrawide curvo de 37.5 polegadas com resolução UWQHD+ de 3840x1600, taxa de atualização de 175Hz e NVIDIA G-Sync.', 'eletrônicos', 1999.99),
('Câmera de Segurança Arlo Pro 4', 'Câmera de segurança Wi-Fi com resolução 2K, visão noturna em cores e compatibilidade com Amazon Alexa e Google Assistant.', 'eletrônicos', 199.99),
('Console Analógico Sega Genesis Mini', 'Console retro com 42 jogos clássicos, saída HDMI e dois controles com fio.', 'eletrônicos', 59.99),
('Caixa de Som JBL Flip 5', 'Caixa de som portátil à prova d\'água com Bluetooth, bateria de até 12 horas e JBL PartyBoost para conectar várias caixas.', 'eletrônicos', 119.99),
('Fone de Ouvido Bose QuietComfort 45', 'Fones de ouvido com cancelamento de ruído ajustável, até 24 horas de bateria e modo de transparência para ouvir o ambiente.', 'eletrônicos', 299.99),
('Câmera DJI Pocket 2', 'Câmera de bolso com estabilização de imagem de 3 eixos, gravação de vídeo 4K e uma variedade de acessórios.', 'eletrônicos', 349.99),
('Monitor Dell S2721DGF', 'Monitor gaming de 27 polegadas com resolução QHD de 2560x1440, taxa de atualização de 165Hz e tecnologia AMD FreeSync Premium Pro.', 'eletrônicos', 499.99),
('Câmera Nikon D850', 'Câmera DSLR full-frame de 45.7MP, gravação de vídeo 4K UHD e sistema de foco automático de 153 pontos.', 'eletrônicos', 2999.99),
('Console Retro-Bit Super Retro Trio Plus', 'Console retro compatível com jogos de NES, SNES, Genesis e Game Boy, com dois controles e saída HDMI.', 'eletrônicos', 129.99),
('Caixa de Som Sony SRS-XB33', 'Caixa de som portátil com Extra Bass, luzes LED integradas, à prova d\'água e até 24 horas de bateria.', 'eletrônicos', 149.99),
('Fone de Ouvido SteelSeries Arctis 7', 'Fones de ouvido sem fio para jogos com som surround DTS Headphone:X v2.0, microfone ClearCast e bateria de até 24 horas.', 'eletrônicos', 149.99),
('Câmera Canon EOS 90D', 'Câmera DSLR APS-C de 32.5MP, gravação de vídeo 4K e sistema Dual Pixel CMOS AF para foco rápido e preciso.', 'eletrônicos', 1199.99),
('Monitor ViewSonic VX2758-2KP-MHD', 'Monitor gaming de 27 polegadas com resolução QHD de 2560x1440, taxa de atualização de 144Hz e tecnologia AMD FreeSync.', 'eletrônicos', 299.99),
('Câmera Panasonic Lumix GH5S', 'Câmera mirrorless 4K com sensibilidade ISO de até 204800, gravação de vídeo 4K 60fps e V-LogL pré-instalado.', 'eletrônicos', 1999.99),
('Console Analógico Atari Flashback 9', 'Console retro com 110 jogos clássicos da Atari, saída HDMI e dois controles com fio.', 'eletrônicos', 49.99),
('Caixa de Som Ultimate Ears WONDERBOOM 2', 'Caixa de som portátil à prova d\'água com som surpreendentemente alto, até 13 horas de bateria e emparelhamento estéreo.', 'eletrônicos', 79.99),
('Fone de Ouvido Razer BlackShark V2', 'Fones de ouvido para jogos com som espacial THX, drivers de 50mm e microfone com cancelamento de ruído.', 'eletrônicos', 99.99),
('Câmera Sony Alpha 7 III', 'Câmera mirrorless full-frame de 24.2MP, gravação de vídeo 4K e sistema de autofoco híbrido com detecção de fase.', 'eletrônicos', 1999.99),
('Monitor LG UltraFine 5K', 'Monitor 5K de 27 polegadas com resolução de 5120x2880, ampla gama de cores P3 e Thunderbolt 3 para conectividade rápida.', 'eletrônicos', 1299.99),
('Cafeteira Elétrica Philips Walita', 'Cafeteira com jarra térmica de aço inoxidável, capacidade para 1,2 litros e função de programação.', 'domésticos', 129.99),
('Batedeira Oster Planetary', 'Batedeira planetária com motor potente de 600W, tigela de 4 litros e sistema de movimento planetário.', 'domésticos', 179.99),
('Liquidificador Britânia Diamante 800', 'Liquidificador com jarra de plástico resistente com capacidade para 2,4 litros e lâminas serrilhadas em aço inoxidável.', 'domésticos', 79.99),
('Mixer Philco Mix', 'Mixer com lâmina em aço inoxidável, copo medidor com tampa e função turbo para misturas mais rápidas.', 'domésticos', 49.99),
('Processador de Alimentos Hamilton Beach Big Mouth', 'Processador com boca de alimentação extra larga, disco de corte reversível e função de pulsar.', 'domésticos', 149.99),
('Fritadeira Air Fryer Mondial Family Inox', 'Fritadeira sem óleo com capacidade para 3,2 litros, timer de 60 minutos e controle de temperatura até 200°C.', 'domésticos', 249.99),
('Panela Elétrica de Arroz Britânia PA5 Prime', 'Panela elétrica de arroz com capacidade para 5 copos, função automática de aquecimento e tampa com alça.', 'domésticos', 99.99),
('Torradeira Cadence Tosta Pane', 'Torradeira com capacidade para 2 fatias, controle de tostagem ajustável e bandeja removível para migalhas.', 'domésticos', 39.99),
('Grill e Sanduicheira George Foreman', 'Grill com capacidade para 4 sanduíches, placas antiaderentes e controle de temperatura ajustável.', 'domésticos', 69.99),
('Espremedor de Frutas Elétrico Mondial Turbo Citrus', 'Espremedor de frutas com cone reversível para limão e laranja, jarra de 1,5 litros e acionamento automático.', 'domésticos', 29.99),
('Pipoqueira Elétrica Britânia Pop Time', 'Pipoqueira com capacidade para 120g de milho, bocal direcionador e preparo rápido em poucos minutos.', 'domésticos', 49.99),
('Omeleteira Britânia Duo', 'Omeleteira com capacidade para 2 omeletes, revestimento antiaderente e luz indicadora de funcionamento.', 'domésticos', 39.99),
('Forno Elétrico Philco PFE45P', 'Forno elétrico com capacidade para 45 litros, controle de temperatura até 250°C e timer de 90 minutos.', 'domésticos', 299.99),
('Churrasqueira Elétrica Cadence Gourmet', 'Churrasqueira elétrica com grelha removível, bandeja coletora de gordura e controle de temperatura ajustável.', 'domésticos', 129.99),
('Panela de Pressão Elétrica Mondial Pratic Cook', 'Panela de pressão elétrica com capacidade para 4 litros, 8 sistemas de segurança e timer de até 60 minutos.', 'domésticos', 149.99),
('Frigideira Inox Tramontina Allegra', 'Frigideira em aço inox com fundo triplo, cabo antitérmico e capacidade para 1,5 litros.', 'domésticos', 49.99),
('Caçarola de Cerâmica Brinox Chilli', 'Caçarola em cerâmica resistente, alças ergonômicas e capacidade para 2,5 litros.', 'domésticos', 59.99),
('Caldeirão Tramontina Solar', 'Caldeirão em aço inox com fundo triplo, tampa com saída de vapor e capacidade para 20 litros.', 'domésticos', 129.99),
('Wok Antiaderente KitchenAid Gourmet', 'Wok em alumínio revestido com 28cm de diâmetro, cabo em aço inox e alta durabilidade.', 'domésticos', 79.99),
('Assadeira de Vidro Marinex', 'Assadeira retangular em vidro temperado, resistente a choques térmicos e capacidade para 3 litros.', 'domésticos', 19.99),
('Bule Térmico Invicta', 'Bule térmico em inox com capacidade para 1 litro, ampola de vidro e sistema corta-pingos.', 'domésticos', 29.99),
('Chaleira Tramontina Solar', 'Chaleira em aço inox com apito, alça ergonômica e capacidade para 2,5 litros.', 'domésticos', 39.99),
('Escorredor de Massas Tramontina Utilità', 'Escorredor de massas em aço inox com alças laterais e capacidade para 3 litros.', 'domésticos', 19.99),
('Cuzcuzeira Tramontina Solar', 'Cuzcuzeira em aço inox com fundo triplo, tampa com saída de vapor e capacidade para 2,5 litros.', 'domésticos', 49.99),
('Tábua de Corte de Madeira Tramontina', 'Tábua de corte em madeira tratada com acabamento em verniz, resistente e durável.', 'domésticos', 9.99),
('Conchas Tramontina Laguna', 'Conjunto com 3 conchas em aço inox, cabo ergonômico e design moderno.', 'domésticos', 14.99),
('Escumadeira Tramontina Allegra', 'Escumadeira em aço inox com cabo antitérmico e design funcional.', 'domésticos', 9.99),
('Peneira de Aço Inox Tramontina Utilità', 'Peneira em aço inox com malha fina, cabo ergonômico e alta durabilidade.', 'domésticos', 9.99),
('Abridor de Latas Tramontina Utilità', 'Abridor de latas em aço inox resistente e design prático.', 'domésticos', 7.99),
('Faca de Pão Tramontina Century', 'Faca de pão em aço inox com lâmina serrilhada, cabo ergonômico e alta durabilidade.', 'domésticos', 19.99),
('Tesoura para Cozinha Tramontina Century', 'Tesoura em aço inox com lâminas serrilhadas e cabo ergonômico.', 'domésticos', 14.99),
('Jogo de Facas Tramontina Century', 'Conjunto com 5 facas em aço inox de alta qualidade e design moderno.', 'domésticos', 99.99),
('Descascador de Legumes Tramontina Century', 'Descascador de legumes em aço inox com lâmina afiada e design ergonômico.', 'domésticos', 7.99),
('Tigelas de Vidro Marinex', 'Conjunto com 3 tigelas em vidro temperado com capacidades de 500ml, 1 litro e 2 litros.', 'domésticos', 29.99),
('Pão-duro de Silicone KitchenAid', 'Pão-duro em silicone flexível, resistente ao calor e fácil de limpar.', 'domésticos', 9.99),
('Rolo de Macarrão Tramontina Utilità', 'Rolo de macarrão em madeira tratada com acabamento em verniz, resistente e durável.', 'domésticos', 14.99),
('Facas de Churrasco Tramontina Jumbo', 'Conjunto com 6 facas de churrasco em aço inox com lâmina serrilhada e cabo de madeira.', 'domésticos', 49.99),
('Pilão de Granito Tramontina Utilità', 'Pilão em granito polido, resistente e durável, ideal para moer temperos e ervas.', 'domésticos', 29.99),
('Ralador Tramontina Utilità', 'Ralador em aço inox com cabo ergonômico e lâmina afiada, ideal para queijos e legumes.', 'domésticos', 12.99),
('Fouet Tramontina Century', 'Fouet em aço inox com design ergonômico e fios flexíveis, ideal para bater claras em neve e molhos.', 'domésticos', 12.99),
('Pratos Fundos Oxford Daily', 'Conjunto com 6 pratos fundos em porcelana branca de alta qualidade e design clássico.', 'domésticos', 39.99),
('Pratos Rasos Oxford Daily', 'Conjunto com 6 pratos rasos em porcelana branca de alta qualidade e design clássico.', 'domésticos', 39.99),
('Pratos de Sobremesa Oxford Daily', 'Conjunto com 6 pratos de sobremesa em porcelana branca de alta qualidade e design clássico.', 'domésticos', 29.99),
('Vasilha de Vidro Quadrada Marinex', 'Vasilha de vidro temperado com tampa hermética e capacidade para 1,5 litros.', 'domésticos', 14.99),
('Travessa de Vidro Redonda Marinex', 'Travessa de vidro temperado com bordas altas, resistente a choques térmicos e capacidade para 2 litros.', 'domésticos', 19.99),
('Garfos Tramontina Century', 'Conjunto com 6 garfos em aço inox de alta qualidade e design elegante.', 'domésticos', 29.99),
('Colheres Tramontina Century', 'Conjunto com 6 colheres de mesa em aço inox de alta qualidade e design elegante.', 'domésticos', 29.99),
('Colher de Sobremesa Tramontina Century', 'Conjunto com 6 colheres de sobremesa em aço inox de alta qualidade e design elegante.', 'domésticos', 19.99),
('Potes de Sobremesa Duralex', 'Conjunto com 6 potes de vidro temperado com tampa hermética, capacidades de 100ml, 200ml e 400ml.', 'domésticos', 39.99),
('Copos Americanos Nadir Figueiredo', 'Conjunto com 12 copos americanos em vidro transparente de alta qualidade e resistência.', 'domésticos', 19.99),
('Taças de Vinho Nadir Figueiredo', 'Conjunto com 6 taças de vinho tinto em vidro transparente de alta qualidade e design clássico.', 'domésticos', 39.99),
('Taças de Champagne Nadir Figueiredo', 'Conjunto com 6 taças de champagne em vidro transparente de alta qualidade e design elegante.', 'domésticos', 39.99),
('Taças de Água Nadir Figueiredo', 'Conjunto com 6 taças de água em vidro transparente de alta qualidade e design clássico.', 'domésticos', 39.99),
('Copos Coloridos Nadir Figueiredo', 'Conjunto com 6 copos coloridos em vidro de alta qualidade e design moderno.', 'domésticos', 29.99),
('Xícaras de Café e Pires Oxford Porcelanas', 'Conjunto com 6 xícaras de café com pires em porcelana branca de alta qualidade e design clássico.', 'domésticos', 29.99),
('Canecas de Porcelana Oxford Porcelanas', 'Conjunto com 6 canecas em porcelana branca de alta qualidade e design clássico.', 'domésticos', 39.99),
('Garrafa Térmica Invicta Pressão', 'Garrafa térmica em inox com ampola de vidro, capacidade para 1 litro e sistema de pressão.', 'domésticos', 49.99),
('Liquidificador Philips Walita ProBlend', 'Liquidificador com jarra de vidro de 2 litros, lâminas de aço inoxidável e potência de 800W.', 'domésticos', 99.99),
('Batedeira Mondial Power Mix', 'Batedeira com potência de 400W, tigela de 4 litros e 4 velocidades mais função pulsar.', 'domésticos', 79.99),
('Porta-Temperos de Bambu e Vidro', 'Porta-temperos com suporte de bambu e 6 potes de vidro com tampa hermética.', 'domésticos', 29.99),
('Potes Herméticos Tramontina Utilità', 'Conjunto com 6 potes herméticos em plástico resistente e tampa de rosca.', 'domésticos', 19.99),
('Potes de Plástico com Tampa Tramontina', 'Conjunto com 12 potes em plástico resistente com tampas coloridas.', 'domésticos', 24.99),
('Caixas Organizadoras Nilit', 'Conjunto com 3 caixas organizadoras em plástico resistente e design moderno.', 'domésticos', 39.99),
('Rodinho de Pia Tramontina', 'Rodinho de pia em plástico resistente com ventosa para fixação.', 'domésticos', 9.99),
('Organizadores de Produtos de Limpeza', 'Conjunto com 3 organizadores em plástico resistente para detergente, esponja e escorredor de louças.', 'domésticos', 19.99),
('Pregadores de Embalagens', 'Conjunto com 12 pregadores de embalagens em plástico resistente e cores sortidas.', 'domésticos', 4.99),
('Tábua de Passar Roupa Mor', 'Tábua de passar roupa em madeira com estrutura em metal dobrável e capa em algodão.', 'domésticos', 59.99),
('Pregadores de Roupa Mor', 'Conjunto com 24 pregadores de roupa em plástico resistente e cores sortidas.', 'domésticos', 9.99),
('Cesto para Guardar Pregadores', 'Cesto em plástico resistente para guardar pregadores de roupa.', 'domésticos', 9.99),
('Cestos Organizadores Nilit', 'Conjunto com 3 cestos organizadores em plástico resistente e design moderno.', 'domésticos', 39.99),
('Cesto para Roupas Sujas Mor', 'Cesto em plástico resistente com tampa e alças laterais para transporte.', 'domésticos', 29.99),
('Bacia de Plástico Nilit', 'Bacia em plástico resistente com capacidade para 10 litros e design ergonômico.', 'domésticos', 9.99),
('Balde de Plástico Nilit', 'Balde em plástico resistente com capacidade para 10 litros e alça ergonômica.', 'domésticos', 14.99),
('Rodinho para Pia Mor', 'Rodinho para pia em plástico resistente com ventosa para fixação.', 'domésticos', 7.99),
('Vassoura Mor', 'Vassoura com cerdas sintéticas e cabo em alumínio com ponteira para pendurar.', 'domésticos', 19.99),
('Pá para Recolher Lixo Mor', 'Pá para recolher lixo em plástico resistente com cabo ergonômico.', 'domésticos', 14.99),
('Escova para Limpeza com Cabo Mor', 'Escova para limpeza com cabo em plástico resistente e cerdas sintéticas.', 'domésticos', 9.99),
('Porta-Sabonetes Mor', 'Porta-sabonetes em plástico resistente com design moderno e compartimento para sabão líquido.', 'domésticos', 9.99),
('Organizadores de Pia para Produtos de Higiene', 'Conjunto com 3 organizadores em plástico resistente para shampoo, condicionador e cremes.', 'domésticos', 19.99),
('Porta-Utensílios para Papel Higiênico Mor', 'Porta-utensílios em plástico resistente para papel higiênico e rolos extras.', 'domésticos', 14.99),
('Cesto de Lixo com Tampa Mor', 'Cesto de lixo em plástico resistente com tampa basculante e alça para transporte.', 'domésticos', 24.99),
('Assadeira de Alumínio Tramontina', 'Assadeira retangular em alumínio, resistente e durável, ideal para assar bolos, tortas e outras receitas.', 'domésticos', 19.99),
('Forma de Pudim de Silicone', 'Forma de pudim em silicone flexível, resistente ao calor e fácil de desenformar.', 'domésticos', 14.99),
('Formas para Tortas com Fundo Falso', 'Conjunto com 3 formas para tortas em alumínio com fundo falso removível, fácil de desenformar e limpar.', 'domésticos', 29.99),
('Forma de Banho-Maria Tramontina', 'Forma de banho-maria em aço inox, resistente e durável, ideal para preparar pudins e outros alimentos.', 'domésticos', 24.99),
('Espátulas de Silicone Tramontina Utilità', 'Conjunto com 3 espátulas em silicone resistente ao calor, ideais para misturar e raspar recipientes.', 'domésticos', 14.99),
('Colheres de Sobremesa Tramontina Century', 'Conjunto com 6 colheres de sobremesa em aço inox de alta qualidade e design elegante.', 'domésticos', 19.99),
('Conjunto de Pratos Oxford Porcelanas', 'Conjunto com 12 pratos rasos em porcelana branca de alta qualidade e design clássico.', 'domésticos', 49.99),
('Jogo de Copos Nadir Figueiredo', 'Conjunto com 12 copos em vidro transparente de alta qualidade e resistência.', 'domésticos', 24.99),
('Taças de Vidro ou Cristais Nadir Figueiredo', 'Conjunto com 6 taças em vidro ou cristal transparente de alta qualidade e design elegante.', 'domésticos', 39.99),
('Jogo Americano Mor', 'Conjunto com 6 jogos americanos em tecido resistente e design moderno.', 'domésticos', 19.99),
('Sousplat Mor', 'Conjunto com 6 sousplats em material resistente e design elegante.', 'domésticos', 29.99),
('Cristaleira Mor', 'Cristaleira em madeira com portas de vidro e prateleiras internas para organizar copos e taças.', 'domésticos', 199.99),
('Garrafas de Vidro com Tampa', 'Conjunto com 3 garrafas em vidro transparente com tampa hermética.', 'domésticos', 29.99),
('Travessas para o Buffet', 'Conjunto com 3 travessas em porcelana branca de alta qualidade e design clássico.', 'domésticos', 49.99),
('Jogo de Copos Simples Nadir Figueiredo', 'Conjunto com 12 copos em vidro transparente de alta qualidade e resistência.', 'domésticos', 24.99),
('Taças de Vinho Nadir Figueiredo', 'Conjunto com 6 taças de vinho tinto em vidro transparente de alta qualidade e design clássico.', 'domésticos', 39.99),
('Taças de Champagne Nadir Figueiredo', 'Conjunto com 6 taças de champagne em vidro transparente de alta qualidade e design elegante.', 'domésticos', 39.99),
('Taças de Água Nadir Figueiredo', 'Conjunto com 6 taças de água em vidro transparente de alta qualidade e design clássico.', 'domésticos', 39.99),
('Copos Coloridos Nadir Figueiredo', 'Conjunto com 6 copos coloridos em vidro de alta qualidade e design moderno.', 'domésticos', 29.99),
('Xícaras de Café e Pires Oxford Porcelanas', 'Conjunto com 6 xícaras de café com pires em porcelana branca de alta qualidade e design clássico.', 'domésticos', 29.99),
('Canecas de Porcelana Oxford Porcelanas', 'Conjunto com 6 canecas em porcelana branca de alta qualidade e design clássico.', 'domésticos', 39.99),
('Garrafa Térmica Invicta Pressão', 'Garrafa térmica em inox com ampola de vidro, capacidade para 1 litro e sistema de pressão.', 'domésticos', 49.99),
('Liquidificador Philips Walita ProBlend', 'Liquidificador com jarra de vidro de 2 litros, lâminas de aço inoxidável e potência de 800W.', 'domésticos', 99.99),
('Batedeira Mondial Power Mix', 'Batedeira com potência de 400W, tigela de 4 litros e 4 velocidades mais função pulsar.', 'domésticos', 79.99),
('Porta-Temperos de Bambu e Vidro', 'Porta-temperos com suporte de bambu e 6 potes de vidro com tampa hermética.', 'domésticos', 29.99),
('Potes Herméticos Tramontina Utilità', 'Conjunto com 6 potes herméticos em plástico resistente e tampa de rosca.', 'domésticos', 19.99),
('Potes de Plástico com Tampa Tramontina', 'Conjunto com 12 potes em plástico resistente com tampas coloridas.', 'domésticos', 24.99),
('Caixas Organizadoras Nilit', 'Conjunto com 3 caixas organizadoras em plástico resistente e design moderno.', 'domésticos', 39.99),
('Rodinho de Pia Tramontina', 'Rodinho de pia em plástico resistente com ventosa para fixação.', 'domésticos', 9.99),
('Organizadores de Produtos de Limpeza', 'Conjunto com 3 organizadores em plástico resistente para detergente, esponja e escorredor de louças.', 'domésticos', 19.99),
('Pregadores de Embalagens', 'Conjunto com 12 pregadores de embalagens em plástico resistente e cores sortidas.', 'domésticos', 4.99),
('Tábua de Passar Roupa Mor', 'Tábua de passar roupa em madeira com estrutura em metal dobrável e capa em algodão.', 'domésticos', 59.99),
('Pregadores de Roupa Mor', 'Conjunto com 24 pregadores de roupa em plástico resistente e cores sortidas.', 'domésticos', 9.99),
('Cesto para Guardar Pregadores', 'Cesto em plástico resistente para guardar pregadores de roupa.', 'domésticos', 9.99),
('Cestos Organizadores Nilit', 'Conjunto com 3 cestos organizadores em plástico resistente e design moderno.', 'domésticos', 39.99),
('Cesto para Roupas Sujas Mor', 'Cesto em plástico resistente com tampa e alças laterais para transporte.', 'domésticos', 29.99),
('Bacia de Plástico Nilit', 'Bacia em plástico resistente com capacidade para 10 litros e design ergonômico.', 'domésticos', 9.99),
('Balde de Plástico Nilit', 'Balde em plástico resistente com capacidade para 10 litros e alça ergonômica.', 'domésticos', 14.99),
('Rodinho para Pia Mor', 'Rodinho para pia em plástico resistente com ventosa para fixação.', 'domésticos', 7.99),
('Vassoura Mor', 'Vassoura com cerdas sintéticas e cabo em alumínio com ponteira para pendurar.', 'domésticos', 19.99),
('Pá para Recolher Lixo Mor', 'Pá para recolher lixo em plástico resistente com cabo ergonômico.', 'domésticos', 14.99),
('Escova para Limpeza com Cabo Mor', 'Escova para limpeza com cabo em plástico resistente e cerdas sintéticas.', 'domésticos', 9.99),
('Porta-Sabonetes Mor', 'Porta-sabonetes em plástico resistente com design moderno e compartimento para sabão líquido.', 'domésticos', 9.99),
('Organizadores de Pia para Produtos de Higiene', 'Conjunto com 3 organizadores em plástico resistente para shampoo, condicionador e cremes.', 'domésticos', 19.99),
('Porta-Utensílios para Papel Higiênico Mor', 'Porta-utensílios em plástico resistente para papel higiênico e rolos extras.', 'domésticos', 14.99),
('Cesto de Lixo com Tampa Mor', 'Cesto de lixo em plástico resistente com tampa basculante e alça para transporte.', 'domésticos', 24.99),
('Calça Jeans Skinny Levi''s', 'Calça jeans feminina modelo skinny da marca Levi''s, com cintura alta e lavagem clássica.', 'vestimentas', 129.99),
('Bermuda Masculina Nike Dri-Fit', 'Bermuda esportiva masculina da Nike, com tecnologia Dri-Fit para absorção do suor e liberdade de movimento.', 'vestimentas', 79.99),
('Moletom Unissex Gap', 'Moletom unissex da marca Gap, com capuz, bolso canguru e tecido macio e confortável.', 'vestimentas', 59.99),
('Vestido Floral Manga Longa', 'Vestido feminino estampado floral, com manga longa e tecido leve e fluido, ideal para o dia a dia.', 'vestimentas', 79.99),
('Camisa Polo Lacoste Slim Fit', 'Camisa polo masculina da Lacoste, modelo Slim Fit, com gola e punhos canelados e logo bordado no peito.', 'vestimentas', 99.99),
('Blusa Cropped Feminina', 'Blusa feminina cropped com decote ombro a ombro e mangas bufantes, em tecido leve e delicado.', 'vestimentas', 49.99),
('Jaqueta Corta-Vento Adidas', 'Jaqueta corta-vento unissex da Adidas, com capuz dobrável, bolsos laterais e fechamento em zíper.', 'vestimentas', 89.99),
('Calça Legging Nike Power', 'Calça legging feminina da Nike, modelo Power, com cós largo e tecido que proporciona suporte e conforto.', 'vestimentas', 69.99),
('Camiseta Básica Unissex', 'Camiseta unissex básica, com gola redonda e tecido macio e confortável, disponível em diversas cores.', 'vestimentas', 29.99),
('Saia Midi Plissada', 'Saia feminina midi plissada, com cintura alta e detalhes em pregas, em tecido leve e elegante.', 'vestimentas', 59.99),
('Casaco de Lã Masculino', 'Casaco de lã masculino com fechamento em botões, gola alta e bolsos frontais, ideal para dias mais frios.', 'vestimentas', 129.99),
('Vestido Tubinho Preto', 'Vestido feminino tubinho na cor preta, com decote em V e comprimento na altura dos joelhos, perfeito para ocasiões formais.', 'vestimentas', 89.99),
('Camisa Social Slim Fit', 'Camisa social masculina slim fit, em tecido de algodão de alta qualidade e design elegante.', 'vestimentas', 79.99),
('Blusa de Tricô Feminina', 'Blusa feminina de tricô, com gola alta e detalhes em tranças, ideal para os dias mais frios.', 'vestimentas', 69.99),
('Calça Cargo Masculina', 'Calça cargo masculina em tecido resistente, com bolsos laterais e fechamento em zíper e botão.', 'vestimentas', 89.99),
('Blusa de Moletom Oversized', 'Blusa de moletom feminina modelo oversized, com capuz e detalhes em estampa frontal, confortável e estilosa.', 'vestimentas', 79.99),
('Jaqueta Jeans Feminina', 'Jaqueta jeans feminina com lavagem destroyed, bolsos frontais e fechamento em botões, peça versátil para compor looks.', 'vestimentas', 99.99),
('Vestido Longo Estampado', 'Vestido feminino longo estampado, com alças finas ajustáveis e fenda lateral, ideal para ocasiões casuais.', 'vestimentas', 109.99),
('Calça Jogger Masculina', 'Calça jogger masculina em tecido de moletom, com cós elástico e punhos ajustados, confortável e moderna.', 'vestimentas', 69.99),
('Blusa de Crochê Boho', 'Blusa feminina de crochê estilo boho, com detalhes vazados e mangas flare, perfeita para looks de verão.', 'vestimentas', 49.99),
('Colete Acolchoado Unissex', 'Colete acolchoado unissex, com gola alta, fechamento em zíper e bolsos laterais, ideal para dias mais frescos.', 'vestimentas', 79.99),
('Macacão Pantacourt', 'Macacão feminino modelo pantacourt, com alças ajustáveis e cintura marcada, em tecido leve e fluído.', 'vestimentas', 119.99),
('Camiseta Estampada Masculina', 'Camiseta masculina estampada, com gola redonda e estampa frontal, em tecido de algodão macio e confortável.', 'vestimentas', 39.99),
('Vestido Midi Floral', 'Vestido feminino midi com estampa floral, alças finas e detalhe franzido na cintura, peça versátil para diversas ocasiões.', 'vestimentas', 89.99),
('Blazer Slim Fit', 'Blazer masculino slim fit em tecido de algodão, com fechamento em botões e bolsos frontais com lapela.', 'vestimentas', 149.99),
('Blusa de Alça Cropped', 'Blusa feminina de alça cropped, com decote coração e detalhe franzido, em tecido leve e confortável.', 'vestimentas', 59.99),
('Shorts Jeans Feminino', 'Shorts jeans feminino com barra desfiada, cintura alta e lavagem destroyed, peça casual e estilosa.', 'vestimentas', 49.99),
('Camisa Estampada Masculina', 'Camisa masculina estampada, com manga curta e fechamento em botões, em tecido de algodão leve e confortável.', 'vestimentas', 69.99),
('Vestido Chemise Listrado', 'Vestido feminino modelo chemise listrado, com cinto para amarração na cintura e tecido leve e fluído.', 'vestimentas', 79.99),
('Calça Pantalona', 'Calça pantalona feminina em tecido leve e fluído, cintura alta e detalhe de pregas, peça elegante e confortável.', 'vestimentas', 99.99),
('Camiseta Básica Masculina', 'Camiseta básica masculina em cores sortidas, gola redonda e tecido macio e confortável.', 'vestimentas', 29.99),
('Saia Lápis de Cintura Alta', 'Saia lápis feminina de cintura alta, com detalhe de fenda frontal e comprimento na altura dos joelhos, peça clássica e elegante.', 'vestimentas', 69.99),
('Jaqueta Corta-Vento Nike', 'Jaqueta corta-vento feminina da Nike, com capuz dobrável, bolsos laterais e fechamento em zíper.', 'vestimentas', 99.99),
('Vestido Ciganinha Estampado', 'Vestido feminino ciganinha com estampa floral, mangas bufantes e detalhe de babados, ideal para looks românticos.', 'vestimentas', 79.99),
('Calça Jeans Skinny Masculina', 'Calça jeans masculina modelo skinny, com lavagem escura e detalhes de puídos, peça versátil para diversas ocasiões.', 'vestimentas', 89.99),
('Regata Básica Unissex', 'Regata básica unissex em cores sortidas, modelagem ampla e tecido leve e confortável.', 'vestimentas', 19.99),
('Vestido Midi de Linho', 'Vestido feminino midi em tecido de linho, com alças finas ajustáveis e detalhe de botões frontais, peça leve e elegante.', 'vestimentas', 109.99),
('Shorts de Praia Estampado', 'Shorts de praia masculino estampado, com elástico na cintura e tecido de secagem rápida, ideal para dias de sol.', 'vestimentas', 39.99),
('Blusa de Manga Longa Feminina', 'Blusa feminina de manga longa com detalhe de amarração na frente, em tecido leve e fluido, ideal para meia estação.', 'vestimentas', 59.99),
('Blusa de Moletom Cropped', 'Blusa de moletom feminina cropped com capuz e estampa frontal, peça confortável e despojada para o dia a dia.', 'vestimentas', 69.99),
('Camisa Polo Listrada', 'Camisa polo masculina listrada em cores neutras, com gola e punhos em ribana e detalhe de bordado no peito.', 'vestimentas', 49.99),
('Vestido Longo de Festa', 'Vestido feminino longo de festa em tecido de chiffon, com decote em V e detalhe de drapeado, ideal para ocasiões especiais.', 'vestimentas', 179.99),
('Calça Clochard Feminina', 'Calça clochard feminina em tecido de alfaiataria, cintura alta e detalhe de amarração, peça elegante e confortável.', 'vestimentas', 99.99),
('Tênis Adidas Ultraboost', 'Tênis esportivo da linha Ultraboost da Adidas, com tecnologia de amortecimento responsivo e design moderno.', 'calçados', 349.99),
('Tênis Nike Air Max 270', 'Tênis esportivo da Nike, modelo Air Max 270, com amortecimento de espuma macia e visual arrojado.', 'calçados', 399.99),
('Tênis Asics Gel-Nimbus', 'Tênis de corrida da marca Asics, modelo Gel-Nimbus, com amortecimento em gel e suporte para o arco do pé.', 'calçados', 299.99),
('Tênis Converse All Star', 'Tênis casual da marca Converse, modelo All Star, em lona resistente e design clássico.', 'calçados', 129.99),
('Tênis Puma RS-X', 'Tênis esportivo da Puma, modelo RS-X, com entressola em espuma e design futurista.', 'calçados', 279.99),
('Tênis Adidas Ultraboost', 'Tênis esportivo da linha Ultraboost da Adidas, com tecnologia de amortecimento responsivo e design moderno.', 'calçados', 349.99),
('Sandália Havaianas Top', 'Sandália casual da marca Havaianas, modelo Top, com tiras de borracha e conforto duradouro.', 'calçados', 29.99),
('Sandália Rider Slide', 'Sandália masculina da Rider, modelo Slide, com tira larga e palmilha macia.', 'calçados', 39.99),
('Sandália Melissa Aranha', 'Sandália feminina da Melissa, modelo Aranha, com design icônico e material sintético confortável.', 'calçados', 69.99),
('Sandália Birkenstock Arizona', 'Sandália unissex da Birkenstock, modelo Arizona, com tiras ajustáveis e palmilha anatômica.', 'calçados', 149.99),
('Sandália Ipanema Classica', 'Sandália feminina da Ipanema, modelo Clássica, com tiras finas e solado antiderrapante.', 'calçados', 19.99),
('Sandália Havaianas Top', 'Sandália casual da marca Havaianas, modelo Top, com tiras de borracha e conforto duradouro.', 'calçados', 29.99);

DROP PROCEDURE IF EXISTS generate_pedidos;
DELIMITER $
CREATE PROCEDURE IF NOT EXISTS generate_pedidos(limite INT)
BEGIN
	INSERT INTO pedidos (cliente_id, data_pedido)
	-- CTE
    WITH RECURSIVE cte_increment as (
		SELECT 1 as n
        UNION ALL
        SELECT n + 1 FROM cte_increment WHERE n < limite
    )
	SELECT clienteRandom.clienteID as cliente_id, dataRandom.valor as data_pedido
	FROM (
		SELECT FLOOR(RAND() * (SELECT COUNT(id) FROM clientes)) + 1 as clienteID, n as onID
		FROM cte_increment 
	) as clienteRandom
	JOIN (
		SELECT CURRENT_DATE() - INTERVAL FLOOR((RAND()*60)+1) DAY as valor, n as onID
		FROM cte_increment 
	) as dataRandom
	ON clienteRandom.onID = dataRandom.onID
	LIMIT limite;
END$
DELIMITER ;

CALL generate_pedidos(150);

DROP PROCEDURE IF EXISTS generate_itens_pedido;
DELIMITER $
CREATE PROCEDURE IF NOT EXISTS generate_itens_pedido(limite INT, totalPedido INT)
BEGIN
	INSERT INTO itens_pedido (pedido_id, produto_id, quantidade)
    -- CTE
    WITH RECURSIVE cte_increment as (
		SELECT 1 as n
        UNION ALL
        SELECT n + 1 FROM cte_increment WHERE n < limite
    )
    SELECT pedidoRandom.pedidoID as pedido_id, produtoRandom.produtoID as produto_id, qtdeRandom.qtde as quantidade 
    FROM (
		SELECT FLOOR( (RAND() * totalPedido) + 1 )  as pedidoID, n as onID
        FROM cte_increment
    ) as pedidoRandom
    JOIN (
		SELECT FLOOR( (RAND() * (SELECT COUNT(id) FROM produtos) ) + 1 ) as produtoID, n as onID
        FROM cte_increment
    ) as produtoRandom
    JOIN (
		SELECT FLOOR( (RAND() * 4) + 1 ) as qtde, n as onID
        FROM cte_increment
    ) qtdeRandom
    ON pedidoRandom.onID = produtoRandom.onID
    AND pedidoRandom.onID = qtdeRandom.onID
    LIMIT limite;
END$
DELIMITER ;

CALL generate_itens_pedido(210, (SELECT COUNT(id) FROM pedidos));
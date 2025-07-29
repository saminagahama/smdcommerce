-- Active: 1726510728684@@127.0.0.1@5432@251web

CREATE TABLE Usuario (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    login VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    administrador BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO
    Usuario (
        id,
        nome,
        endereco,
        email,
        login,
        senha,
        administrador
    )
VALUES (
        1,
        'Administrador',
        'Rua Exemplo, 123',
        'admin@example.com',
        'admin',
        'admin',
        true
    );

CREATE TABLE Categoria (
    id INT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Produto (
    id INT PRIMARY KEY,
    descricao TEXT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    foto VARCHAR(255),
    quantidade INTEGER NOT NULL DEFAULT 0,
    categoria_id INT NOT NULL,
    CONSTRAINT fk_produto_categoria FOREIGN KEY (categoria_id) REFERENCES Categoria (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Venda (
    id INT PRIMARY KEY,
    data_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    usuario_id INT NOT NULL,
    CONSTRAINT fk_venda_usuario FOREIGN KEY (usuario_id) REFERENCES Usuario (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Venda_Produto (
    venda_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INTEGER NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (venda_id, produto_id),
    CONSTRAINT fk_vendaproduto_venda FOREIGN KEY (venda_id) REFERENCES Venda (id) ON DELETE CASCADE,
    CONSTRAINT fk_vendaproduto_produto FOREIGN KEY (produto_id) REFERENCES Produto (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

// coluna "foto" de usuário
ALTER TABLE produto ADD COLUMN foto BYTEA;

// coluna "estoque" de produto
ALTER TABLE produto ADD COLUMN estoque INTEGER NOT NULL DEFAULT 0 CHECK (estoque >= 0);

//alteração id de categoria
SELECT setval(pg_get_serial_sequence('categoria', 'id'), (SELECT MAX(id) FROM categoria));

//criação da tabela token
CREATE TABLE tokens (
    token VARCHAR(255) PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    data_expiracao TIMESTAMP NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

ALTER TABLE venda ADD COLUMN valor_total numeric(10,2) NOT NULL;
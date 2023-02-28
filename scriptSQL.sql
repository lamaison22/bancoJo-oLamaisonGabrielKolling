CREATE TABLE IF NOT EXISTS public.usuario
(
    id_usuario SERIAL, 
    usuario text NOT NULL UNIQUE,
    email text NOT NULL,
    senha text NOT NULL,
    CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario)
);

CREATE TABLE IF NOT EXISTS public.tipo_permissao
(
    id_tipo_permissao SERIAL,
    permissao text NOT NULL,
    CONSTRAINT tipo_permissao_pkey PRIMARY KEY (id_tipo_permissao)
);

CREATE TABLE IF NOT EXISTS public.permissao
(
    id_usuario bigint NOT NULL,
    id_tipo_permissao bigint NOT NULL,
    CONSTRAINT permissao_pkey PRIMARY KEY (id_usuario, id_tipo_permissao),
    CONSTRAINT permissao_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE CASCADE,
    CONSTRAINT permissao_tipo_permissao_fkey FOREIGN KEY (id_tipo_permissao) REFERENCES tipo_permissao (id_tipo_permissao) ON DELETE CASCADE
);

CREATE TABLE "estados" (
  "sigla" VARCHAR NOT NULL,
  "icms" real NOT NULL,
  CONSTRAINT pk_estados PRIMARY KEY (sigla)
);

CREATE TABLE "cliente" (
  "cnpj" VARCHAR NOT NULL,
  "estado" VARCHAR NOT NULL,
  "nome" VARCHAR NOT NULL,
  "cep" VARCHAR NOT NULL,
  CONSTRAINT pk_cliente PRIMARY KEY (cnpj)
);

CREATE TABLE "orcamento" (
  "id_orcamento" SERIAL,
  "tprio" VARCHAR NOT NULL,
  "vlserv" real NOT NULL,
  "vlfunc" real NOT NULL,
  "vlitens" real NOT NULL,
  "dtaber" DATE NOT NULL,
  "dtfecha" DATE NOT NULL,
  "sigla" VARCHAR NOT NULL,
  "cnpj" VARCHAR NOT NULL,
  CONSTRAINT pk_orcamento PRIMARY KEY (id_orcamento),
  CONSTRAINT fk_orcamento_estado FOREIGN KEY (sigla) REFERENCES estados (sigla),
  CONSTRAINT fk_orcamento_cliente FOREIGN KEY (cnpj) REFERENCES cliente (cnpj)
);

CREATE TABLE "servico" (
  "id_servico" SERIAL,
  "setor" VARCHAR NOT NULL,
  "desc" VARCHAR NOT NULL,
  CONSTRAINT pk_servico PRIMARY KEY (id_servico)
);

CREATE TABLE "funcionario" (
  "cpf" VARCHAR NOT NULL,
  "cargo" VARCHAR NOT NULL,
  "nome" VARCHAR NOT NULL,
  "vlhora" real NOT NULL,
  CONSTRAINT pk_funcionario PRIMARY KEY (cpf)
);

CREATE TABLE "imposto" (
  "id_imposto" SERIAL,
  "categoria" VARCHAR NOT NULL,
  "valor" real NOT NULL,
  "dtalt" DATE NOT NULL,
  "nome" VARCHAR NOT NULL,
  CONSTRAINT pk_imposto PRIMARY KEY (id_imposto)
);

CREATE TABLE "fornecedor" (
  "cnpj" VARCHAR NOT NULL,
  "nome" VARCHAR NOT NULL,
  "estado" VARCHAR NOT NULL,
  "cep" VARCHAR NOT NULL,
  CONSTRAINT pk_fornecedor PRIMARY KEY (cnpj)
);

CREATE TABLE "item" (
  "id_item" SERIAL,
  "custoun" real NOT NULL,
  "categoria" VARCHAR NOT NULL,
  "nome" VARCHAR NOT NULL,
  "unmedida" VARCHAR NOT NULL,
  "desc" VARCHAR NOT NULL,
  CONSTRAINT pk_item PRIMARY KEY (id_item)
);

CREATE TABLE "orcamento_servicos" (
  "id_servico" INTEGER NOT NULL,
  "id_orcamento" INTEGER NOT NULL,
  "dmontiso" real NOT NULL,
  "dmontmec" real NOT NULL,
  "qtdfunc" INTEGER NOT NULL,
  CONSTRAINT pk_orcamento_servicos PRIMARY KEY (id_servico, id_orcamento),
  CONSTRAINT fk_orcamento_servicos_servico FOREIGN KEY (id_servico) REFERENCES servico (id_servico),
  CONSTRAINT fk_orcamento_servicos_orcamento FOREIGN KEY (id_orcamento) REFERENCES orcamento (id_orcamento)
);

CREATE TABLE "orcamento_funcionarios" (
  "cpf" VARCHAR NOT NULL,
  "id_orcamento" INTEGER NOT NULL,
  CONSTRAINT pk_orcamento_funcionarios PRIMARY KEY (cpf, id_orcamento),
  CONSTRAINT fk_orcamento_funcionarios_funcionario FOREIGN KEY (cpf) REFERENCES funcionario (cpf),
  CONSTRAINT fk_orcamento_funcionarios_orcamento FOREIGN KEY (id_orcamento) REFERENCES orcamento (id_orcamento)
);

CREATE TABLE "orcamento_imposto" (
  "id_orcamento" INTEGER NOT NULL,
  "id_imposto" INTEGER NOT NULL,
  CONSTRAINT pk_orcamento_imposto PRIMARY KEY (id_orcamento, id_imposto),
  CONSTRAINT fk_orcamento_imposto_orcamento FOREIGN KEY (id_orcamento) REFERENCES orcamento (id_orcamento),
  CONSTRAINT fk_orcamento_imposto_imposto FOREIGN KEY (id_imposto) REFERENCES imposto (id_imposto)
);

CREATE TABLE "itens_fornecedor" (
  "id_item" INTEGER NOT NULL,
  "cnpj" VARCHAR NOT NULL,
  CONSTRAINT pk_itens_fornecedor PRIMARY KEY (id_item, cnpj),
  CONSTRAINT fk_itens_fornecedor_item FOREIGN KEY (id_item) REFERENCES item (id_item),
  CONSTRAINT fk_itens_fornecedor_fornecedor FOREIGN KEY (cnpj) REFERENCES fornecedor (cnpj)
);

CREATE TABLE "orcamento_itens" (
  "id_item" INTEGER NOT NULL,
  "id_orcamento" INTEGER NOT NULL,
  "qtd" INTEGER NOT NULL,
  CONSTRAINT pk_orcamento_itens PRIMARY KEY (id_item, id_orcamento),
  CONSTRAINT fk_orcamento_itens_item FOREIGN KEY (id_item) REFERENCES item (id_item),
  CONSTRAINT fk_orcamento_itens_orcamento FOREIGN KEY (id_orcamento) REFERENCES orcamento (id_orcamento)
);

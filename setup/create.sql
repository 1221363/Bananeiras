-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.aplicacao (
  terrenonome character varying NOT NULL,
  produtonome character varying NOT NULL,
  produtor character varying NOT NULL,
  temporada character varying NOT NULL,
  dataaplicacao date NOT NULL,
  quantidade numeric NOT NULL,
  stock_final numeric NOT NULL,
  id integer NOT NULL DEFAULT nextval('aplicacao_id_seq'::regclass),
  CONSTRAINT aplicacao_pkey PRIMARY KEY (id),
  CONSTRAINT aplicacao_terrenonome_fkey FOREIGN KEY (terrenonome) REFERENCES public.terreno(nome),
  CONSTRAINT aplicacao_produtor_fkey FOREIGN KEY (produtor) REFERENCES public.produtor(nome),
  CONSTRAINT aplicacao_produtonome_fkey FOREIGN KEY (produtonome) REFERENCES public.produto(nome)
);
CREATE TABLE public.armazem (
  nome character varying NOT NULL,
  CONSTRAINT armazem_pkey PRIMARY KEY (nome)
);
CREATE TABLE public.compra (
  produtonome character varying NOT NULL,
  quantidade numeric NOT NULL,
  datacompra date NOT NULL,
  id integer NOT NULL DEFAULT nextval('compra_id_seq'::regclass),
  CONSTRAINT compra_pkey PRIMARY KEY (id),
  CONSTRAINT compra_produtonome_fkey FOREIGN KEY (produtonome) REFERENCES public.produto(nome)
);
CREATE TABLE public.produto (
  nome character varying NOT NULL,
  tipoprodutonome character varying NOT NULL,
  CONSTRAINT produto_pkey PRIMARY KEY (nome),
  CONSTRAINT produto_tipoprodutonome_fkey FOREIGN KEY (tipoprodutonome) REFERENCES public.tipoproduto(nome)
);
CREATE TABLE public.produtor (
  nome character varying NOT NULL,
  CONSTRAINT produtor_pkey PRIMARY KEY (nome)
);
CREATE TABLE public.stock (
  armazemnome character varying NOT NULL,
  produtonome character varying NOT NULL,
  quantidade numeric NOT NULL,
  CONSTRAINT stock_pkey PRIMARY KEY (armazemnome, produtonome),
  CONSTRAINT stock_produtonome_fkey FOREIGN KEY (produtonome) REFERENCES public.produto(nome),
  CONSTRAINT stock_armazemnome_fkey FOREIGN KEY (armazemnome) REFERENCES public.armazem(nome)
);
CREATE TABLE public.terreno (
  nome character varying NOT NULL,
  armazemnome character varying NOT NULL,
  CONSTRAINT terreno_pkey PRIMARY KEY (nome),
  CONSTRAINT terreno_armazemnome_fkey FOREIGN KEY (armazemnome) REFERENCES public.armazem(nome)
);
CREATE TABLE public.tipoproduto (
  nome character varying NOT NULL,
  CONSTRAINT tipoproduto_pkey PRIMARY KEY (nome)
);
CREATE TABLE public.transferencia (
  armazemnome character varying NOT NULL CHECK (armazemnome::text <> 'Casa'::text),
  produtonome character varying NOT NULL,
  quantidade numeric NOT NULL,
  datatransferencia date NOT NULL,
  id integer NOT NULL DEFAULT nextval('transferencia_id_seq'::regclass),
  CONSTRAINT transferencia_pkey PRIMARY KEY (id),
  CONSTRAINT transferencia_produtonome_fkey FOREIGN KEY (produtonome) REFERENCES public.produto(nome),
  CONSTRAINT transferencia_armazemnome_fkey FOREIGN KEY (armazemnome) REFERENCES public.armazem(nome)
);
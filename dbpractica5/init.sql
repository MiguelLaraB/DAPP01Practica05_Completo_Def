--
-- PostgreSQL database initialization
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';
SET default_table_access_method = heap;

-- Primero crear todas las tablas
CREATE TABLE public.clientes (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    name character varying(255)
);

CREATE TABLE public.productos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    precio numeric(10,2) NOT NULL,
    name character varying(255)
);

CREATE TABLE public.venta (
    id integer NOT NULL,
    fecha date NOT NULL,
    monto numeric(10,2) NOT NULL,
    nombrecliente character varying(100) NOT NULL,
    idcliente integer,
    cliente_id bigint
);

CREATE TABLE public.detalleventa (
    idlinea integer NOT NULL,
    precio numeric(10,2) NOT NULL,
    descripcion character varying(255),
    cantidad integer NOT NULL,
    producto_id integer NOT NULL,
    venta_id integer NOT NULL
);

-- Luego crear las secuencias
CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.venta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.detalleventa_idlinea_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- Configurar las relaciones entre secuencias y tablas
ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);
ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);
ALTER TABLE ONLY public.venta ALTER COLUMN id SET DEFAULT nextval('public.venta_id_seq'::regclass);
ALTER TABLE ONLY public.detalleventa ALTER COLUMN idlinea SET DEFAULT nextval('public.detalleventa_idlinea_seq'::regclass);


COPY public.clientes (id, nombre, name) FROM stdin;
1	Pablo	\N
7	Juan	\N
8	Alfonso	\N
9	Miguel	\N
10	Roa	\N
\.

COPY public.productos (id, nombre, precio, name) FROM stdin;
1	Jabon	10.00	\N
3	Laptop	15000.00	\N
4	Jabón	12.00	\N
5	Jabón	12.00	\N
\.

COPY public.venta (id, fecha, monto, nombrecliente, idcliente, cliente_id) FROM stdin;
7	2023-10-25	200.00	Pablo	\N	1
8	2023-10-25	200.00	Pablo	\N	1
\.

COPY public.detalleventa (idlinea, precio, descripcion, cantidad, producto_id, venta_id) FROM stdin;
1	100.00	Descripción del producto	2	1	7
2	100.00	no me acuerdo cuál era	2	1	8
\.

-- Configurar las llaves primarias y foráneas después de insertar datos
ALTER TABLE ONLY public.clientes ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.productos ADD CONSTRAINT productos_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.venta ADD CONSTRAINT venta_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.detalleventa ADD CONSTRAINT detalleventa_pkey PRIMARY KEY (idlinea);

ALTER TABLE ONLY public.detalleventa
    ADD CONSTRAINT detalleventa_producto_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id);

ALTER TABLE ONLY public.detalleventa
    ADD CONSTRAINT detalleventa_venta_fkey FOREIGN KEY (venta_id) REFERENCES public.venta(id);

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_idcliente_fkey FOREIGN KEY (idcliente) REFERENCES public.clientes(id);

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fkpittoyb1d8jt76tv8a17wh1ke FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);

-- Configurar los valores de las secuencias
SELECT pg_catalog.setval('public.clientes_id_seq', 10, true);
SELECT pg_catalog.setval('public.productos_id_seq', 5, true);
SELECT pg_catalog.setval('public.venta_id_seq', 8, true);
SELECT pg_catalog.setval('public.detalleventa_idlinea_seq', 2, true);

-- Asignar ownership
ALTER TABLE public.clientes OWNER TO postgres;
ALTER TABLE public.productos OWNER TO postgres;
ALTER TABLE public.venta OWNER TO postgres;
ALTER TABLE public.detalleventa OWNER TO postgres;
ALTER SEQUENCE public.clientes_id_seq OWNER TO postgres;
ALTER SEQUENCE public.productos_id_seq OWNER TO postgres;
ALTER SEQUENCE public.venta_id_seq OWNER TO postgres;
ALTER SEQUENCE public.detalleventa_idlinea_seq OWNER TO postgres;
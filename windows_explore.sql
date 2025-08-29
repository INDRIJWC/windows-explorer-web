--
-- PostgreSQL database dump
--

\restrict GGUlSdKbnLjS4HEdGMceVWUkz6GDAkZi7z5d1uRRxlSiE5lwAoiQT2Db7MolgYI

-- Dumped from database version 14.19 (Homebrew)
-- Dumped by pg_dump version 14.19 (Homebrew)

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

--
-- Name: file_item; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.file_item (
    id bigint NOT NULL,
    folder_id bigint,
    name text NOT NULL,
    size_bytes bigint DEFAULT 0,
    mime_type text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.file_item OWNER TO root;

--
-- Name: file_item_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.file_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_item_id_seq OWNER TO root;

--
-- Name: file_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.file_item_id_seq OWNED BY public.file_item.id;


--
-- Name: folder; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.folder (
    id bigint NOT NULL,
    name text NOT NULL,
    parent_id bigint,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.folder OWNER TO root;

--
-- Name: folder_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.folder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.folder_id_seq OWNER TO root;

--
-- Name: folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.folder_id_seq OWNED BY public.folder.id;


--
-- Name: file_item id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.file_item ALTER COLUMN id SET DEFAULT nextval('public.file_item_id_seq'::regclass);


--
-- Name: folder id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.folder ALTER COLUMN id SET DEFAULT nextval('public.folder_id_seq'::regclass);


--
-- Data for Name: file_item; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.file_item (id, folder_id, name, size_bytes, mime_type, created_at) FROM stdin;
1	1	resume.pdf	23456	application/pdf	2025-08-26 19:34:15.059207+07
2	4	project-spec.docx	54321	application/vnd.openxmlformats-officedocument.wordprocessingml.document	2025-08-26 19:34:15.059207+07
3	7	beach.jpg	123456	image/jpeg	2025-08-26 19:34:15.059207+07
\.


--
-- Data for Name: folder; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.folder (id, name, parent_id, created_at, updated_at) FROM stdin;
1	Documents	\N	2025-08-26 19:33:51.97997+07	2025-08-26 19:33:51.97997+07
2	Pictures	\N	2025-08-26 19:33:51.97997+07	2025-08-26 19:33:51.97997+07
3	Music	\N	2025-08-26 19:33:51.97997+07	2025-08-26 19:33:51.97997+07
4	Work	1	2025-08-26 19:33:59.005468+07	2025-08-26 19:33:59.005468+07
5	Personal	1	2025-08-26 19:33:59.005468+07	2025-08-26 19:33:59.005468+07
6	Vacations	2	2025-08-26 19:34:04.864357+07	2025-08-26 19:34:04.864357+07
7	Family	2	2025-08-26 19:34:04.864357+07	2025-08-26 19:34:04.864357+07
8	2024	6	2025-08-26 19:34:09.729121+07	2025-08-26 19:34:09.729121+07
9	2023	6	2025-08-26 19:34:09.729121+07	2025-08-26 19:34:09.729121+07
\.


--
-- Name: file_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.file_item_id_seq', 3, true);


--
-- Name: folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.folder_id_seq', 9, true);


--
-- Name: file_item file_item_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.file_item
    ADD CONSTRAINT file_item_pkey PRIMARY KEY (id);


--
-- Name: folder folder_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.folder
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);


--
-- Name: idx_file_folder; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_file_folder ON public.file_item USING btree (folder_id);


--
-- Name: idx_folder_parent; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_folder_parent ON public.folder USING btree (parent_id);


--
-- Name: file_item file_item_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.file_item
    ADD CONSTRAINT file_item_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folder(id) ON DELETE CASCADE;


--
-- Name: folder folder_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.folder
    ADD CONSTRAINT folder_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.folder(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict GGUlSdKbnLjS4HEdGMceVWUkz6GDAkZi7z5d1uRRxlSiE5lwAoiQT2Db7MolgYI


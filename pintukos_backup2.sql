--
-- PostgreSQL database dump
--

\restrict l0k4I5pGLG1Kbxb3HtZKEdah3ce56oetEKFhkrmjaJ1HqIRbx0DbvRLdpDRXN6R

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg13+1)
-- Dumped by pg_dump version 18.3

-- Started on 2026-05-22 20:35:04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 219 (class 1259 OID 16389)
-- Name: favorites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.favorites (
    id integer NOT NULL,
    user_id integer,
    kos_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 220 (class 1259 OID 16394)
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 220
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- TOC entry 221 (class 1259 OID 16395)
-- Name: kos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kos (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    location character varying(255) NOT NULL,
    description text,
    facilities text[],
    image_url character varying(255),
    wa_number character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    rating numeric(3,1) DEFAULT 0.0
);


--
-- TOC entry 222 (class 1259 OID 16407)
-- Name: kos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.kos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 222
-- Name: kos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.kos_id_seq OWNED BY public.kos.id;


--
-- TOC entry 223 (class 1259 OID 16408)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 224 (class 1259 OID 16416)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3299 (class 2604 OID 16417)
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 16418)
-- Name: kos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kos ALTER COLUMN id SET DEFAULT nextval('public.kos_id_seq'::regclass);


--
-- TOC entry 3304 (class 2604 OID 16419)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3465 (class 0 OID 16389)
-- Dependencies: 219
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.favorites (id, user_id, kos_id, created_at) FROM stdin;
\.


--
-- TOC entry 3467 (class 0 OID 16395)
-- Dependencies: 221
-- Data for Name: kos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.kos (id, name, location, description, facilities, image_url, wa_number, created_at, rating) FROM stdin;
63	Kost Urban House Setiabudi Bandung	Jl. Dr. Setiabudi No.186E, Hegarmanah, Kec. Cidadap, Kota Bandung, Jawa Barat 40141, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6287708702335	2026-05-20 13:45:28.014256	4.9
64	Graha Setiabudi Bandung Kostan	Jl. Dr. Setiabudi No.80A, RT.03/RW.04, Hegarmanah, Kec. Cidadap, Kota Bandung, Jawa Barat 40141, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6285871880037	2026-05-20 13:45:28.728993	4.9
65	Kost Bale Asri Setiabudi Bandung	Gg. Puradinata Jl. Dr. Setiabudi No.11/174B, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6282190008209	2026-05-20 13:45:29.280355	4.5
66	Kost Rafar Kingdom Setiabudi Bandung	Jl. Budi Luhur I No.:1, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6281283608888	2026-05-20 13:45:29.791484	3.8
67	Kost Wisma Nuri, Bandung	Jl. Cipaku Indah II No.36, RT.01/RW.02, Ledeng, Kec. Cidadap, Kota Bandung, Jawa Barat 40143, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6285155353739	2026-05-20 13:45:30.259159	5.0
68	Kost Modern	Jl. Gegerkalong Tengah No.20, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+62817622868	2026-05-20 13:45:30.735327	4.3
69	Kost Putri Jl Setiabudi 3B Bandung	Jl. Dr. Setiabudi No.3B, Hegarmanah, Kec. Cidadap, Kota Bandung, Jawa Barat 40131, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6281218396009	2026-05-20 13:45:31.24266	5.0
70	Green Kost setiabudhi	Jl. Dr. Setiabudi No.199A, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N		2026-05-20 13:45:31.716571	4.1
71	Kost Pondok Safira dekat UPI Bandung	Jl. Cilimus No.35, Isola, Kec. Sukasari, Kota Bandung, Jawa Barat 40154, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6285759108367	2026-05-20 13:45:32.213963	4.8
72	Kos Melibu Adb	Jl. Gegerkalong Tengah Gg. 8, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N		2026-05-20 13:45:32.746091	4.9
73	Alhuda Kost / Kos / Kosan UPI Bandung	Jl. Cilimus No.20, RT.07/RW.06, Isola, Kec. Sukasari, Kota Bandung, Jawa Barat 40154, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6281322232511	2026-05-20 13:45:33.288809	4.1
74	NT31 Rumah Kost	Jl. Negla Tengah No.31, RT.05/RW.04, Isola, Kec. Sukasari, Kota Bandung, Jawa Barat 40154, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N		2026-05-20 13:45:33.753892	4.8
75	Kost Pa Agus	Jl. Gegerkalong Girang No.47 G 6, RT.6/RW.3, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N		2026-05-20 13:45:34.247737	4.6
76	Kost twins	Jl. Dr. Setiabudi No.199B, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N		2026-05-20 13:45:34.718948	4.4
77	Kosan Ibu Dona	Jl. Dr. Setiabudi No.14/174b, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40141, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6281312297585	2026-05-20 13:45:35.214361	4.8
78	KOST ODOL SETIABUDI	Jl. Dr. Setiabudi No.119B, RT./RW/RW.007/005, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+628129412693	2026-05-20 13:45:35.877186	5.0
79	Kost Ibu Cicih	Jl. Dr. Setiabudi No.35, RT.02/RW.03, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40161, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6282165401901	2026-05-20 13:45:36.378617	4.9
80	KOST PUTRI MADINA HOUSE 2 BANDUNG	Jl. Pak Gatot VI No.206b, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6287817548465	2026-05-20 13:45:36.837246	4.8
81	Jambu House Kost Guest House	Jl. Cipaku Indah II No.Kavling 2, Ledeng, Kec. Cidadap, Kota Bandung, Jawa Barat 40143, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6281808989995	2026-05-20 13:45:37.331401	4.7
82	Kost Polaris	Jalan Negla Hilir No. 2/171A RT. 01/05 Isola Sukasari, Isola, Bandung, Kota Bandung, Jawa Barat 40154, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	{Kasur,Lemari,"Kamar Mandi Dalam",Wi-Fi}	\N	+6281221107007	2026-05-20 13:45:37.816545	4.8
\.


--
-- TOC entry 3469 (class 0 OID 16408)
-- Dependencies: 223
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, email, password_hash, created_at) FROM stdin;
1	tes	test@gmail.com	$2a$10$xB14fuOqmsMOmobrPpBDMuL5XJFW8QL5PTBN9nj73Cr0pkk./7m8O	2026-05-15 19:20:56.473907
2	Reza	Reza	$2a$10$zRy0jyRXPnhgGof4iM/22ejul3d1WRaUrDhPbSDUPzRUuVFC8RIVi	2026-05-16 09:55:09.87685
3	Reza	reza@gmail.com	$2a$10$JNX6fOVtYyPZlk1vCBiR2eoS5NVbZcFeomOWyXjcFyg4iZHS3VxGW	2026-05-16 10:12:03.60611
4	tester	tester@gmail.com	$2a$10$NyF6rUlgDMhUoxUOCJ1mm.GErp4Hq1cChNdk89QZ17HoQOm57B7C2	2026-05-16 10:56:50.110852
5	reza	rezanurjamanr@gmail.com	$2a$10$3RJOw956P6WhDAQodujqE.PqqdCow6bHrIlIL5papoidJfaL2XNLi	2026-05-17 07:06:51.483804
6	Nada	nada@gmail.com	$2a$10$vaGI3/VZjqV8k7vIBPLhlu47np.EsMGLQvp2nx93eqdGrs53rKU.C	2026-05-17 07:09:39.7531
7	Test User	test@example.com	$2a$10$Uzw4aWyX6lKRtBiyakDZB.eats0ptOdWl.Z/w6N7Ych6iVGg2WxSO	2026-05-17 07:50:28.113026
8	umar	umar@gmail.com	$2a$10$Ar72yE5QnuJT.1yz.QMRheXfa8b6jM/lBeF6s1ivEF8GBqiveteHq	2026-05-17 14:06:57.52427
9	putri	putri@gmail.com	$2a$10$W6npR45KOUzt7ZnhGvCNzOJMzatIAyvKSB5mEeayJBO/Hjn53Y4HW	2026-05-17 14:08:55.103285
10	Rafif Aryasatya Afandi	rafifaryasatya777@gmail.com	$2a$10$07ii2jNnFWGaZe8/.hSlyuw7C5bQnPCOJYLb9yMTqyk3Ny9abl.w2	2026-05-17 14:09:48.732262
11	Gina Amallia	amalliag309@gmail.com	$2a$10$AaUbagxn7qLuFSUVUe9EsOLl7kbymN2qZKoRTc013lC0Z3izqNgSS	2026-05-17 14:12:03.747221
12	kiboy	kiboy@gmail.com	$2a$10$I.cUE4YRxJjPdDIzQTOcuOaMkZoBACx26cfxw23PSWynUWqGUV3Wm	2026-05-17 17:08:14.400778
13	darel pratista	darelpratista27@gmail.com	$2a$10$7XXMa/SZQH37HY2Anoep5eDbfdI8dVGrMaKwYNqTsUUHy1HAz7wr6	2026-05-18 07:23:35.413127
14	Hilmi Juyan Pratama	peshilmi20@gmail.com	$2a$10$l3b1E5Al.ycE2ali6opPS.6TcjX3XStzIUqLeTc43GnpVskrVGKqW	2026-05-18 07:37:24.323366
\.


--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 220
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.favorites_id_seq', 8, true);


--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 222
-- Name: kos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.kos_id_seq', 82, true);


--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 14, true);


--
-- TOC entry 3307 (class 2606 OID 16421)
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- TOC entry 3309 (class 2606 OID 16423)
-- Name: favorites favorites_user_id_kos_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_user_id_kos_id_key UNIQUE (user_id, kos_id);


--
-- TOC entry 3311 (class 2606 OID 16425)
-- Name: kos kos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kos
    ADD CONSTRAINT kos_pkey PRIMARY KEY (id);


--
-- TOC entry 3313 (class 2606 OID 16427)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3315 (class 2606 OID 16429)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3316 (class 2606 OID 16430)
-- Name: favorites favorites_kos_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_kos_id_fkey FOREIGN KEY (kos_id) REFERENCES public.kos(id) ON DELETE CASCADE;


--
-- TOC entry 3317 (class 2606 OID 16435)
-- Name: favorites favorites_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2026-05-22 20:35:20

--
-- PostgreSQL database dump complete
--

\unrestrict l0k4I5pGLG1Kbxb3HtZKEdah3ce56oetEKFhkrmjaJ1HqIRbx0DbvRLdpDRXN6R


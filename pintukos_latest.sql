--
-- PostgreSQL database dump
--

\restrict YQaW3e47uzxyQWqHndPueIohV1GrcNfIhXLb5jLGabdWQd5IBase3TRJAdTdvFg

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-06-04 13:08:01

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
-- TOC entry 219 (class 1259 OID 16441)
-- Name: favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorites (
    id integer NOT NULL,
    user_id integer,
    kos_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.favorites OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16446)
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favorites_id_seq OWNER TO postgres;

--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 220
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- TOC entry 221 (class 1259 OID 16447)
-- Name: kos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kos (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    location character varying(255) NOT NULL,
    description text,
    wa_number character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    rating numeric(3,1) DEFAULT 0.0,
    latitude numeric(10,8),
    longitude numeric(11,8),
    image_urls text[] DEFAULT '{}'::text[]
);


ALTER TABLE public.kos OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16458)
-- Name: kos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kos_id_seq OWNER TO postgres;

--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 222
-- Name: kos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kos_id_seq OWNED BY public.kos.id;


--
-- TOC entry 223 (class 1259 OID 16459)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16467)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4866 (class 2604 OID 16468)
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- TOC entry 4868 (class 2604 OID 16469)
-- Name: kos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kos ALTER COLUMN id SET DEFAULT nextval('public.kos_id_seq'::regclass);


--
-- TOC entry 4872 (class 2604 OID 16470)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5033 (class 0 OID 16441)
-- Dependencies: 219
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorites (id, user_id, kos_id, created_at) FROM stdin;
10	6	123	2026-05-26 10:03:52.419091
\.


--
-- TOC entry 5035 (class 0 OID 16447)
-- Dependencies: 221
-- Data for Name: kos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kos (id, name, location, description, wa_number, created_at, rating, latitude, longitude, image_urls) FROM stdin;
123	Graha Setiabudi Bandung Kostan	Jl. Dr. Setiabudi No.80A, RT.03/RW.04, Hegarmanah, Kec. Cidadap, Kota Bandung, Jawa Barat 40141, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6285871880037	2026-05-26 09:18:55.303767	4.9	-6.87930850	107.59831510	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-uP8kcwhPgwJD7Af7BEsZzy_BGuIG3jczpS4JWTYa7WkkogpcDtbtmI5LrNF5octHA--iHXFhIieQAFsKhczJ0TCxyVm7WZrVQl7FXCwMaROGXGRwty_7KuQR6zLIVIA5QzwJXlFTa6A-OmYqzOr4GoCt7dziQsCimm5DEIVTF_PEukrWdh4SWGDjjiDlv8VYufpc2kD_s34c8DPjKaWuRlHpEKtn6uCad0MCKHZ690nj-VszmfuUcz7UsWW5PUItpGP0HYg43xcyPo0eR5nLzn4U3n6UyPDGTWtrcj9kJnVA&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
124	Kost Urban House Setiabudi Bandung	Jl. Dr. Setiabudi No.186E, Hegarmanah, Kec. Cidadap, Kota Bandung, Jawa Barat 40141, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6287708702335	2026-05-26 09:18:55.414816	4.9	-6.87024430	107.59417900	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-tsOUT6ukIXs1dtAmo557sim-LKKGp1wx4_GpDuSoqMFjHoaxK3vZ-dj-E6-oCiDlskcIS33NOJIsBNn5yDH4gsZy71im4Ew3Ox8kA6zrZ97Cuaq-_KF6ywQ3cqUo379eZOtDnOUDXxUQkAgX_QHeenVdYZZZXSjCG_jQaGBSOZXKdPdyy7p5IyjQfjAxfhCjlKLJWr8f4lGUZiQ9nyc8RP4M2JhsGVXmVGkx18TebI1V_dJ-HJMD_fwI32x325rHXX57_Qihl_4XXAJBtli1vPYR9Lhs4oItO-oZ1Kst38F67Ex11CZHF4H3SVxBzyRc1DymLGh40OLXMfIBWwBjj_t32pKmCQS4UH6kji5bNDoQISu6EymN_UfVAKHdMmYJ7FrVwcD7jqVSK7ah-pYn5_0I8fTpT-Iwbn4wU-Jfg5Ks77K05cQ16xA3shtA&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
125	Kost Putri Jl Setiabudi 3B Bandung	Jl. Dr. Setiabudi No.3B, Hegarmanah, Kec. Cidadap, Kota Bandung, Jawa Barat 40131, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6281218396009	2026-05-26 09:18:55.531378	5.0	-6.88455390	107.60405800	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-sw68ZozrIrul4dol93tHvYDS6mtw-1AaEBn1QSuQjpuMGL_dFqbe2-kgi0ndsHLafXuo3tZYIAlDK-7ZN5GUsmFW_kL64KNI8kOtb3Bmh4y-dPb5e2u4Lr45Rn2dLAAU7EMGzC-fmmtfQevPuA3hiSRcAbxpSngeOtyFSjsVIIq554M9Fo0Kg-0CNbflMDcDo3rWVYbzu8eTTiA7Si1ga0UYp9YEWIMjQySVecFpTztN5MEeTvZzC_riqNffVp-6r1DvO6nl_Wqq7n23lLPXsK05w24Scnl9Q44YNJgxvV7A&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
126	Kost Bale Asri Setiabudi Bandung	Gg. Puradinata Jl. Dr. Setiabudi No.11/174B, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6282190008209	2026-05-26 09:18:55.638831	4.5	-6.86789920	107.59311220	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-tu360FVPgGC5eOczfvoBrZXCzehGFso2A6nAJF8RiF5uCfEki5xzHAi5bZMxMqeWBlssuKe8m7oVvFtOhVs7zUNgeNbWeYJ7PCRYKd3PoDMDZIDMEU9nKJo5u0F3ou9MSjzyRk2IouQEI0w_sLuLt_unQLzCGv3BFD3IPRENepm4uE_5kFEbQtPh0jq_qm9QDNb3KiZGVvTBw_RR8VAPt4ne0QZ8RRKHtjOWYxJxcV9LC8ZP3X9t6FX6p9uWsB-6glbm6sgLrBJegW894q2MDk9VwBkm1xfPc5BFG3UQuWXQ&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
127	Kost Rafar Kingdom Setiabudi Bandung	Jl. Budi Luhur I No.:1, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6281283608888	2026-05-26 09:18:55.865049	3.8	-6.87152000	107.59350280	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-vM1Bl6AGcjVZMf5RcGhwNeOlCFxEdqlJsTA9Y5U5vwZITQZ0cFSiD0fIn94dxMx7MiU4S0Q615xD3vLdkBkOs7Y8lgeW0nSv_X0d0Y04EIpbiC31sGMCJ9vkuBNiAxxDq4QDJ6Ib657vHJmPkSjlZ8kyxBXSGOCaj0dCcKcIfxCm1-ctXR1Darmr2bIQ41f7dONnoZ5bLgQHN0tsLvW-vcsqIpnwWJUVLoNX1jRUw9FTaeEN5FQgIDE409A_GMZaSJ8sb3MvVo36XZxwg9PqKmBlwrbNHvLn3mOqLyqsanxA&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
128	Kost Wisma Nuri, Bandung	Jl. Cipaku Indah II No.36, RT.01/RW.02, Ledeng, Kec. Cidadap, Kota Bandung, Jawa Barat 40143, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6285155353739	2026-05-26 09:18:55.957824	5.0	-6.86145230	107.59667810	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-uPk4NcE95wufvwz5cH2BPPSRMtpxFhn_M-yWrmBeVk1bkh6lBHLW-FMybzn8KNxeViAVD3yL6s4o9dvkwqe5rP7TxGnYajvp9bQDaBEp7KkvfaUnxilXq1UvUx_fchSgAulZ3cEltilNmna_nhlLj-bQS5agD4yhfHsRvFQAEAY-LINdyTy5Nx2B9eyOAOD81u1rCF62rt21RfRtB-I42-hSNJdPa8a6335zNKca-_1_PdoNx6uFi1XgM9axBX1kLsPQdYvqYUJRByJSVQMBNq14iC7JAMZSwTnYe2ViGQMw6sFksEY4xD5IGkKkEU2gzvT_bP7jDYmjeocSDsygIROSjAaSVr1YYv-wnEYzArhN83QDNBIx3PstzhbrncM-vWxM8qyiR3Uz_W0yE0Tf04N2DWOnC8vzx6_Cv3NfLIYA&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
129	Kost Modern	Jl. Gegerkalong Tengah No.20, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+62817622868	2026-05-26 09:18:56.010522	4.3	-6.86818820	107.59156380	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-vnv9XbWtHCmRlp3eAjzJi8GQ8ba8sAHPSM2zbnwKcbhU9WPfRZR6qJ10DllPRJq3jHOOqOjk-go-7Gtg49zVzidxcKVYz995nZIPGXxjwT_9sEh9W4XMeVbvpiNJYD_Chd5CWsIyCL9fPHzQfmxdlUDV5b-jUaE7slOsAbNn-XubNjV43w725opO7WcqDv7tbpB59NqEl6r0yA5SL2lwKt2BWFmNuoy4ro3EGtiTxa1PBc2ReiuYnEtQOVobY0QcNXGJ0-bUq4Ka2Z7c-xyGvauP2EmTi-FRCZRHzFnOxJZw&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
130	KOST ODOL SETIABUDI	Jl. Dr. Setiabudi No.119B, RT./RW/RW.007/005, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+628129412693	2026-05-26 09:18:56.098105	5.0	-6.87208060	107.59405480	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-vozrrz7dtsZXNyaAQ3XxuO4VsKJsQyE_N5ivA0s7NLQ1ak3Z_J3Q6cL1Qn2CJPaPirAIYlJnhlKxJCpM-AHnuFBV93eCQe_zSNOCibqZ6cQjkASRRuwFG2ix2IggsavSwNNJDLwqxwUxYq-SQtrde0XMIuA8yNpvDUOOL-XlvjBY9SHJxmK0lygKv2mGSSDPypyjrn6ZAQH58DOlxRshXkVP8o5d_82ofKCowU9hjvKEHTy65nGtSomA6SqMXqHi3aZgy38iWH5LWPfNeHRq9c3mlUmjApiA1S3XQf0u0Z7g&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
131	Kosan Ibu Dona	Jl. Dr. Setiabudi No.14/174b, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40141, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6281312297585	2026-05-26 09:18:56.195396	4.8	-6.86777370	107.59329900	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-uJyG1Vmgsp7hB2Mwr9ihMsM6G-qrOKUxo7EQFF2-JPqJVSY3WhnvIi_ig83V1ExtW2O05niXxxrSzubht5EwsCY59qbYz_brKqiFaddEUvKmQAMFF2-mQCX8ZvAZDPP_ub-fjXlCYPpA1PvAYmj1NCGiYawwo3zVXCQpf4s2xAA-P2EWpVV9IrJKWG-yCF6dxTZ8AXETu2vPicULwe13hwWyb5zfu3LROjlRHcGa6sXRO9UZX1rEgCBsQk6Xu_JjCx9dXmu_Aapb57Kt40jLmeOQUiyJXftlgWOTK109A46y0TU6rOji5LifG-FmyjfYFVnnAbfmGTig4gRbGYNUbZOEdEWdFZALqiXfGtW10OFRI1V3vJIKkJHAhS4FI3GWMiVzdB5lsWMRItSsmeDQgOl3thsyYKwM5KEyp5fR1mxq-W&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
132	Kost twins	Jl. Dr. Setiabudi No.199B, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.		2026-05-26 09:18:56.282727	4.3	-6.86557910	107.59339980	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-t1llMEC_UP4XsPXjqCuGtyKPj3YFjDwzpvLz7NMSRSyGL63zRBsKkidUy23iH6fhKdvxta9hdBnY6kJwzn3uc0Op1cT2i5G_aRb6fHnALWEmhzWl2gEGmVwRrFVy8Nxp5xBWitgCFCp7gNY50UoOjEyfI5Oar8gRatwJjTiaYnaUdS1_bQuFYnWeB8ay7UMbQ_l4mQ3-gUyplB3IcRhNOw3WMCoEaekKAmsVAy1BhHO2zBPopQ2WS_Os3wWYFYQr1PIZ1x7HT5HZxmwVbU2fN8iYUZizgJpAEw28K84g-N_j433YXrl7MnB611_9as_TjkJstEHRF9pkNM4lhjsmhXKMbmrvSn-z0IKmzgPAFGXk0Bqc5TUmklpPncEILjx-xeh0-agXh23V0sma07peYu4MffJPf1DXyPIGB7HR5gHYtw&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
133	Green Kost setiabudhi	Jl. Dr. Setiabudi No.199A, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.		2026-05-26 09:18:56.386236	4.1	-6.86549120	107.59341510	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-uyZ6N7-eBlObqzJ6uXBU_GQ0JkHlMPg4iAilgxha8df3L-Vk8rgkT4hIsbv1Q__5RTWVGR6-BWzGDKyXFfsxvGTPm3mEbMGkmlvNieoPC4K5GPTGQqMBxOwSlPgTzVfHT0sXv6GhLWhuqZE30mPfsjeIlYPNB1fhXyU-mdToST4FJFUJCeX6PTxk-AxA4vgSwIv56WeRNeOg4e8EUx45zEkqDKrxNtpLqFKhILIoECg7H0GhELDPuQ8P06zwrsK6gT8-p0XJhICm6xQZW_NAvPaJUJXpjX3JvXEIjNXopMURjq7cZptggFG4rhh5yY8ymSMRyZPeuleqwKoEbfu0zkYEngmoTh1xDiaJ-RxkyI2bI4YWm7SUI3WvP0MgNxVen1X8KED5gqw6PErKCi0YDaD9IgaxxtV_cEaRyyKqrTle2g&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
134	Kos Melibu Adb	Jl. Gegerkalong Tengah Gg. 8, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.		2026-05-26 09:18:56.487652	4.9	-6.86649710	107.59123670	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-v5Fxh19ENPAL8u8RZ_20KmGzdQv5hFTegwehOqh-TR8SCH3XwnOfXUDrom4C2wCCIl9G-NwSWTPygMugBLA8eGQ-JIFAKiG0L5E4PrpNC02VNDyObn9cpUNf7fyTSMW9Sg0bu2jZDT1yG-d9UynAZHJ_cmWFTULTLhC1cvlDkPUrvw2l1j1K26tKvDvIx_CIpr0oiCgO66ngv3xM14O3boO0t_oEwT1LbkeY1JP7CiJZcaoUnOheqjcKFFVzJk-QEjXT12vavMUe4QmDoUsdBZe1Ku_f5YmOPO0lA4IHmBFg&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
135	Kos-kosan Bapak Basar	Jl. Jurang, Belakang Gg. Mama Pura No.39, RT.03/RW.05, Pasteur, Kec. Sukajadi, Kota Bandung, Jawa Barat 40161, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6289693532378	2026-05-26 09:18:56.608716	4.9	-6.88801510	107.60026890	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-tRHlucm5Vpi0eNsNIOraCCbQFJQBnPWDetjOGljqJZ7f_ev7GBdj4dJztno1a58CuSkpUr0J0-PR7eFfTfLehRO6ho0OLSYYD2mdhPFoqKUPErSMK8z3eVRIRAODNCevwHZMNoMCjttDR0GgRqk2XuR2hsO67C_8p3voKlmgEfvwURI0e39TWYNWmx0gxvicfLCQoefWZh5z_t10G1Hmu8HjGmknGFba4-QL0kLzPZQmz1C4dpVqw4-VoVsudKsvVtivczEVUmKyiMo-ZZfRZV1BRDCQn0eVsd9VJTTvacBA&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
136	Kost Cemara 455	Jl. Cemara No.455/181, RT.02/RW.03, Pasteur, Kec. Sukajadi, Kota Bandung, Jawa Barat 40161, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6281910371955	2026-05-26 09:18:56.786263	4.6	-6.88455740	107.60060870	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-u-lKKmbXy9VTs8KO41V4IP0b8v60RgnMxtWrPVpylCn1jri3EftAR8ylwhlOlGx6Y0YkJWqjT68zAm7-H8xTqUFMAzuKJe6VKtvhvOQ56alJEAVifbDlhPhaAnyYwfDwCtmrV2xHkwFRFYDa1pdRCXubxDn4Uv8WfihJYTEuhAJFxxpzuQZ48dfzRLtVjhlAMe9bHIDhPOew1QeV7cQKN2GkUMJSiySD-XBjbwKphhb3gRSmrzo8a60cW3DsTu-og6rRnc5ahY7RW4AIjj0wRypHe3283Pw3HJ0zFos0XwGQ&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
137	Pondok Indah Kost Bukit Sastra I	Jl. Ciumbuleuit Gg. Bukit Sastra No.139B, Hegarmanah, Kec. Cidadap, Kota Bandung, Jawa Barat 40141, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+62811238674	2026-05-26 09:18:56.846502	4.5	-6.87614300	107.60302860	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-voIM8elIUW4P2eSO_1WQ4moY3zXwjFOvQuuCzXYj-pLtKqxTeTYHaxeFCMycflLkZL2tq_HbIWLeL8wGHUdngnMt-KMWKTRP5F9bmHY3ZN29eZmsx-y9D6yTPjm_Tce2ToztcF4PwwKl1E89vcumhwZgikD9YEzQrTejPwrrGjXMmLqkd3F5IUQVuNdDm9gYfPJ_vZl42mY2GXvzKMU1oHBYEuVGsxxQuqhxrfnvSTCmmGwZg0wZiPv3WMMtrH0VtHcJDoqQCDNzW1c4lOopuEOW8W_AiNxE1bE88THRmkyQ&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
138	Kosan Dahlia 21	Gg. Bp. Aleh No.84 / 155 A, Hegarmanah, Kec. Cidadap, Kota Bandung, Jawa Barat 40141, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6282129990062	2026-05-26 09:18:56.957824	5.0	-6.87984980	107.60419670	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-vLej1Qi1qBnQYsy2cvubqLSD2A23_a9pCHeIWcZJXBcDi9gAAlarBnW9mWNk-oCTI90mkiQ5mm0mH6QNs4jV06DDPpG2J_50yN17gEyo1nxiO4QFXNCeeUIHMoO3r9LajThph60_vrDchFHqQqmLyE2oVGUDU2TmArgcu10BEQnenTWLON9OnKoT9v4Qgn1HCWXPL9peJpbpPVubr5Q7V6pdMgB_buBPSk9lJ5eiB6-SDAAXsGHaOJIULqRxmTVmPtxekZW4coadls-Z_rP5lH1csfCtJFDCnDvxyjidPa8I_2vPyIQan8E7I4w29Fuw6pAoD4FYs1sBdJzdI07YxWyPu2v5EKeUTXNSYIxlAMDFga40iwt8KyWtmJwsipbA8-G11UCIdzY9xpnKHIn9yUiJgn-D36zjn8AwnESGs&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
139	Kost Pondok Safira dekat UPI Bandung	Jl. Cilimus No.35, Isola, Kec. Sukasari, Kota Bandung, Jawa Barat 40154, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6285759108367	2026-05-26 09:18:57.154692	4.8	-6.85785660	107.59066710	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-v2E_AKOYbtbBc_SWehQ7g6VU_SkBq5iRr3sjl7lVZmGVwMuoh8H8nbhxcCFeXWAPbfjqQO7-a13HngDuZoJU1b3DJsXO7L4n19SvjGhazLIyYcEhcuVQqGzyDVX0HYWkZbGfAwY0szQQH2bkQBO7zG_iHn5tmkH38Z35h8Dc0WvzY6qHWKJeyBRPcPAnSilwdSH-8sneXt3cegliOTNJSbTIlXxgJ52R2rYrl56ySdFK4xCkV--P9D6IGGANQdTk0wOgQ28Y19V0EyzR_cCIGaphE3Ugx4g4viJ6ow9EAWLqJxyOfdyQGuBzNvMx8wE2hDLY6VadRTTqMZFZN4o1aFIsg0whyjq-OZ_1dHeJls5Gk5g5U1YA5UrqBc9pxrrYBTtimBoku5MmUqqZxmV0N10o4wiPhxHu9OYO_DhgaPV5Fq&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
140	Alhuda Kost / Kos / Kosan UPI Bandung	Jl. Cilimus No.20, RT.07/RW.06, Isola, Kec. Sukasari, Kota Bandung, Jawa Barat 40154, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6281322232511	2026-05-26 09:18:57.264531	4.1	-6.85860770	107.59107250	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-teropERNz7uBB1TYzwleAnILAkQ1SASdog1t_oU1PLLvdCVLdDYg1jPPXMMV5Z1Vt2CRcjrXh-W3qsIC-EhdzjD3fpeVCG3oGbO618SFiT2hCYnGIDt6bba0ch2Mg8i8EspCpT_M3gu8yG3dVGw2iWZCmYlLTOHSZkDDyiV55P8Y89Ly8nxyUcGqEzrTam7VD5fa4n1aC8hmco9L0puxGkYiWlr5rFMyGvkwH4EXUHD1I6J1hGqSWqV8QFtoXi0RnFLkg3RgcWApJP4cbyNCFJt2dhYcSaKf9XIuw7RZQt3g&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
141	Family Kost Abah	Jl. Dr. Setiabudi No.141b, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40153, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6282216670501	2026-05-26 09:18:57.523257	4.8	-6.87003290	107.59326720	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-tSPmnK-ufU85YKz0r3bOn8Pvaf4BMyh6obQJv8reTSDrL5ax0GOGxOo93PaZ4i-T4_7QlrAfrlqhRVktq1CUPquo7tm33blaws0mf2qdIUBh93VIAySKx2UZGvTONizkF5qH43jdaMwld9YQ-4dvexC4gcicSYBIUe17EGCh6m4gadYiTofGihjpZenpLcRN8JyOKTLFFW47o5HhNRLZWajdqk34BQ4nqSpCjeuhSwwKcANsjJPFXTsiqCTNhtbAu3H7LwfHq4ujedy0m5xodVSxgkhF08wjs6JKa7aPApL9at5aw8QDpWWIFCwZ8hofTynv4G0g8XMP-D3VGIqzsz_Jy-zlKT_bocuGHeFrkDBWxGFlQorHsM9mEsoOwHrWTQN4_vDzykmGTydH4KSw0k5eqVxsMM3Fdu4bYbX0kUxQ&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
142	Kost Ibu Cicih	Jl. Dr. Setiabudi No.35, RT.02/RW.03, Gegerkalong, Kec. Sukasari, Kota Bandung, Jawa Barat 40161, Indonesia	Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.	+6282165401901	2026-05-26 09:18:57.61985	4.9	-6.86515830	107.59331330	{https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=Ab43m-uhNgI-meF7sDsGJq-kIFM9p3e0X9FskTUVqhWPwvS9uaub1CBgwR9NEnlHabgc-tyou-YBc4h9kUM6nDuzK4NPvyPMi7RwXzj7NEOy6a1lc78YMWn0hBXBXhw0Y55P6O-jDuwkDA5KJu0sdSqrvwOTxhoEgRFsN63DtbMHdhWPVNeORU5wrO31prr0LSyUru_79RYqJHARsv_qDZlqXlHsZNeiA6IqKIV6F9wzCrCynwsAn-dD5lK-WOHfPNgtiF2fjpuzdduppiwZKgqzvxzCMfB2dloWYnPQOBdLcTd2-B2R9nC2XOf2mPL8YtJjSAP-aVLiV99X4wR40pqxW4AgLfX020nrP6A8jQl7qQYfQYX9P2CzM-Vh6CXLuEhldeux6q1T0fhS9d3RhCQcTTMuqrzrI-huZoeeByayfwg8CQ&key=AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8}
\.


--
-- TOC entry 5037 (class 0 OID 16459)
-- Dependencies: 223
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password_hash, created_at) FROM stdin;
1	tes	test@gmail.com	$2a$10$xB14fuOqmsMOmobrPpBDMuL5XJFW8QL5PTBN9nj73Cr0pkk./7m8O	2026-05-15 19:20:56.473907
2	Reza	Reza	$2a$10$zRy0jyRXPnhgGof4iM/22ejul3d1WRaUrDhPbSDUPzRUuVFC8RIVi	2026-05-16 09:55:09.87685
3	Reza	reza@gmail.com	$2a$10$JNX6fOVtYyPZlk1vCBiR2eoS5NVbZcFeomOWyXjcFyg4iZHS3VxGW	2026-05-16 10:12:03.60611
4	tester	tester@gmail.com	$2a$10$NyF6rUlgDMhUoxUOCJ1mm.GErp4Hq1cChNdk89QZ17HoQOm57B7C2	2026-05-16 10:56:50.110852
5	reza	rezanurjamanr@gmail.com	$2a$10$3RJOw956P6WhDAQodujqE.PqqdCow6bHrIlIL5papoidJfaL2XNLi	2026-05-17 07:06:51.483804
7	Test User	test@example.com	$2a$10$Uzw4aWyX6lKRtBiyakDZB.eats0ptOdWl.Z/w6N7Ych6iVGg2WxSO	2026-05-17 07:50:28.113026
8	umar	umar@gmail.com	$2a$10$Ar72yE5QnuJT.1yz.QMRheXfa8b6jM/lBeF6s1ivEF8GBqiveteHq	2026-05-17 14:06:57.52427
9	putri	putri@gmail.com	$2a$10$W6npR45KOUzt7ZnhGvCNzOJMzatIAyvKSB5mEeayJBO/Hjn53Y4HW	2026-05-17 14:08:55.103285
10	Rafif Aryasatya Afandi	rafifaryasatya777@gmail.com	$2a$10$07ii2jNnFWGaZe8/.hSlyuw7C5bQnPCOJYLb9yMTqyk3Ny9abl.w2	2026-05-17 14:09:48.732262
11	Gina Amallia	amalliag309@gmail.com	$2a$10$AaUbagxn7qLuFSUVUe9EsOLl7kbymN2qZKoRTc013lC0Z3izqNgSS	2026-05-17 14:12:03.747221
12	kiboy	kiboy@gmail.com	$2a$10$I.cUE4YRxJjPdDIzQTOcuOaMkZoBACx26cfxw23PSWynUWqGUV3Wm	2026-05-17 17:08:14.400778
13	darel pratista	darelpratista27@gmail.com	$2a$10$7XXMa/SZQH37HY2Anoep5eDbfdI8dVGrMaKwYNqTsUUHy1HAz7wr6	2026-05-18 07:23:35.413127
14	Hilmi Juyan Pratama	peshilmi20@gmail.com	$2a$10$l3b1E5Al.ycE2ali6opPS.6TcjX3XStzIUqLeTc43GnpVskrVGKqW	2026-05-18 07:37:24.323366
6	Nada	nada@gmail.com	$2a$10$baELxHyW7CXAuarxQbEfyOqQWZsHVSOrc5.ObNPCqudnZRduhNyMW	2026-05-17 07:09:39.7531
\.


--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 220
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favorites_id_seq', 10, true);


--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 222
-- Name: kos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kos_id_seq', 142, true);


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 14, true);


--
-- TOC entry 4875 (class 2606 OID 16472)
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- TOC entry 4877 (class 2606 OID 16474)
-- Name: favorites favorites_user_id_kos_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_user_id_kos_id_key UNIQUE (user_id, kos_id);


--
-- TOC entry 4879 (class 2606 OID 16476)
-- Name: kos kos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kos
    ADD CONSTRAINT kos_pkey PRIMARY KEY (id);


--
-- TOC entry 4881 (class 2606 OID 16478)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4883 (class 2606 OID 16480)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4884 (class 2606 OID 16481)
-- Name: favorites favorites_kos_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_kos_id_fkey FOREIGN KEY (kos_id) REFERENCES public.kos(id) ON DELETE CASCADE;


--
-- TOC entry 4885 (class 2606 OID 16486)
-- Name: favorites favorites_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2026-06-04 13:08:01

--
-- PostgreSQL database dump complete
--

\unrestrict YQaW3e47uzxyQWqHndPueIohV1GrcNfIhXLb5jLGabdWQd5IBase3TRJAdTdvFg


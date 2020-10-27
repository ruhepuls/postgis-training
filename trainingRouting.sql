--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-1.pgdg18.04+1)
-- Dumped by pg_dump version 12.4 (Ubuntu 12.4-1.pgdg18.04+1)

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

--
-- Name: routing; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA routing;


ALTER SCHEMA routing OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: combinations_table; Type: TABLE; Schema: routing; Owner: postgres
--

CREATE TABLE routing.combinations_table (
    source bigint,
    target bigint
);


ALTER TABLE routing.combinations_table OWNER TO postgres;

--
-- Name: customer; Type: TABLE; Schema: routing; Owner: postgres
--

CREATE TABLE routing.customer (
    id bigint NOT NULL,
    x double precision,
    y double precision,
    demand integer,
    opentime integer,
    closetime integer,
    servicetime integer,
    pindex bigint,
    dindex bigint
);


ALTER TABLE routing.customer OWNER TO postgres;

--
-- Name: edge_table; Type: TABLE; Schema: routing; Owner: postgres
--

CREATE TABLE routing.edge_table (
    id bigint NOT NULL,
    dir character varying,
    source bigint,
    target bigint,
    cost double precision,
    reverse_cost double precision,
    capacity bigint,
    reverse_capacity bigint,
    category_id integer,
    reverse_category_id integer,
    x1 double precision,
    y1 double precision,
    x2 double precision,
    y2 double precision,
    the_geom public.geometry(LineString)
);


ALTER TABLE routing.edge_table OWNER TO postgres;

--
-- Name: edge_table_id_seq; Type: SEQUENCE; Schema: routing; Owner: postgres
--

CREATE SEQUENCE routing.edge_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE routing.edge_table_id_seq OWNER TO postgres;

--
-- Name: edge_table_id_seq; Type: SEQUENCE OWNED BY; Schema: routing; Owner: postgres
--

ALTER SEQUENCE routing.edge_table_id_seq OWNED BY routing.edge_table.id;


--
-- Name: edge_table_vertices_pgr; Type: TABLE; Schema: routing; Owner: postgres
--

CREATE TABLE routing.edge_table_vertices_pgr (
    id bigint NOT NULL,
    cnt integer,
    chk integer,
    ein integer,
    eout integer,
    the_geom public.geometry(Point)
);


ALTER TABLE routing.edge_table_vertices_pgr OWNER TO postgres;

--
-- Name: edge_table_vertices_pgr_id_seq; Type: SEQUENCE; Schema: routing; Owner: postgres
--

CREATE SEQUENCE routing.edge_table_vertices_pgr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE routing.edge_table_vertices_pgr_id_seq OWNER TO postgres;

--
-- Name: edge_table_vertices_pgr_id_seq; Type: SEQUENCE OWNED BY; Schema: routing; Owner: postgres
--

ALTER SEQUENCE routing.edge_table_vertices_pgr_id_seq OWNED BY routing.edge_table_vertices_pgr.id;


--
-- Name: new_restrictions; Type: TABLE; Schema: routing; Owner: postgres
--

CREATE TABLE routing.new_restrictions (
    id integer NOT NULL,
    path bigint[],
    cost double precision
);


ALTER TABLE routing.new_restrictions OWNER TO postgres;

--
-- Name: new_restrictions_id_seq; Type: SEQUENCE; Schema: routing; Owner: postgres
--

CREATE SEQUENCE routing.new_restrictions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE routing.new_restrictions_id_seq OWNER TO postgres;

--
-- Name: new_restrictions_id_seq; Type: SEQUENCE OWNED BY; Schema: routing; Owner: postgres
--

ALTER SEQUENCE routing.new_restrictions_id_seq OWNED BY routing.new_restrictions.id;


--
-- Name: pointsofinterest; Type: TABLE; Schema: routing; Owner: postgres
--

CREATE TABLE routing.pointsofinterest (
    pid bigint NOT NULL,
    x double precision,
    y double precision,
    edge_id bigint,
    side character(1),
    fraction double precision,
    the_geom public.geometry(Point),
    newpoint public.geometry(Point)
);


ALTER TABLE routing.pointsofinterest OWNER TO postgres;

--
-- Name: pointsofinterest_pid_seq; Type: SEQUENCE; Schema: routing; Owner: postgres
--

CREATE SEQUENCE routing.pointsofinterest_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE routing.pointsofinterest_pid_seq OWNER TO postgres;

--
-- Name: pointsofinterest_pid_seq; Type: SEQUENCE OWNED BY; Schema: routing; Owner: postgres
--

ALTER SEQUENCE routing.pointsofinterest_pid_seq OWNED BY routing.pointsofinterest.pid;


--
-- Name: restrictions; Type: TABLE; Schema: routing; Owner: postgres
--

CREATE TABLE routing.restrictions (
    rid bigint NOT NULL,
    to_cost double precision,
    target_id bigint,
    from_edge bigint,
    via_path text
);


ALTER TABLE routing.restrictions OWNER TO postgres;

--
-- Name: edge_table id; Type: DEFAULT; Schema: routing; Owner: postgres
--

ALTER TABLE ONLY routing.edge_table ALTER COLUMN id SET DEFAULT nextval('routing.edge_table_id_seq'::regclass);


--
-- Name: edge_table_vertices_pgr id; Type: DEFAULT; Schema: routing; Owner: postgres
--

ALTER TABLE ONLY routing.edge_table_vertices_pgr ALTER COLUMN id SET DEFAULT nextval('routing.edge_table_vertices_pgr_id_seq'::regclass);


--
-- Name: new_restrictions id; Type: DEFAULT; Schema: routing; Owner: postgres
--

ALTER TABLE ONLY routing.new_restrictions ALTER COLUMN id SET DEFAULT nextval('routing.new_restrictions_id_seq'::regclass);


--
-- Name: pointsofinterest pid; Type: DEFAULT; Schema: routing; Owner: postgres
--

ALTER TABLE ONLY routing.pointsofinterest ALTER COLUMN pid SET DEFAULT nextval('routing.pointsofinterest_pid_seq'::regclass);


--
-- Data for Name: combinations_table; Type: TABLE DATA; Schema: routing; Owner: postgres
--

COPY routing.combinations_table (source, target) FROM stdin;
1	2
1	4
2	1
2	4
2	17
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: routing; Owner: postgres
--

COPY routing.customer (id, x, y, demand, opentime, closetime, servicetime, pindex, dindex) FROM stdin;
0	40	50	0	0	1236	0	0	0
1	45	68	-10	912	967	90	11	0
2	45	70	-20	825	870	90	6	0
3	42	66	10	65	146	90	0	75
4	42	68	-10	727	782	90	9	0
5	42	65	10	15	67	90	0	7
6	40	69	20	621	702	90	0	2
7	40	66	-10	170	225	90	5	0
8	38	68	20	255	324	90	0	10
9	38	70	10	534	605	90	0	4
10	35	66	-20	357	410	90	8	0
11	35	69	10	448	505	90	0	1
12	25	85	-20	652	721	90	18	0
13	22	75	30	30	92	90	0	17
14	22	85	-40	567	620	90	16	0
15	20	80	-10	384	429	90	19	0
16	20	85	40	475	528	90	0	14
17	18	75	-30	99	148	90	13	0
18	15	75	20	179	254	90	0	12
19	15	80	10	278	345	90	0	15
20	30	50	10	10	73	90	0	24
21	30	52	-10	914	965	90	30	0
22	28	52	-20	812	883	90	28	0
23	28	55	10	732	777	0	0	103
24	25	50	-10	65	144	90	20	0
25	25	52	40	169	224	90	0	27
26	25	55	-10	622	701	90	29	0
27	23	52	-40	261	316	90	25	0
28	23	55	20	546	593	90	0	22
29	20	50	10	358	405	90	0	26
30	20	55	10	449	504	90	0	21
31	10	35	-30	200	237	90	32	0
32	10	40	30	31	100	90	0	31
33	8	40	40	87	158	90	0	37
34	8	45	-30	751	816	90	38	0
35	5	35	10	283	344	90	0	39
36	5	45	10	665	716	0	0	105
37	2	40	-40	383	434	90	33	0
38	0	40	30	479	522	90	0	34
39	0	45	-10	567	624	90	35	0
40	35	30	-20	264	321	90	42	0
41	35	32	-10	166	235	90	43	0
42	33	32	20	68	149	90	0	40
43	33	35	10	16	80	90	0	41
44	32	30	10	359	412	90	0	46
45	30	30	10	541	600	90	0	48
46	30	32	-10	448	509	90	44	0
47	30	35	-10	1054	1127	90	49	0
48	28	30	-10	632	693	90	45	0
49	28	35	10	1001	1066	90	0	47
50	26	32	10	815	880	90	0	52
51	25	30	10	725	786	0	0	101
52	25	35	-10	912	969	90	50	0
53	44	5	20	286	347	90	0	58
54	42	10	40	186	257	90	0	60
55	42	15	-40	95	158	90	57	0
56	40	5	30	385	436	90	0	59
57	40	15	40	35	87	90	0	55
58	38	5	-20	471	534	90	53	0
59	38	15	-30	651	740	90	56	0
60	35	5	-40	562	629	90	54	0
61	50	30	-10	531	610	90	67	0
62	50	35	20	262	317	90	0	68
63	50	40	50	171	218	90	0	74
64	48	30	10	632	693	0	0	102
65	48	40	10	76	129	90	0	72
66	47	35	10	826	875	90	0	69
67	47	40	10	12	77	90	0	61
68	45	30	-20	734	777	90	62	0
69	45	35	-10	916	969	90	66	0
70	95	30	-30	387	456	90	81	0
71	95	35	20	293	360	90	0	77
72	53	30	-10	450	505	90	65	0
73	92	30	-10	478	551	90	76	0
74	53	35	-50	353	412	90	63	0
75	45	65	-10	997	1068	90	3	0
76	90	35	10	203	260	90	0	73
77	88	30	-20	574	643	90	71	0
78	88	35	20	109	170	0	0	104
79	87	30	10	668	731	90	0	80
80	85	25	-10	769	820	90	79	0
81	85	35	30	47	124	90	0	70
82	75	55	20	369	420	90	0	85
83	72	55	-20	265	338	90	87	0
84	70	58	20	458	523	90	0	89
85	68	60	-20	555	612	90	82	0
86	66	55	10	173	238	90	0	91
87	65	55	20	85	144	90	0	83
88	65	60	-10	645	708	90	90	0
89	63	58	-20	737	802	90	84	0
90	60	55	10	20	84	90	0	88
91	60	60	-10	836	889	90	86	0
92	67	85	20	368	441	90	0	93
93	65	85	-20	475	518	90	92	0
94	65	82	-10	285	336	90	96	0
95	62	80	-20	196	239	90	98	0
96	60	80	10	95	156	90	0	94
97	60	85	30	561	622	0	0	106
98	58	75	20	30	84	90	0	95
99	55	80	-20	743	820	90	100	0
100	55	85	20	647	726	90	0	99
101	25	30	-10	725	786	90	51	0
102	48	30	-10	632	693	90	64	0
103	28	55	-10	732	777	90	23	0
104	88	35	-20	109	170	90	78	0
105	5	45	-10	665	716	90	36	0
106	60	85	-30	561	622	90	97	0
\.


--
-- Data for Name: edge_table; Type: TABLE DATA; Schema: routing; Owner: postgres
--

COPY routing.edge_table (id, dir, source, target, cost, reverse_cost, capacity, reverse_capacity, category_id, reverse_category_id, x1, y1, x2, y2, the_geom) FROM stdin;
1	B	1	2	1	1	80	130	3	1	2	0	2	1	010200000002000000000000000000004000000000000000000000000000000040000000000000F03F
2	TF	2	3	-1	1	-1	100	3	2	2	1	3	1	0102000000020000000000000000000040000000000000F03F0000000000000840000000000000F03F
3	TF	3	4	-1	1	-1	130	2	1	3	1	4	1	0102000000020000000000000000000840000000000000F03F0000000000001040000000000000F03F
4	B	2	5	1	1	100	50	2	4	2	1	2	2	0102000000020000000000000000000040000000000000F03F00000000000000400000000000000040
5	FT	3	6	1	-1	130	-1	1	4	3	1	3	2	0102000000020000000000000000000840000000000000F03F00000000000008400000000000000040
6	B	7	8	1	1	50	100	4	2	0	2	1	2	01020000000200000000000000000000000000000000000040000000000000F03F0000000000000040
7	B	8	5	1	1	50	130	4	1	1	2	2	2	010200000002000000000000000000F03F000000000000004000000000000000400000000000000040
8	B	5	6	1	1	100	130	2	1	2	2	3	2	0102000000020000000000000000000040000000000000004000000000000008400000000000000040
9	B	6	9	1	1	130	80	1	3	3	2	4	2	0102000000020000000000000000000840000000000000004000000000000010400000000000000040
10	B	5	10	1	1	130	50	1	4	2	2	2	3	0102000000020000000000000000000040000000000000004000000000000000400000000000000840
11	FT	6	11	1	-1	130	-1	1	2	3	2	3	3	0102000000020000000000000000000840000000000000004000000000000008400000000000000840
12	FT	10	11	1	-1	100	-1	2	3	2	3	3	3	0102000000020000000000000000000040000000000000084000000000000008400000000000000840
13	FT	11	12	1	-1	100	-1	2	4	3	3	4	3	0102000000020000000000000000000840000000000000084000000000000010400000000000000840
14	B	10	13	1	1	80	130	3	1	2	3	2	4	0102000000020000000000000000000040000000000000084000000000000000400000000000001040
15	B	9	12	1	1	80	50	3	4	4	2	4	3	0102000000020000000000000000001040000000000000004000000000000010400000000000000840
16	B	4	9	1	1	80	80	3	3	4	1	4	2	0102000000020000000000000000001040000000000000F03F00000000000010400000000000000040
17	B	14	15	1	1	130	100	1	2	0.5	3.5	1.999999999999	3.5	010200000002000000000000000000E03F0000000000000C4068EEFFFFFFFFFF3F0000000000000C40
18	B	16	17	1	1	50	130	4	1	3.5	2.3	3.5	4	0102000000020000000000000000000C4066666666666602400000000000000C400000000000001040
\.


--
-- Data for Name: edge_table_vertices_pgr; Type: TABLE DATA; Schema: routing; Owner: postgres
--

COPY routing.edge_table_vertices_pgr (id, cnt, chk, ein, eout, the_geom) FROM stdin;
1	1	0	\N	\N	010100000000000000000000400000000000000000
2	3	0	\N	\N	01010000000000000000000040000000000000F03F
3	3	0	\N	\N	01010000000000000000000840000000000000F03F
4	2	0	\N	\N	01010000000000000000001040000000000000F03F
5	4	0	\N	\N	010100000000000000000000400000000000000040
6	4	0	\N	\N	010100000000000000000008400000000000000040
7	1	0	\N	\N	010100000000000000000000000000000000000040
8	2	0	\N	\N	0101000000000000000000F03F0000000000000040
9	3	0	\N	\N	010100000000000000000010400000000000000040
10	3	0	\N	\N	010100000000000000000000400000000000000840
11	3	0	\N	\N	010100000000000000000008400000000000000840
12	2	0	\N	\N	010100000000000000000010400000000000000840
13	1	0	\N	\N	010100000000000000000000400000000000001040
14	1	0	\N	\N	0101000000000000000000E03F0000000000000C40
16	1	0	\N	\N	01010000000000000000000C406666666666660240
17	1	0	\N	\N	01010000000000000000000C400000000000001040
15	1	1	\N	\N	010100000068EEFFFFFFFFFF3F0000000000000C40
\.


--
-- Data for Name: new_restrictions; Type: TABLE DATA; Schema: routing; Owner: postgres
--

COPY routing.new_restrictions (id, path, cost) FROM stdin;
1	{4,7}	100
2	{8,11}	100
3	{4,8}	100
4	{5,9}	100
5	{10,12}	100
6	{9,15}	100
7	{3,5,8}	100
\.


--
-- Data for Name: pointsofinterest; Type: TABLE DATA; Schema: routing; Owner: postgres
--

COPY routing.pointsofinterest (pid, x, y, edge_id, side, fraction, the_geom, newpoint) FROM stdin;
1	1.8	0.4	1	l	0.4	0101000000CDCCCCCCCCCCFC3F9A9999999999D93F	010100000000000000000000409A9999999999D93F
2	4.2	2.4	15	r	0.4	0101000000CDCCCCCCCCCC10403333333333330340	010100000000000000000010403333333333330340
3	2.6	3.2	12	l	0.6	0101000000CDCCCCCCCCCC04409A99999999990940	0101000000CDCCCCCCCCCC04400000000000000840
4	0.3	1.8	6	r	0.3	0101000000333333333333D33FCDCCCCCCCCCCFC3F	0101000000333333333333D33F0000000000000040
5	2.9	1.8	5	l	0.8	01010000003333333333330740CDCCCCCCCCCCFC3F	01010000000000000000000840CDCCCCCCCCCCFC3F
6	2.2	1.7	4	b	0.7	01010000009A99999999990140333333333333FB3F	01010000000000000000000040333333333333FB3F
\.


--
-- Data for Name: restrictions; Type: TABLE DATA; Schema: routing; Owner: postgres
--

COPY routing.restrictions (rid, to_cost, target_id, from_edge, via_path) FROM stdin;
1	100	7	4	\N
1	100	11	8	\N
1	100	10	7	\N
2	4	8	3	5
3	100	9	16	\N
\.


--
-- Name: edge_table_id_seq; Type: SEQUENCE SET; Schema: routing; Owner: postgres
--

SELECT pg_catalog.setval('routing.edge_table_id_seq', 18, true);


--
-- Name: edge_table_vertices_pgr_id_seq; Type: SEQUENCE SET; Schema: routing; Owner: postgres
--

SELECT pg_catalog.setval('routing.edge_table_vertices_pgr_id_seq', 17, true);


--
-- Name: new_restrictions_id_seq; Type: SEQUENCE SET; Schema: routing; Owner: postgres
--

SELECT pg_catalog.setval('routing.new_restrictions_id_seq', 7, true);


--
-- Name: pointsofinterest_pid_seq; Type: SEQUENCE SET; Schema: routing; Owner: postgres
--

SELECT pg_catalog.setval('routing.pointsofinterest_pid_seq', 6, true);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: routing; Owner: postgres
--

ALTER TABLE ONLY routing.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: edge_table_vertices_pgr edge_table_vertices_pgr_pkey; Type: CONSTRAINT; Schema: routing; Owner: postgres
--

ALTER TABLE ONLY routing.edge_table_vertices_pgr
    ADD CONSTRAINT edge_table_vertices_pgr_pkey PRIMARY KEY (id);


--
-- Name: new_restrictions new_restrictions_pkey; Type: CONSTRAINT; Schema: routing; Owner: postgres
--

ALTER TABLE ONLY routing.new_restrictions
    ADD CONSTRAINT new_restrictions_pkey PRIMARY KEY (id);


--
-- Name: edge_table_id_idx; Type: INDEX; Schema: routing; Owner: postgres
--

CREATE INDEX edge_table_id_idx ON routing.edge_table USING btree (id);


--
-- Name: edge_table_source_idx; Type: INDEX; Schema: routing; Owner: postgres
--

CREATE INDEX edge_table_source_idx ON routing.edge_table USING btree (source);


--
-- Name: edge_table_target_idx; Type: INDEX; Schema: routing; Owner: postgres
--

CREATE INDEX edge_table_target_idx ON routing.edge_table USING btree (target);


--
-- Name: edge_table_the_geom_idx; Type: INDEX; Schema: routing; Owner: postgres
--

CREATE INDEX edge_table_the_geom_idx ON routing.edge_table USING gist (the_geom);


--
-- Name: edge_table_vertices_pgr_the_geom_idx; Type: INDEX; Schema: routing; Owner: postgres
--

CREATE INDEX edge_table_vertices_pgr_the_geom_idx ON routing.edge_table_vertices_pgr USING gist (the_geom);


--
-- PostgreSQL database dump complete
--


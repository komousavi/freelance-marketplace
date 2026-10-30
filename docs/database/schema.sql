--
-- PostgreSQL database dump
--

\restrict J7GWGz2AqdwQNtAQLvYj3DLCjJehg9KXahEX2bg8nrXsMAeecfW2bxjk6WAYaUr

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-31 01:09:59

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
-- TOC entry 241 (class 1259 OID 16632)
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    admin_id integer NOT NULL,
    user_id integer NOT NULL,
    granted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16631)
-- Name: admins_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_admin_id_seq OWNER TO postgres;

--
-- TOC entry 5201 (class 0 OID 0)
-- Dependencies: 240
-- Name: admins_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_admin_id_seq OWNED BY public.admins.admin_id;


--
-- TOC entry 238 (class 1259 OID 16604)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16603)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO postgres;

--
-- TOC entry 5202 (class 0 OID 0)
-- Dependencies: 237
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 224 (class 1259 OID 16428)
-- Name: client_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_profile (
    client_id integer NOT NULL,
    user_id integer NOT NULL,
    company_name character varying(100),
    description text
);


ALTER TABLE public.client_profile OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16427)
-- Name: client_profile_client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_profile_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_profile_client_id_seq OWNER TO postgres;

--
-- TOC entry 5203 (class 0 OID 0)
-- Dependencies: 223
-- Name: client_profile_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_profile_client_id_seq OWNED BY public.client_profile.client_id;


--
-- TOC entry 234 (class 1259 OID 16547)
-- Name: contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contracts (
    contract_id integer NOT NULL,
    project_id integer NOT NULL,
    proposal_id integer NOT NULL,
    price numeric(12,2) NOT NULL,
    start_date date NOT NULL,
    end_date date,
    status character varying(20) NOT NULL,
    contract_terms text,
    description text,
    client_signed_at timestamp without time zone,
    freelancer_signed_at timestamp without time zone,
    CONSTRAINT check_contract_price CHECK ((price > (0)::numeric)),
    CONSTRAINT contracts_status_check CHECK (((status)::text = ANY ((ARRAY['Active'::character varying, 'Completed'::character varying, 'Cancelled'::character varying])::text[])))
);


ALTER TABLE public.contracts OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16546)
-- Name: contracts_contract_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contracts_contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contracts_contract_id_seq OWNER TO postgres;

--
-- TOC entry 5204 (class 0 OID 0)
-- Dependencies: 233
-- Name: contracts_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contracts_contract_id_seq OWNED BY public.contracts.contract_id;


--
-- TOC entry 222 (class 1259 OID 16411)
-- Name: freelancer_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.freelancer_profile (
    freelancer_id integer NOT NULL,
    user_id integer NOT NULL,
    certificates text,
    bio text,
    location character varying(100),
    education text,
    headline character varying(200)
);


ALTER TABLE public.freelancer_profile OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16410)
-- Name: freelancer_profile_freelancer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.freelancer_profile_freelancer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.freelancer_profile_freelancer_id_seq OWNER TO postgres;

--
-- TOC entry 5205 (class 0 OID 0)
-- Dependencies: 221
-- Name: freelancer_profile_freelancer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.freelancer_profile_freelancer_id_seq OWNED BY public.freelancer_profile.freelancer_id;


--
-- TOC entry 227 (class 1259 OID 16458)
-- Name: freelancer_skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.freelancer_skill (
    freelancer_id integer NOT NULL,
    skill_id integer NOT NULL,
    proficiency_level character varying(20) NOT NULL,
    CONSTRAINT freelancer_skill_proficiency_level_check CHECK (((proficiency_level)::text = ANY ((ARRAY['Beginner'::character varying, 'Intermediate'::character varying, 'Advanced'::character varying])::text[])))
);


ALTER TABLE public.freelancer_skill OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16577)
-- Name: portfolio_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portfolio_item (
    portfolio_id integer NOT NULL,
    freelancer_id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    project_url text,
    image_url text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.portfolio_item OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16576)
-- Name: portfolio_item_portfolio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.portfolio_item_portfolio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.portfolio_item_portfolio_id_seq OWNER TO postgres;

--
-- TOC entry 5206 (class 0 OID 0)
-- Dependencies: 235
-- Name: portfolio_item_portfolio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.portfolio_item_portfolio_id_seq OWNED BY public.portfolio_item.portfolio_id;


--
-- TOC entry 239 (class 1259 OID 16614)
-- Name: project_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_categories (
    project_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.project_categories OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16504)
-- Name: project_skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_skill (
    project_id integer NOT NULL,
    skill_id integer NOT NULL
);


ALTER TABLE public.project_skill OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16478)
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    project_id integer NOT NULL,
    client_id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text NOT NULL,
    budget_min numeric(12,2),
    budget_max numeric(12,2),
    status character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deadline date,
    pricing_type character varying(20) NOT NULL,
    CONSTRAINT check_budget_max CHECK (((budget_max IS NULL) OR (budget_max > (0)::numeric))),
    CONSTRAINT check_budget_min CHECK (((budget_min IS NULL) OR (budget_min > (0)::numeric))),
    CONSTRAINT projects_check CHECK (((budget_min IS NULL) OR (budget_max IS NULL) OR (budget_min <= budget_max))),
    CONSTRAINT projects_pricing_type_check CHECK (((pricing_type)::text = ANY ((ARRAY['Fixed'::character varying, 'Hourly'::character varying])::text[]))),
    CONSTRAINT projects_status_check CHECK (((status)::text = ANY ((ARRAY['Draft'::character varying, 'Open'::character varying, 'In Progress'::character varying, 'Completed'::character varying, 'Cancelled'::character varying])::text[])))
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16477)
-- Name: projects_project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_project_id_seq OWNER TO postgres;

--
-- TOC entry 5207 (class 0 OID 0)
-- Dependencies: 228
-- Name: projects_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_project_id_seq OWNED BY public.projects.project_id;


--
-- TOC entry 232 (class 1259 OID 16522)
-- Name: proposals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proposals (
    proposal_id integer NOT NULL,
    project_id integer NOT NULL,
    freelancer_id integer NOT NULL,
    cover_letter text,
    proposed_price numeric(12,2),
    proposed_hourly_price numeric(12,2),
    status character varying(20) NOT NULL,
    estimated_days integer,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT check_estimated_days CHECK (((estimated_days IS NULL) OR (estimated_days > 0))),
    CONSTRAINT check_proposed_hourly_price CHECK (((proposed_hourly_price IS NULL) OR (proposed_hourly_price > (0)::numeric))),
    CONSTRAINT check_proposed_price CHECK (((proposed_price IS NULL) OR (proposed_price > (0)::numeric))),
    CONSTRAINT proposals_status_check CHECK (((status)::text = ANY ((ARRAY['Pending'::character varying, 'Accepted'::character varying, 'Rejected'::character varying, 'Withdrawn'::character varying])::text[])))
);


ALTER TABLE public.proposals OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16521)
-- Name: proposals_proposal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proposals_proposal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proposals_proposal_id_seq OWNER TO postgres;

--
-- TOC entry 5208 (class 0 OID 0)
-- Dependencies: 231
-- Name: proposals_proposal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proposals_proposal_id_seq OWNED BY public.proposals.proposal_id;


--
-- TOC entry 243 (class 1259 OID 16687)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying(30) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16686)
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_role_id_seq OWNER TO postgres;

--
-- TOC entry 5209 (class 0 OID 0)
-- Dependencies: 242
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- TOC entry 226 (class 1259 OID 16448)
-- Name: skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skills (
    skill_id integer NOT NULL,
    skill_name character varying(100) NOT NULL
);


ALTER TABLE public.skills OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16447)
-- Name: skills_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.skills_skill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skills_skill_id_seq OWNER TO postgres;

--
-- TOC entry 5210 (class 0 OID 0)
-- Dependencies: 225
-- Name: skills_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skills_skill_id_seq OWNED BY public.skills.skill_id;


--
-- TOC entry 244 (class 1259 OID 16697)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16390)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    phonenumber character varying(20),
    password_hash character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    account_status character varying(20) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    last_updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_account_status CHECK (((account_status)::text = ANY ((ARRAY['Active'::character varying, 'Inactive'::character varying, 'Blocked'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16389)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 5211 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4937 (class 2604 OID 16635)
-- Name: admins admin_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN admin_id SET DEFAULT nextval('public.admins_admin_id_seq'::regclass);


--
-- TOC entry 4936 (class 2604 OID 16607)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 4926 (class 2604 OID 16431)
-- Name: client_profile client_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_profile ALTER COLUMN client_id SET DEFAULT nextval('public.client_profile_client_id_seq'::regclass);


--
-- TOC entry 4933 (class 2604 OID 16550)
-- Name: contracts contract_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts ALTER COLUMN contract_id SET DEFAULT nextval('public.contracts_contract_id_seq'::regclass);


--
-- TOC entry 4925 (class 2604 OID 16414)
-- Name: freelancer_profile freelancer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelancer_profile ALTER COLUMN freelancer_id SET DEFAULT nextval('public.freelancer_profile_freelancer_id_seq'::regclass);


--
-- TOC entry 4934 (class 2604 OID 16580)
-- Name: portfolio_item portfolio_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio_item ALTER COLUMN portfolio_id SET DEFAULT nextval('public.portfolio_item_portfolio_id_seq'::regclass);


--
-- TOC entry 4928 (class 2604 OID 16481)
-- Name: projects project_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN project_id SET DEFAULT nextval('public.projects_project_id_seq'::regclass);


--
-- TOC entry 4931 (class 2604 OID 16525)
-- Name: proposals proposal_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proposals ALTER COLUMN proposal_id SET DEFAULT nextval('public.proposals_proposal_id_seq'::regclass);


--
-- TOC entry 4939 (class 2604 OID 16690)
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- TOC entry 4927 (class 2604 OID 16451)
-- Name: skills skill_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills ALTER COLUMN skill_id SET DEFAULT nextval('public.skills_skill_id_seq'::regclass);


--
-- TOC entry 4922 (class 2604 OID 16393)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 5192 (class 0 OID 16632)
-- Dependencies: 241
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admins (admin_id, user_id, granted_at) FROM stdin;
1	1	2026-10-30 20:18:13.56546
\.


--
-- TOC entry 5189 (class 0 OID 16604)
-- Dependencies: 238
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, category_name) FROM stdin;
1	Web Development
2	Mobile Development
3	Graphic Design
\.


--
-- TOC entry 5175 (class 0 OID 16428)
-- Dependencies: 224
-- Data for Name: client_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_profile (client_id, user_id, company_name, description) FROM stdin;
1	2	Sara Company	Software project employer
\.


--
-- TOC entry 5185 (class 0 OID 16547)
-- Dependencies: 234
-- Data for Name: contracts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contracts (contract_id, project_id, proposal_id, price, start_date, end_date, status, contract_terms, description, client_signed_at, freelancer_signed_at) FROM stdin;
1	1	1	800.00	2026-10-30	2026-11-29	Active	Website design contract	\N	\N	\N
\.


--
-- TOC entry 5173 (class 0 OID 16411)
-- Dependencies: 222
-- Data for Name: freelancer_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.freelancer_profile (freelancer_id, user_id, certificates, bio, location, education, headline) FROM stdin;
1	3	\N	Experienced developer	Tehran	Computer Engineering	Web Developer
2	4	\N	Experienced developer	Tehran	Computer Engineering	Web Developer
3	2	\N	Freelancer profile for user1	\N	\N	Web Developer
\.


--
-- TOC entry 5178 (class 0 OID 16458)
-- Dependencies: 227
-- Data for Name: freelancer_skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.freelancer_skill (freelancer_id, skill_id, proficiency_level) FROM stdin;
1	1	Advanced
1	2	Intermediate
2	3	Beginner
2	4	Advanced
\.


--
-- TOC entry 5187 (class 0 OID 16577)
-- Dependencies: 236
-- Data for Name: portfolio_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.portfolio_item (portfolio_id, freelancer_id, title, description, project_url, image_url, created_at) FROM stdin;
1	1	Company Website	Designed a business website	https://example.com/website	\N	2026-10-30 21:28:02.777744
2	2	Android Application	Developed an Android application	https://example.com/app	\N	2026-10-30 21:28:02.777744
\.


--
-- TOC entry 5190 (class 0 OID 16614)
-- Dependencies: 239
-- Data for Name: project_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_categories (project_id, category_id) FROM stdin;
1	1
2	2
\.


--
-- TOC entry 5181 (class 0 OID 16504)
-- Dependencies: 230
-- Data for Name: project_skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_skill (project_id, skill_id) FROM stdin;
1	2
2	3
\.


--
-- TOC entry 5180 (class 0 OID 16478)
-- Dependencies: 229
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (project_id, client_id, title, description, budget_min, budget_max, status, created_at, updated_at, deadline, pricing_type) FROM stdin;
1	1	Website Design	Design a company website	500.00	1000.00	Open	2026-10-30 20:58:15.928623	2026-10-30 20:58:15.928623	\N	Fixed
2	1	Mobile App Development	Develop an Android application	1000.00	2000.00	Open	2026-10-30 20:58:15.928623	2026-10-30 20:58:15.928623	\N	Fixed
\.


--
-- TOC entry 5183 (class 0 OID 16522)
-- Dependencies: 232
-- Data for Name: proposals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proposals (proposal_id, project_id, freelancer_id, cover_letter, proposed_price, proposed_hourly_price, status, estimated_days, submitted_at) FROM stdin;
1	1	1	I can design your website	800.00	\N	Pending	10	2026-10-30 21:17:33.363912
2	2	2	I can develop your app	1500.00	\N	Pending	20	2026-10-30 21:17:33.363912
\.


--
-- TOC entry 5194 (class 0 OID 16687)
-- Dependencies: 243
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (role_id, role_name) FROM stdin;
1	Client
2	Freelancer
3	Admin
\.


--
-- TOC entry 5177 (class 0 OID 16448)
-- Dependencies: 226
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skills (skill_id, skill_name) FROM stdin;
1	Python
2	JavaScript
3	Java
4	SQL
5	UI Design
\.


--
-- TOC entry 5195 (class 0 OID 16697)
-- Dependencies: 244
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (user_id, role_id) FROM stdin;
1	3
2	1
3	2
4	2
2	2
\.


--
-- TOC entry 5171 (class 0 OID 16390)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, email, phonenumber, password_hash, created_at, account_status, first_name, last_name, last_updated_at) FROM stdin;
1	admin1	admin@test.com	\N	dummy_hash_1	2026-10-30 20:14:16.531559	Active	Ali	َAkbari	2026-10-30 20:14:16.531559
2	user1	user1@test.com	\N	dummy_hash_2	2026-10-30 20:14:16.531559	Active	Sara	Ahmadi	2026-10-30 20:14:16.531559
3	user2	user2@test.com	\N	dummy_hash_3	2026-10-30 20:14:16.531559	Active	Reza	Karimi	2026-10-30 20:14:16.531559
4	user3	user3@test.com	\N	dummy_hash_4	2026-10-30 20:14:16.531559	Active	Mina	Hosseini	2026-10-30 20:14:16.531559
\.


--
-- TOC entry 5212 (class 0 OID 0)
-- Dependencies: 240
-- Name: admins_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_admin_id_seq', 1, true);


--
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 237
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 3, true);


--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 223
-- Name: client_profile_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_profile_client_id_seq', 1, true);


--
-- TOC entry 5215 (class 0 OID 0)
-- Dependencies: 233
-- Name: contracts_contract_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contracts_contract_id_seq', 2, true);


--
-- TOC entry 5216 (class 0 OID 0)
-- Dependencies: 221
-- Name: freelancer_profile_freelancer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.freelancer_profile_freelancer_id_seq', 3, true);


--
-- TOC entry 5217 (class 0 OID 0)
-- Dependencies: 235
-- Name: portfolio_item_portfolio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.portfolio_item_portfolio_id_seq', 2, true);


--
-- TOC entry 5218 (class 0 OID 0)
-- Dependencies: 228
-- Name: projects_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projects_project_id_seq', 2, true);


--
-- TOC entry 5219 (class 0 OID 0)
-- Dependencies: 231
-- Name: proposals_proposal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proposals_proposal_id_seq', 5, true);


--
-- TOC entry 5220 (class 0 OID 0)
-- Dependencies: 242
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 3, true);


--
-- TOC entry 5221 (class 0 OID 0)
-- Dependencies: 225
-- Name: skills_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.skills_skill_id_seq', 5, true);


--
-- TOC entry 5222 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 6, true);


--
-- TOC entry 4997 (class 2606 OID 16641)
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (admin_id);


--
-- TOC entry 4999 (class 2606 OID 16643)
-- Name: admins admins_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_user_id_key UNIQUE (user_id);


--
-- TOC entry 4991 (class 2606 OID 16613)
-- Name: categories categories_category_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_category_name_key UNIQUE (category_name);


--
-- TOC entry 4993 (class 2606 OID 16611)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 4964 (class 2606 OID 16437)
-- Name: client_profile client_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_profile
    ADD CONSTRAINT client_profile_pkey PRIMARY KEY (client_id);


--
-- TOC entry 4966 (class 2606 OID 16439)
-- Name: client_profile client_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_profile
    ADD CONSTRAINT client_profile_user_id_key UNIQUE (user_id);


--
-- TOC entry 4983 (class 2606 OID 16561)
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (contract_id);


--
-- TOC entry 4985 (class 2606 OID 16563)
-- Name: contracts contracts_project_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_project_id_key UNIQUE (project_id);


--
-- TOC entry 4987 (class 2606 OID 16565)
-- Name: contracts contracts_proposal_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_proposal_id_key UNIQUE (proposal_id);


--
-- TOC entry 4960 (class 2606 OID 16419)
-- Name: freelancer_profile freelancer_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelancer_profile
    ADD CONSTRAINT freelancer_profile_pkey PRIMARY KEY (freelancer_id);


--
-- TOC entry 4962 (class 2606 OID 16421)
-- Name: freelancer_profile freelancer_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelancer_profile
    ADD CONSTRAINT freelancer_profile_user_id_key UNIQUE (user_id);


--
-- TOC entry 4972 (class 2606 OID 16466)
-- Name: freelancer_skill freelancer_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelancer_skill
    ADD CONSTRAINT freelancer_skill_pkey PRIMARY KEY (freelancer_id, skill_id);


--
-- TOC entry 4989 (class 2606 OID 16588)
-- Name: portfolio_item portfolio_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio_item
    ADD CONSTRAINT portfolio_item_pkey PRIMARY KEY (portfolio_id);


--
-- TOC entry 4995 (class 2606 OID 16620)
-- Name: project_categories project_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_categories
    ADD CONSTRAINT project_categories_pkey PRIMARY KEY (project_id, category_id);


--
-- TOC entry 4976 (class 2606 OID 16510)
-- Name: project_skill project_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_skill
    ADD CONSTRAINT project_skill_pkey PRIMARY KEY (project_id, skill_id);


--
-- TOC entry 4974 (class 2606 OID 16498)
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project_id);


--
-- TOC entry 4979 (class 2606 OID 16535)
-- Name: proposals proposals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proposals
    ADD CONSTRAINT proposals_pkey PRIMARY KEY (proposal_id);


--
-- TOC entry 5001 (class 2606 OID 16694)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- TOC entry 5003 (class 2606 OID 16696)
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- TOC entry 4968 (class 2606 OID 16455)
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (skill_id);


--
-- TOC entry 4970 (class 2606 OID 16457)
-- Name: skills skills_skill_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_skill_name_key UNIQUE (skill_name);


--
-- TOC entry 4981 (class 2606 OID 16595)
-- Name: proposals unique_project_freelancer; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proposals
    ADD CONSTRAINT unique_project_freelancer UNIQUE (project_id, freelancer_id);


--
-- TOC entry 5005 (class 2606 OID 16703)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 4954 (class 2606 OID 16408)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4956 (class 2606 OID 16404)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4958 (class 2606 OID 16406)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4977 (class 1259 OID 16658)
-- Name: one_accepted_proposal_per_project; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX one_accepted_proposal_per_project ON public.proposals USING btree (project_id) WHERE ((status)::text = 'Accepted'::text);


--
-- TOC entry 5020 (class 2606 OID 16644)
-- Name: admins admins_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 5007 (class 2606 OID 16440)
-- Name: client_profile client_profile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_profile
    ADD CONSTRAINT client_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 5015 (class 2606 OID 16566)
-- Name: contracts contracts_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id);


--
-- TOC entry 5016 (class 2606 OID 16571)
-- Name: contracts contracts_proposal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_proposal_id_fkey FOREIGN KEY (proposal_id) REFERENCES public.proposals(proposal_id);


--
-- TOC entry 5006 (class 2606 OID 16422)
-- Name: freelancer_profile freelancer_profile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelancer_profile
    ADD CONSTRAINT freelancer_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 5008 (class 2606 OID 16659)
-- Name: freelancer_skill freelancer_skill_freelancer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelancer_skill
    ADD CONSTRAINT freelancer_skill_freelancer_id_fkey FOREIGN KEY (freelancer_id) REFERENCES public.freelancer_profile(freelancer_id) ON DELETE CASCADE;


--
-- TOC entry 5009 (class 2606 OID 16472)
-- Name: freelancer_skill freelancer_skill_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freelancer_skill
    ADD CONSTRAINT freelancer_skill_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(skill_id);


--
-- TOC entry 5017 (class 2606 OID 16674)
-- Name: portfolio_item portfolio_item_freelancer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio_item
    ADD CONSTRAINT portfolio_item_freelancer_id_fkey FOREIGN KEY (freelancer_id) REFERENCES public.freelancer_profile(freelancer_id) ON DELETE CASCADE;


--
-- TOC entry 5018 (class 2606 OID 16679)
-- Name: project_categories project_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_categories
    ADD CONSTRAINT project_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE CASCADE;


--
-- TOC entry 5019 (class 2606 OID 16669)
-- Name: project_categories project_categories_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_categories
    ADD CONSTRAINT project_categories_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- TOC entry 5011 (class 2606 OID 16664)
-- Name: project_skill project_skill_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_skill
    ADD CONSTRAINT project_skill_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- TOC entry 5012 (class 2606 OID 16516)
-- Name: project_skill project_skill_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_skill
    ADD CONSTRAINT project_skill_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(skill_id);


--
-- TOC entry 5010 (class 2606 OID 16499)
-- Name: projects projects_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client_profile(client_id);


--
-- TOC entry 5013 (class 2606 OID 16541)
-- Name: proposals proposals_freelancer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proposals
    ADD CONSTRAINT proposals_freelancer_id_fkey FOREIGN KEY (freelancer_id) REFERENCES public.freelancer_profile(freelancer_id);


--
-- TOC entry 5014 (class 2606 OID 16536)
-- Name: proposals proposals_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proposals
    ADD CONSTRAINT proposals_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id);


--
-- TOC entry 5021 (class 2606 OID 16709)
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- TOC entry 5022 (class 2606 OID 16704)
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


-- Completed on 2026-10-31 01:09:59

--
-- PostgreSQL database dump complete
--

\unrestrict J7GWGz2AqdwQNtAQLvYj3DLCjJehg9KXahEX2bg8nrXsMAeecfW2bxjk6WAYaUr


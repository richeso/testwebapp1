
// Mysql create table
----------------------
use persondb;
CREATE TABLE person (
    id bigint AUTO_INCREMENT PRIMARY KEY,
    address character varying(255),
    name character varying(255),
    surname character varying(255)
);

// this is postgres only
--------------------------
-- Name: person; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE person (
    id bigint NOT NULL,
    address character varying(255),
    name character varying(255),
    surname character varying(255)
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_id_seq OWNER TO postgres;
ALTER SEQUENCE person_id_seq OWNED BY person.id;
ALTER TABLE ONLY person ALTER COLUMN id SET DEFAULT nextval('person_id_seq'::regclass);
ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


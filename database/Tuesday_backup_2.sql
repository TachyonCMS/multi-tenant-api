--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Ubuntu 14.5-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.5 (Ubuntu 14.5-0ubuntu0.22.04.1)

-- Started on 2022-09-06 02:33:46 PDT

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
-- TOC entry 10 (class 2615 OID 16457)
-- Name: common; Type: SCHEMA; Schema: -; Owner: appuser
--

CREATE SCHEMA common;


ALTER SCHEMA common OWNER TO appuser;

--
-- TOC entry 8 (class 2615 OID 16401)
-- Name: content; Type: SCHEMA; Schema: -; Owner: appuser
--

CREATE SCHEMA content;


ALTER SCHEMA content OWNER TO appuser;

--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA content; Type: COMMENT; Schema: -; Owner: appuser
--

COMMENT ON SCHEMA content IS 'Member content';


--
-- TOC entry 11 (class 2615 OID 16399)
-- Name: members; Type: SCHEMA; Schema: -; Owner: appuser
--

CREATE SCHEMA members;


ALTER SCHEMA members OWNER TO appuser;

--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 11
-- Name: SCHEMA members; Type: COMMENT; Schema: -; Owner: appuser
--

COMMENT ON SCHEMA members IS 'Individual human user info';


--
-- TOC entry 4 (class 2615 OID 16697)
-- Name: tenant_1; Type: SCHEMA; Schema: -; Owner: appuser
--

CREATE SCHEMA tenant_1;


ALTER SCHEMA tenant_1 OWNER TO appuser;

--
-- TOC entry 7 (class 2615 OID 16698)
-- Name: tenant_2; Type: SCHEMA; Schema: -; Owner: appuser
--

CREATE SCHEMA tenant_2;


ALTER SCHEMA tenant_2 OWNER TO appuser;

--
-- TOC entry 9 (class 2615 OID 16400)
-- Name: tenants; Type: SCHEMA; Schema: -; Owner: appuser
--

CREATE SCHEMA tenants;


ALTER SCHEMA tenants OWNER TO appuser;

--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 9
-- Name: SCHEMA tenants; Type: COMMENT; Schema: -; Owner: appuser
--

COMMENT ON SCHEMA tenants IS 'Paid tenancy data';


--
-- TOC entry 867 (class 1247 OID 16459)
-- Name: account_status; Type: TYPE; Schema: common; Owner: appuser
--

CREATE TYPE common.account_status AS ENUM (
    'pending',
    'confirmed',
    'locked',
    'disabled',
    'closed'
);


ALTER TYPE common.account_status OWNER TO appuser;

--
-- TOC entry 876 (class 1247 OID 16506)
-- Name: contact_type; Type: TYPE; Schema: members; Owner: appuser
--

CREATE TYPE members.contact_type AS ENUM (
    'primary',
    'secondary'
);


ALTER TYPE members.contact_type OWNER TO appuser;

--
-- TOC entry 897 (class 1247 OID 16736)
-- Name: contact_type; Type: TYPE; Schema: tenants; Owner: appuser
--

CREATE TYPE tenants.contact_type AS ENUM (
    'primary',
    'secondary',
    'billing',
    'secondary_billing',
    'admin',
    'secondary_admin',
    'technical',
    'secondary_technical'
);


ALTER TYPE tenants.contact_type OWNER TO appuser;

--
-- TOC entry 246 (class 1255 OID 16589)
-- Name: insertafter(integer, integer[]); Type: FUNCTION; Schema: common; Owner: postgres
--

CREATE FUNCTION common.insertafter(integer, integer[]) RETURNS integer[]
    LANGUAGE plpgsql
    AS $_$
DECLARE
        target_int ALIAS FOR $1;
		in_array ALIAS FOR $2;
        clause  TEXT;
        rec     RECORD;
BEGIN
	
        
        -- final return
        RETURN in_array;
END
$_$;


ALTER FUNCTION common.insertafter(integer, integer[]) OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 16590)
-- Name: insertafter(integer, integer, integer[]); Type: FUNCTION; Schema: common; Owner: postgres
--

CREATE FUNCTION common.insertafter(integer, integer, integer[]) RETURNS integer[]
    LANGUAGE plpgsql
    AS $_$
DECLARE
        target_int ALIAS FOR $1;
		new_int ALIAS FOR $2;
		in_ids ALIAS FOR $3;
		out_ids INT[];
        clause  TEXT;
        rec     RECORD;
BEGIN
FOR item IN array_lower(in_ids, 1)..array_upper(in_ids, 1) LOOP
  out_ids  := array_append(out_ids, in_ids[item]);
  If in_ids[item] = target_int THEN 
  	out_ids  := array_append(out_ids, new_int);
  END IF;
END LOOP;
RETURN out_ids;

END
$_$;


ALTER FUNCTION common.insertafter(integer, integer, integer[]) OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 16591)
-- Name: insertbefore(integer, integer, integer[]); Type: FUNCTION; Schema: common; Owner: postgres
--

CREATE FUNCTION common.insertbefore(integer, integer, integer[]) RETURNS integer[]
    LANGUAGE plpgsql
    AS $_$
DECLARE
        target_int ALIAS FOR $1;
		new_int ALIAS FOR $2;
		in_ids ALIAS FOR $3;
		out_ids INT[];
        clause  TEXT;
        rec     RECORD;
BEGIN
FOR item IN array_lower(in_ids, 1)..array_upper(in_ids, 1) LOOP
  If in_ids[item] = target_int THEN 
  	out_ids  := array_append(out_ids, new_int);
  END IF;
  out_ids  := array_append(out_ids, in_ids[item]);
  
END LOOP;
RETURN out_ids;

END
$_$;


ALTER FUNCTION common.insertbefore(integer, integer, integer[]) OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 16518)
-- Name: trigger_set_updated(); Type: FUNCTION; Schema: common; Owner: postgres
--

CREATE FUNCTION common.trigger_set_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$;


ALTER FUNCTION common.trigger_set_updated() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16636)
-- Name: flow_type; Type: TABLE; Schema: common; Owner: appuser
--

CREATE TABLE common.flow_type (
    id smallint NOT NULL,
    code character varying(32) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE common.flow_type OWNER TO appuser;

--
-- TOC entry 225 (class 1259 OID 16635)
-- Name: flow_type_id_seq; Type: SEQUENCE; Schema: common; Owner: appuser
--

CREATE SEQUENCE common.flow_type_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.flow_type_id_seq OWNER TO appuser;

--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 225
-- Name: flow_type_id_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: appuser
--

ALTER SEQUENCE common.flow_type_id_seq OWNED BY common.flow_type.id;


--
-- TOC entry 228 (class 1259 OID 16659)
-- Name: nugget_type; Type: TABLE; Schema: common; Owner: appuser
--

CREATE TABLE common.nugget_type (
    id smallint NOT NULL,
    code character varying(32) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE common.nugget_type OWNER TO appuser;

--
-- TOC entry 227 (class 1259 OID 16658)
-- Name: nugget_type_id_seq; Type: SEQUENCE; Schema: common; Owner: appuser
--

CREATE SEQUENCE common.nugget_type_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.nugget_type_id_seq OWNER TO appuser;

--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 227
-- Name: nugget_type_id_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: appuser
--

ALTER SEQUENCE common.nugget_type_id_seq OWNED BY common.nugget_type.id;


--
-- TOC entry 216 (class 1259 OID 16403)
-- Name: account; Type: TABLE; Schema: members; Owner: appuser
--

CREATE TABLE members.account (
    id integer NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    status common.account_status DEFAULT 'pending'::common.account_status NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE members.account OWNER TO appuser;

--
-- TOC entry 215 (class 1259 OID 16402)
-- Name: account_id_seq; Type: SEQUENCE; Schema: members; Owner: appuser
--

CREATE SEQUENCE members.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE members.account_id_seq OWNER TO appuser;

--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 215
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: members; Owner: appuser
--

ALTER SEQUENCE members.account_id_seq OWNED BY members.account.id;


--
-- TOC entry 220 (class 1259 OID 16488)
-- Name: contact; Type: TABLE; Schema: members; Owner: appuser
--

CREATE TABLE members.contact (
    id integer NOT NULL,
    account_id integer NOT NULL,
    name character varying(120),
    email character varying(320),
    phone character varying(30),
    contact_type members.contact_type DEFAULT 'primary'::members.contact_type,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE members.contact OWNER TO appuser;

--
-- TOC entry 219 (class 1259 OID 16487)
-- Name: contact_id_seq; Type: SEQUENCE; Schema: members; Owner: appuser
--

CREATE SEQUENCE members.contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE members.contact_id_seq OWNER TO appuser;

--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 219
-- Name: contact_id_seq; Type: SEQUENCE OWNED BY; Schema: members; Owner: appuser
--

ALTER SEQUENCE members.contact_id_seq OWNED BY members.contact.id;


--
-- TOC entry 222 (class 1259 OID 16527)
-- Name: flow; Type: TABLE; Schema: members; Owner: appuser
--

CREATE TABLE members.flow (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    title character varying(200),
    account_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone,
    flow_type_id smallint DEFAULT 0 NOT NULL
);


ALTER TABLE members.flow OWNER TO appuser;

--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE flow; Type: COMMENT; Schema: members; Owner: appuser
--

COMMENT ON TABLE members.flow IS 'Flow data';


--
-- TOC entry 221 (class 1259 OID 16526)
-- Name: flow_id_seq; Type: SEQUENCE; Schema: members; Owner: appuser
--

CREATE SEQUENCE members.flow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE members.flow_id_seq OWNER TO appuser;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 221
-- Name: flow_id_seq; Type: SEQUENCE OWNED BY; Schema: members; Owner: appuser
--

ALTER SEQUENCE members.flow_id_seq OWNED BY members.flow.id;


--
-- TOC entry 244 (class 1259 OID 24745)
-- Name: flow_nugget; Type: TABLE; Schema: members; Owner: appuser
--

CREATE TABLE members.flow_nugget (
    id integer NOT NULL,
    flow_id integer NOT NULL,
    nugget_ids integer[] NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE members.flow_nugget OWNER TO appuser;

--
-- TOC entry 243 (class 1259 OID 24744)
-- Name: flow_nugget_id_seq; Type: SEQUENCE; Schema: members; Owner: appuser
--

CREATE SEQUENCE members.flow_nugget_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE members.flow_nugget_id_seq OWNER TO appuser;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 243
-- Name: flow_nugget_id_seq; Type: SEQUENCE OWNED BY; Schema: members; Owner: appuser
--

ALTER SEQUENCE members.flow_nugget_id_seq OWNED BY members.flow_nugget.id;


--
-- TOC entry 218 (class 1259 OID 16441)
-- Name: identity; Type: TABLE; Schema: members; Owner: appuser
--

CREATE TABLE members.identity (
    id integer NOT NULL,
    name character varying(160),
    given_name character varying(80),
    surnname character varying(80),
    account_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    upated_at timestamp with time zone
);


ALTER TABLE members.identity OWNER TO appuser;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE identity; Type: COMMENT; Schema: members; Owner: appuser
--

COMMENT ON TABLE members.identity IS 'Identifies a member';


--
-- TOC entry 217 (class 1259 OID 16440)
-- Name: identity_id_seq; Type: SEQUENCE; Schema: members; Owner: appuser
--

CREATE SEQUENCE members.identity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE members.identity_id_seq OWNER TO appuser;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 217
-- Name: identity_id_seq; Type: SEQUENCE OWNED BY; Schema: members; Owner: appuser
--

ALTER SEQUENCE members.identity_id_seq OWNED BY members.identity.id;


--
-- TOC entry 224 (class 1259 OID 16626)
-- Name: nugget; Type: TABLE; Schema: members; Owner: appuser
--

CREATE TABLE members.nugget (
    id integer NOT NULL,
    blocks jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone,
    publish_at timestamp with time zone,
    unpublish_at timestamp with time zone,
    nugget_type_id smallint DEFAULT 0 NOT NULL
);


ALTER TABLE members.nugget OWNER TO appuser;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE nugget; Type: COMMENT; Schema: members; Owner: appuser
--

COMMENT ON TABLE members.nugget IS 'Nugget data';


--
-- TOC entry 223 (class 1259 OID 16625)
-- Name: nugget_id_seq; Type: SEQUENCE; Schema: members; Owner: appuser
--

CREATE SEQUENCE members.nugget_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE members.nugget_id_seq OWNER TO appuser;

--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 223
-- Name: nugget_id_seq; Type: SEQUENCE OWNED BY; Schema: members; Owner: appuser
--

ALTER SEQUENCE members.nugget_id_seq OWNED BY members.nugget.id;


--
-- TOC entry 234 (class 1259 OID 16754)
-- Name: contact; Type: TABLE; Schema: tenant_1; Owner: appuser
--

CREATE TABLE tenant_1.contact (
    id integer NOT NULL,
    account_id integer NOT NULL,
    name character varying(120),
    email character varying(320),
    phone character varying(30),
    contact_type tenants.contact_type,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE tenant_1.contact OWNER TO appuser;

--
-- TOC entry 233 (class 1259 OID 16753)
-- Name: contact_id_seq; Type: SEQUENCE; Schema: tenant_1; Owner: appuser
--

CREATE SEQUENCE tenant_1.contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tenant_1.contact_id_seq OWNER TO appuser;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 233
-- Name: contact_id_seq; Type: SEQUENCE OWNED BY; Schema: tenant_1; Owner: appuser
--

ALTER SEQUENCE tenant_1.contact_id_seq OWNED BY tenant_1.contact.id;


--
-- TOC entry 238 (class 1259 OID 24720)
-- Name: member_role                                                    ; Type: TABLE; Schema: tenant_1; Owner: appuser
--

CREATE TABLE tenant_1."member_role                                                    " (
    id smallint NOT NULL,
    member_account_id integer NOT NULL,
    role_id smallint NOT NULL
);


ALTER TABLE tenant_1."member_role                                                    " OWNER TO appuser;

--
-- TOC entry 237 (class 1259 OID 24719)
-- Name: member_role                                             _id_seq; Type: SEQUENCE; Schema: tenant_1; Owner: appuser
--

CREATE SEQUENCE tenant_1."member_role                                             _id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tenant_1."member_role                                             _id_seq" OWNER TO appuser;

--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 237
-- Name: member_role                                             _id_seq; Type: SEQUENCE OWNED BY; Schema: tenant_1; Owner: appuser
--

ALTER SEQUENCE tenant_1."member_role                                             _id_seq" OWNED BY tenant_1."member_role                                                    ".id;


--
-- TOC entry 236 (class 1259 OID 16767)
-- Name: contact; Type: TABLE; Schema: tenant_2; Owner: postgres
--

CREATE TABLE tenant_2.contact (
    id integer NOT NULL,
    account_id integer NOT NULL,
    name character varying(120),
    email character varying(320),
    phone character varying(30),
    contact_type tenants.contact_type DEFAULT 'primary'::tenants.contact_type,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE tenant_2.contact OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16766)
-- Name: contact_id_seq; Type: SEQUENCE; Schema: tenant_2; Owner: postgres
--

CREATE SEQUENCE tenant_2.contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tenant_2.contact_id_seq OWNER TO postgres;

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 235
-- Name: contact_id_seq; Type: SEQUENCE OWNED BY; Schema: tenant_2; Owner: postgres
--

ALTER SEQUENCE tenant_2.contact_id_seq OWNED BY tenant_2.contact.id;


--
-- TOC entry 242 (class 1259 OID 24736)
-- Name: role; Type: TABLE; Schema: tenant_2; Owner: appuser
--

CREATE TABLE tenant_2.role (
    id smallint NOT NULL,
    code character varying(30) NOT NULL,
    permissions jsonb
);


ALTER TABLE tenant_2.role OWNER TO appuser;

--
-- TOC entry 241 (class 1259 OID 24735)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: tenant_2; Owner: appuser
--

CREATE SEQUENCE tenant_2.roles_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tenant_2.roles_id_seq OWNER TO appuser;

--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 241
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: tenant_2; Owner: appuser
--

ALTER SEQUENCE tenant_2.roles_id_seq OWNED BY tenant_2.role.id;


--
-- TOC entry 230 (class 1259 OID 16676)
-- Name: account; Type: TABLE; Schema: tenants; Owner: appuser
--

CREATE TABLE tenants.account (
    id integer NOT NULL,
    public_id uuid DEFAULT gen_random_uuid() NOT NULL,
    status common.account_status DEFAULT 'pending'::common.account_status NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE tenants.account OWNER TO appuser;

--
-- TOC entry 229 (class 1259 OID 16675)
-- Name: account_id_seq; Type: SEQUENCE; Schema: tenants; Owner: appuser
--

CREATE SEQUENCE tenants.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tenants.account_id_seq OWNER TO appuser;

--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 229
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: tenants; Owner: appuser
--

ALTER SEQUENCE tenants.account_id_seq OWNED BY tenants.account.id;


--
-- TOC entry 232 (class 1259 OID 16686)
-- Name: contact; Type: TABLE; Schema: tenants; Owner: appuser
--

CREATE TABLE tenants.contact (
    id integer NOT NULL,
    name character varying(160),
    given_name character varying(80),
    surname character varying(80),
    account_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE tenants.contact OWNER TO appuser;

--
-- TOC entry 231 (class 1259 OID 16685)
-- Name: contact_id_seq; Type: SEQUENCE; Schema: tenants; Owner: appuser
--

CREATE SEQUENCE tenants.contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tenants.contact_id_seq OWNER TO appuser;

--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 231
-- Name: contact_id_seq; Type: SEQUENCE OWNED BY; Schema: tenants; Owner: appuser
--

ALTER SEQUENCE tenants.contact_id_seq OWNED BY tenants.contact.id;


--
-- TOC entry 240 (class 1259 OID 24727)
-- Name: role; Type: TABLE; Schema: tenants; Owner: appuser
--

CREATE TABLE tenants.role (
    id smallint NOT NULL,
    code character varying(30) NOT NULL,
    permissions jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE tenants.role OWNER TO appuser;

--
-- TOC entry 239 (class 1259 OID 24726)
-- Name: role_id_seq; Type: SEQUENCE; Schema: tenants; Owner: appuser
--

CREATE SEQUENCE tenants.role_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tenants.role_id_seq OWNER TO appuser;

--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 239
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: tenants; Owner: appuser
--

ALTER SEQUENCE tenants.role_id_seq OWNED BY tenants.role.id;


--
-- TOC entry 3309 (class 2604 OID 16639)
-- Name: flow_type id; Type: DEFAULT; Schema: common; Owner: appuser
--

ALTER TABLE ONLY common.flow_type ALTER COLUMN id SET DEFAULT nextval('common.flow_type_id_seq'::regclass);


--
-- TOC entry 3311 (class 2604 OID 16662)
-- Name: nugget_type id; Type: DEFAULT; Schema: common; Owner: appuser
--

ALTER TABLE ONLY common.nugget_type ALTER COLUMN id SET DEFAULT nextval('common.nugget_type_id_seq'::regclass);


--
-- TOC entry 3294 (class 2604 OID 16406)
-- Name: account id; Type: DEFAULT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.account ALTER COLUMN id SET DEFAULT nextval('members.account_id_seq'::regclass);


--
-- TOC entry 3300 (class 2604 OID 16491)
-- Name: contact id; Type: DEFAULT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.contact ALTER COLUMN id SET DEFAULT nextval('members.contact_id_seq'::regclass);


--
-- TOC entry 3303 (class 2604 OID 16530)
-- Name: flow id; Type: DEFAULT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.flow ALTER COLUMN id SET DEFAULT nextval('members.flow_id_seq'::regclass);


--
-- TOC entry 3327 (class 2604 OID 24748)
-- Name: flow_nugget id; Type: DEFAULT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.flow_nugget ALTER COLUMN id SET DEFAULT nextval('members.flow_nugget_id_seq'::regclass);


--
-- TOC entry 3298 (class 2604 OID 16444)
-- Name: identity id; Type: DEFAULT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.identity ALTER COLUMN id SET DEFAULT nextval('members.identity_id_seq'::regclass);


--
-- TOC entry 3306 (class 2604 OID 16629)
-- Name: nugget id; Type: DEFAULT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.nugget ALTER COLUMN id SET DEFAULT nextval('members.nugget_id_seq'::regclass);


--
-- TOC entry 3318 (class 2604 OID 16757)
-- Name: contact id; Type: DEFAULT; Schema: tenant_1; Owner: appuser
--

ALTER TABLE ONLY tenant_1.contact ALTER COLUMN id SET DEFAULT nextval('tenant_1.contact_id_seq'::regclass);


--
-- TOC entry 3323 (class 2604 OID 24723)
-- Name: member_role                                                     id; Type: DEFAULT; Schema: tenant_1; Owner: appuser
--

ALTER TABLE ONLY tenant_1."member_role                                                    " ALTER COLUMN id SET DEFAULT nextval('tenant_1."member_role                                             _id_seq"'::regclass);


--
-- TOC entry 3320 (class 2604 OID 16770)
-- Name: contact id; Type: DEFAULT; Schema: tenant_2; Owner: postgres
--

ALTER TABLE ONLY tenant_2.contact ALTER COLUMN id SET DEFAULT nextval('tenant_2.contact_id_seq'::regclass);


--
-- TOC entry 3326 (class 2604 OID 24739)
-- Name: role id; Type: DEFAULT; Schema: tenant_2; Owner: appuser
--

ALTER TABLE ONLY tenant_2.role ALTER COLUMN id SET DEFAULT nextval('tenant_2.roles_id_seq'::regclass);


--
-- TOC entry 3313 (class 2604 OID 16679)
-- Name: account id; Type: DEFAULT; Schema: tenants; Owner: appuser
--

ALTER TABLE ONLY tenants.account ALTER COLUMN id SET DEFAULT nextval('tenants.account_id_seq'::regclass);


--
-- TOC entry 3317 (class 2604 OID 16689)
-- Name: contact id; Type: DEFAULT; Schema: tenants; Owner: appuser
--

ALTER TABLE ONLY tenants.contact ALTER COLUMN id SET DEFAULT nextval('tenants.contact_id_seq'::regclass);


--
-- TOC entry 3324 (class 2604 OID 24730)
-- Name: role id; Type: DEFAULT; Schema: tenants; Owner: appuser
--

ALTER TABLE ONLY tenants.role ALTER COLUMN id SET DEFAULT nextval('tenants.role_id_seq'::regclass);


--
-- TOC entry 3341 (class 2606 OID 16642)
-- Name: flow_type flow_type_pkey; Type: CONSTRAINT; Schema: common; Owner: appuser
--

ALTER TABLE ONLY common.flow_type
    ADD CONSTRAINT flow_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3343 (class 2606 OID 16664)
-- Name: nugget_type nugget_type_pkey; Type: CONSTRAINT; Schema: common; Owner: appuser
--

ALTER TABLE ONLY common.nugget_type
    ADD CONSTRAINT nugget_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3330 (class 2606 OID 16410)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 3335 (class 2606 OID 16493)
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- TOC entry 3359 (class 2606 OID 24752)
-- Name: flow_nugget flow_nugget_pkey; Type: CONSTRAINT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.flow_nugget
    ADD CONSTRAINT flow_nugget_pkey PRIMARY KEY (id);


--
-- TOC entry 3337 (class 2606 OID 16532)
-- Name: flow flow_pkey; Type: CONSTRAINT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.flow
    ADD CONSTRAINT flow_pkey PRIMARY KEY (id);


--
-- TOC entry 3333 (class 2606 OID 16446)
-- Name: identity identity_pkey; Type: CONSTRAINT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.identity
    ADD CONSTRAINT identity_pkey PRIMARY KEY (id);


--
-- TOC entry 3339 (class 2606 OID 16634)
-- Name: nugget nugget_pkey; Type: CONSTRAINT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.nugget
    ADD CONSTRAINT nugget_pkey PRIMARY KEY (id);


--
-- TOC entry 3349 (class 2606 OID 16760)
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: tenant_1; Owner: appuser
--

ALTER TABLE ONLY tenant_1.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- TOC entry 3353 (class 2606 OID 24725)
-- Name: member_role                                                     member_role                                               _pkey; Type: CONSTRAINT; Schema: tenant_1; Owner: appuser
--

ALTER TABLE ONLY tenant_1."member_role                                                    "
    ADD CONSTRAINT "member_role                                               _pkey" PRIMARY KEY (id);


--
-- TOC entry 3351 (class 2606 OID 16774)
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: tenant_2; Owner: postgres
--

ALTER TABLE ONLY tenant_2.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- TOC entry 3357 (class 2606 OID 24743)
-- Name: role roles_pkey; Type: CONSTRAINT; Schema: tenant_2; Owner: appuser
--

ALTER TABLE ONLY tenant_2.role
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3345 (class 2606 OID 16684)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: tenants; Owner: appuser
--

ALTER TABLE ONLY tenants.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 3347 (class 2606 OID 16691)
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: tenants; Owner: appuser
--

ALTER TABLE ONLY tenants.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- TOC entry 3355 (class 2606 OID 24734)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: tenants; Owner: appuser
--

ALTER TABLE ONLY tenants.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 3331 (class 1259 OID 16474)
-- Name: fki_identity_account_fk; Type: INDEX; Schema: members; Owner: appuser
--

CREATE INDEX fki_identity_account_fk ON members.identity USING btree (account_id);


--
-- TOC entry 3373 (class 2620 OID 16672)
-- Name: flow_type set_updated; Type: TRIGGER; Schema: common; Owner: appuser
--

CREATE TRIGGER set_updated BEFORE UPDATE ON common.flow_type FOR EACH ROW EXECUTE FUNCTION common.trigger_set_updated();


--
-- TOC entry 3374 (class 2620 OID 16671)
-- Name: nugget_type set_updated; Type: TRIGGER; Schema: common; Owner: appuser
--

CREATE TRIGGER set_updated BEFORE UPDATE ON common.nugget_type FOR EACH ROW EXECUTE FUNCTION common.trigger_set_updated();


--
-- TOC entry 3368 (class 2620 OID 16519)
-- Name: account set_updated; Type: TRIGGER; Schema: members; Owner: appuser
--

CREATE TRIGGER set_updated BEFORE UPDATE ON members.account FOR EACH ROW EXECUTE FUNCTION common.trigger_set_updated();


--
-- TOC entry 3370 (class 2620 OID 16523)
-- Name: contact set_updated; Type: TRIGGER; Schema: members; Owner: appuser
--

CREATE TRIGGER set_updated BEFORE UPDATE ON members.contact FOR EACH ROW EXECUTE FUNCTION common.trigger_set_updated();


--
-- TOC entry 3371 (class 2620 OID 16539)
-- Name: flow set_updated; Type: TRIGGER; Schema: members; Owner: appuser
--

CREATE TRIGGER set_updated BEFORE UPDATE ON members.flow FOR EACH ROW EXECUTE FUNCTION common.trigger_set_updated();


--
-- TOC entry 3376 (class 2620 OID 24754)
-- Name: flow_nugget set_updated; Type: TRIGGER; Schema: members; Owner: appuser
--

CREATE TRIGGER set_updated BEFORE UPDATE ON members.flow_nugget FOR EACH ROW EXECUTE FUNCTION common.trigger_set_updated();


--
-- TOC entry 3369 (class 2620 OID 16524)
-- Name: identity set_updated; Type: TRIGGER; Schema: members; Owner: appuser
--

CREATE TRIGGER set_updated BEFORE UPDATE ON members.identity FOR EACH ROW EXECUTE FUNCTION common.trigger_set_updated();


--
-- TOC entry 3372 (class 2620 OID 16673)
-- Name: nugget set_updated; Type: TRIGGER; Schema: members; Owner: appuser
--

CREATE TRIGGER set_updated BEFORE UPDATE ON members.nugget FOR EACH ROW EXECUTE FUNCTION common.trigger_set_updated();


--
-- TOC entry 3375 (class 2620 OID 24756)
-- Name: role set_updated; Type: TRIGGER; Schema: tenants; Owner: appuser
--

CREATE TRIGGER set_updated BEFORE UPDATE ON tenants.role FOR EACH ROW EXECUTE FUNCTION common.trigger_set_updated();


--
-- TOC entry 3361 (class 2606 OID 16494)
-- Name: contact contact_account_fk; Type: FK CONSTRAINT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.contact
    ADD CONSTRAINT contact_account_fk FOREIGN KEY (account_id) REFERENCES members.account(id);


--
-- TOC entry 3362 (class 2606 OID 16533)
-- Name: flow flow_account_fk; Type: FK CONSTRAINT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.flow
    ADD CONSTRAINT flow_account_fk FOREIGN KEY (account_id) REFERENCES members.account(id);


--
-- TOC entry 3363 (class 2606 OID 16651)
-- Name: flow flow_type_fk; Type: FK CONSTRAINT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.flow
    ADD CONSTRAINT flow_type_fk FOREIGN KEY (flow_type_id) REFERENCES common.flow_type(id) NOT VALID;


--
-- TOC entry 3360 (class 2606 OID 16469)
-- Name: identity identity_account_fk; Type: FK CONSTRAINT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.identity
    ADD CONSTRAINT identity_account_fk FOREIGN KEY (account_id) REFERENCES members.account(id) NOT VALID;


--
-- TOC entry 3364 (class 2606 OID 16665)
-- Name: nugget nugget_type_fk; Type: FK CONSTRAINT; Schema: members; Owner: appuser
--

ALTER TABLE ONLY members.nugget
    ADD CONSTRAINT nugget_type_fk FOREIGN KEY (nugget_type_id) REFERENCES common.nugget_type(id) NOT VALID;


--
-- TOC entry 3366 (class 2606 OID 16761)
-- Name: contact t1_contact_account_fk; Type: FK CONSTRAINT; Schema: tenant_1; Owner: appuser
--

ALTER TABLE ONLY tenant_1.contact
    ADD CONSTRAINT t1_contact_account_fk FOREIGN KEY (account_id) REFERENCES tenants.account(id);


--
-- TOC entry 3367 (class 2606 OID 16776)
-- Name: contact t2_contact_account_fk; Type: FK CONSTRAINT; Schema: tenant_2; Owner: postgres
--

ALTER TABLE ONLY tenant_2.contact
    ADD CONSTRAINT t2_contact_account_fk FOREIGN KEY (account_id) REFERENCES tenants.account(id) NOT VALID;


--
-- TOC entry 3365 (class 2606 OID 16692)
-- Name: contact tenant_account_contact_fk; Type: FK CONSTRAINT; Schema: tenants; Owner: appuser
--

ALTER TABLE ONLY tenants.contact
    ADD CONSTRAINT tenant_account_contact_fk FOREIGN KEY (account_id) REFERENCES tenants.account(id);


-- Completed on 2022-09-06 02:33:46 PDT

--
-- PostgreSQL database dump complete
--



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

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "public"."birthdays" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "user_id" "text" NOT NULL,
    "server_id" "text" NOT NULL,
    "channel_id" "text" NOT NULL,
    "birthday" "date" NOT NULL,
    "has_year" boolean DEFAULT false NOT NULL
);

ALTER TABLE "public"."birthdays" OWNER TO "postgres";

ALTER TABLE "public"."birthdays" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."birthdays_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."steam_games" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text" NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "last_announcement_id" "text"
);

ALTER TABLE "public"."steam_games" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."steam_subscriptions" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "disabled_at" timestamp with time zone,
    "server_id" "text" NOT NULL,
    "channel_id" "text" NOT NULL,
    "game_id" bigint NOT NULL,
    "role_id" "text"
);

ALTER TABLE "public"."steam_subscriptions" OWNER TO "postgres";

ALTER TABLE "public"."steam_subscriptions" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."steam_subscriptions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."twitch_subscriptions" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "server_id" "text" NOT NULL,
    "channel_id" "text" NOT NULL,
    "role_id" "text",
    "subscription_id" "text" NOT NULL,
    "user_id" "text" NOT NULL
);

ALTER TABLE "public"."twitch_subscriptions" OWNER TO "postgres";

ALTER TABLE "public"."twitch_subscriptions" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."twitch_subscriptions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY "public"."birthdays"
    ADD CONSTRAINT "birthdays_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."birthdays"
    ADD CONSTRAINT "birthdays_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."steam_games"
    ADD CONSTRAINT "steam_games_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."steam_games"
    ADD CONSTRAINT "steam_games_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."steam_subscriptions"
    ADD CONSTRAINT "steam_subscriptions_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."steam_subscriptions"
    ADD CONSTRAINT "steam_subscriptions_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."twitch_subscriptions"
    ADD CONSTRAINT "twitch_subscriptions_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."twitch_subscriptions"
    ADD CONSTRAINT "twitch_subscriptions_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."steam_subscriptions"
    ADD CONSTRAINT "steam_subscriptions_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."steam_games"("id") ON DELETE RESTRICT;

GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT ALL ON TABLE "public"."birthdays" TO "anon";
GRANT ALL ON TABLE "public"."birthdays" TO "authenticated";
GRANT ALL ON TABLE "public"."birthdays" TO "service_role";

GRANT ALL ON SEQUENCE "public"."birthdays_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."birthdays_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."birthdays_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."steam_games" TO "anon";
GRANT ALL ON TABLE "public"."steam_games" TO "authenticated";
GRANT ALL ON TABLE "public"."steam_games" TO "service_role";

GRANT ALL ON TABLE "public"."steam_subscriptions" TO "anon";
GRANT ALL ON TABLE "public"."steam_subscriptions" TO "authenticated";
GRANT ALL ON TABLE "public"."steam_subscriptions" TO "service_role";

GRANT ALL ON SEQUENCE "public"."steam_subscriptions_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."steam_subscriptions_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."steam_subscriptions_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."twitch_subscriptions" TO "anon";
GRANT ALL ON TABLE "public"."twitch_subscriptions" TO "authenticated";
GRANT ALL ON TABLE "public"."twitch_subscriptions" TO "service_role";

GRANT ALL ON SEQUENCE "public"."twitch_subscriptions_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."twitch_subscriptions_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."twitch_subscriptions_id_seq" TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";

RESET ALL;

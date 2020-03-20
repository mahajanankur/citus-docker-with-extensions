-- wrap in transaction to ensure Docker flag always visible
BEGIN;
CREATE EXTENSION citus;

-- add Docker flag to node metadata
UPDATE pg_dist_node_metadata SET metadata=jsonb_insert(metadata, '{docker}', 'true');

-- extensions:
CREATE EXTENSION IF NOT EXISTS "hll";
CREATE EXTENSION IF NOT EXISTS "topn";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
-- Partman
-- CREATE SCHEMA partman;
-- CREATE EXTENSION pg_partman SCHEMA partman;

COMMIT;

# citus-docker-with-extensions
Citus docker with default 3 node cluster with hll, topn and partman pre-build extensions. 

# Start citus 3 node cluster.
`docker-compose -p citus up`

`docker-compose -p citus up --build`

`docker-compose -p citus up -d`

# Get all the active worker nodes.

`SELECT master_get_active_worker_nodes();`

# To scale worker to n numbers.

`docker-compose -p citus scale worker=5`

# Stop citus cluster.

`docker-compose -p citus`

# To import default schema

`docker container exec -i citus_master psql -U postgres < ddl.sql`
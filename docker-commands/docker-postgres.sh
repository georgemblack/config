docker container run -d \
	-p 5432:5432 \
	-v postgres_data:/var/lib/postgresql/data \
	-e POSTGRES_PASSWORD=password \
	-e POSTGRES_USER=postgres-user \
	-e POSTGRES_DB=exampledb \
	--restart always \
	--name postgres-example \
	postgres

# Connecting to container
docker exec -it <container-name> <command>
docker exec -it postgres_test psql -U postgres-user

# Connecting remotely
psql exampledb -h <host> -U <user>
psql exampledb -h localhost -U postgres-user
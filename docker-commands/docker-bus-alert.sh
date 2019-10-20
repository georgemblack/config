docker build -t bus-alert:latest .

docker run -d \
 	--restart always \
 	--net lionshare \
 	--name bus-alert \
 	bus-alert:latest

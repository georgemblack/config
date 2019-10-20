docker run -d \
 	-p 9000:8000 \
 	-e "SCALITY_ACCESS_KEY_ID=myAccessKeyId" \
  	-e "SCALITY_SECRET_ACCESS_KEY=mySecretAccesKey" \
 	-v $HOME/data/s3/data:/usr/src/app/localData \
  	-v $HOME/data/s3/metadata:/usr/src/app/localMetadata \
 	--restart always \
 	--name s3server \
 	scality/s3server

source .env.network
source .env.volume

if [ "$(docker volume ls -q -f name="$VOLUME_NAME")" ]; then
   echo "A volume with name $VOLUME_NAME already exists"
else
  docker volume create $VOLUME_NAME
fi

if [ "$(docker volume ls -q -f name="$NETWORK_NAME")" ]; then
   echo "A volume with name $NETWORK_NAME already exists"
else
  docker volume create $NETWORK_NAME
fi

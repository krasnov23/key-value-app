MONGODB_IMAGE="mongodb/mongodb-community-server"
MONGODB_TAG="7.0-ubuntu2204"
source .env.db

#root credentials
ROOT_USER="root-user"
ROOT_PASSWORD="root-password"

# key-value credentials
KEY_VALUE_DB="key-value-db"
KEY_VALUE_USER="key-value-user"
KEY_VALUE_PASSWORD="key-value-password"

# network и порты контейнера
source .env.network
LOCALHOST_PORT=27017
CONTAINER_PORT=27017

#Создание  volume и подключение туда volume контейнера
source .env.volume
VOLUME_CONTAINER_PATH="/data/db"

# --- создать сеть если её нет ---
if ! docker network inspect $NETWORK_NAME >/dev/null 2>&1; then
  echo "Creating docker network: $NETWORK_NAME"
  docker network create $NETWORK_NAME
fi

if [ "$(docker ps -q -f name="$CONTAINER_NAME")" ]; then
   echo "A container with name $CONTAINER_NAME already exists"
fi

# Образ MongoDB имеет специальную логику: если при старте контейнера есть файлы в папке:
# /docker-entrypoint-initdb.d они автоматически выполняются.
# Поэтому файл: mongo-init.js будет автоматически выполнен при первом запуске базы. ro означает: read-only
docker run --rm -d --name $CONTAINER_NAME \
  -e MONGODB_INITDB_ROOT_USERNAME=$ROOT_USER \
  -e MONGODB_INITDB_ROOT_PASSWORD=$ROOT_PASSWORD \
  -e KEY_VALUE_DB=$KEY_VALUE_DB \
  -e KEY_VALUE_USER=$KEY_VALUE_USER \
  -e KEY_VALUE_PASSWORD=$KEY_VALUE_PASSWORD \
  -p $LOCALHOST_PORT:$CONTAINER_PORT \
  -v $VOLUME_NAME:$VOLUME_CONTAINER_PATH \
  -v ./db-config/mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js:ro \
  --network $NETWORK_NAME \
  $MONGODB_IMAGE:$MONGODB_TAG
# Копируем все переменные окружения нужные нам для чистки контейнера сети и вольюмов
source .env.db
source .env.network
source .env.volume

if [ "$(docker ps -aq -f name="$CONTAINER_NAME")" ]; then
    echo "removing container $CONTAINER_NAME"
    docker kill $CONTAINER_NAME #&& docker rm $CONTAINER_NAME - if container not removing after stop(kill)
else
    echo "container $CONTAINER_NAME doesnt exists"
fi

if [ "$(docker volume ls -q -f name="$VOLUME_NAME")" ]; then
    echo "removing volume $VOLUME_NAME"
    docker volume rm $VOLUME_NAME
else
    echo "volume $VOLUME_NAME doesnt exists"
fi

if [ "$(docker network ls -q -f name="$NETWORK_NAME")" ]; then
    echo "removing network $NETWORK_NAME"
    docker network rm $NETWORK_NAME
else
    echo "volume $NETWORK_NAME doesnt exists"
fi



Инструкция по проекту:
1. Запустить в терминале команду которая запустит наш скрипт
`./start-db.sh`

Команды для проверки:

`docker run --rm --name debugsh -it --network key-value-net 
mongodb/mongodb-community-server:7.0-ubuntu2204 
mongosh mongodb://key-value-user:key-value-password@mongodb/key-value-db` 

Команда выше запускает новый контейнер и тестирует подключение к БД в созданном
с помощью команды выше контейнере

Команда mongodb://mongodb/key-value-db будет выполненна внутри контейнера
mongodb:// - Протокол подключения к MongoDB.
mongodb - Это hostname сервера MongoDB. И он берётся из имени контейнера.
key-value-db - база данных которую мы создали в команде выше

В появившейся оболочке mongosh команда `show collections` даст нам понять можем ли мы 
сделать запрос к монго к нашему основному контейнеру

далее в папке backend мы создаем node js приложение
`npm init -y`
💡 Обычно это первая команда при создании проекта на Node.js вместе с Node.js и npm.

Затем команда `npm i express@4.19.2 mongoose@8.5.1 body-parser@1.20.2 --save-exact`

Установить 3 пакета в конкретных версиях сохранить их в package.json без автоматических обновлений

Подключиться к бд 
`docker exec -it mongodb mongosh \
  -u root-user \
  -p root-password \
  --authenticationDatabase admin`

Подключиться к бд с хоста:
`mongosh "mongodb://root-user:root-password@localhost:27017/admin"`

Показать имеющиеся БД:
`show dbs`

Собрать образ по Dockerfile папка backend:
`docker build -t key-value-backend -f Dockerfile.dev .`

Поднять контейнер по созданному образу
`docker run -d \
  --name backend \
  --network key-value-net \
  -p 3000:3000 \
  key-value-backend`

Посмотреть логи поднятого backend контейнера:
`docker logs backend`

# Для того чтобы контейнер мог быстро вносить изменения мы подключили пакет nodemon.

Скрипт "dev": "nodemon src/server.js"
В Node.js через nodemon ты говоришь:
«Следи за файлами и перезапускай сервер при любом изменении кода».





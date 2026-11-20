# Docker commands

### Docker commands


`docker pull [имя ообраза:тег]` - pull образа

`docker images` - список образов

`docker run [имя ообраза:тег]` - запуск образа

`docker run --name [желаемое имя контейнера] [имя ообраза:тег]` - запуск образа с желаемым именем контейнера

`docler run -rm [идентификатор или имя контейнера]` - удалить контейнер после завершения его работы `rm` - `remove`

`docker ps -a` - показать все контейнеры `a` - `all`

`docker ps` - показать только запущенные контейнеры

`docker start [идентификатор или имя контейнера]` - запуск docker-контейнера

`docker -i start [идентификатор или имя контейнера]` - запуск docker-контейнера с привязкой вывода контейнера к терминалу `-i` - `interactive`

`docker stop [идентификатор или имя контейнера]` - остановить контейнер

`docker kill [идентификатор или имя контейнера]` - убить процесс выполнения контейнера

`docker run -i -t [идентификатор или имя контейнера]` запуск образа `-i` - вывод лога в терминал `-t` - возможность удалённого взаимодействия с контейнером из терминала

`docker rm [идентификатор или имя контейнера]` - удалить контейнер

`docker container prune` - удалить все остановленные контейнеры

`docker rmi [идентификатор или имя контейнера]` - удалить образ

`docker build [путь к файлу] -t [имя образа]` - создание docker образа из Dockerfile

`docker build . - t myapp:0.1` - создание docker образа из Dockerfile

`docker run --name my-python-app --rm -d python-app:0.7` - запуск контейнера в фоновом режиме `d` - `deteach` с удалением после окончания работы

`docker logs my-python-app` - посмотреть логи контейнера

`docker exec my-python-app pip install pandas` - выпорлнить команду внутри контейнера `exec` - `execute`

`docker commit my-python-app my-python-app-from-container:0.8` - создать образ на основе контейнера

`docker builder prune` - очистить кеш неиспользуемых контейнеров

`docker builder prune -a` - очистить кеш всех контейнеров `a` - `all`

`docker system prune` - удаляет неиспользуемые контейнеры и образы

`docker system prune -a` - удаляет вообще всё

`docker stats` - показать статистику по работающим контейнерам в режиме реального времени

`docker ps -aq` показать идентификаторы контейнеров

`docker ps -aq -f status=exited` - показать идентификаторы только завершенных контейнеров 

`docker ps -aq -f exited=130` показать идентификаторы контейнеров, завершенных с определённым кодом

`docker ps -q -f status=running` - показать идентификаторы работающих контейнеров

`docker ps -q -f status=paused` - показать идентификаторы контейнеров, поставленных на паузу

`docker ps -q -f status=created` - показать идентификаторы контейнеров, которые были созданы, но ещё не были запущены

`docker ps -q -f status=restarting` - показать идентификаторы контейнеров, которые были перезапущены

`docker stop $(docker ps -q)` - остановить все работающие контейнеры

`docker stop $(docker ps -qf status=running)` - остановить все работающие контейнеры

`docker start $(docker ps -qf status=exited)` - запустить все остановленные контейнеры

`docker pause $(docker ps -q)` остановить все запущенные контейнеры

`docker unpause $(docker ps -qf status=paused)` - восстановить работу приостановленных контейнеров

`docker stop $(docker ps -q)` - остановить запущенные контейнеры
 
`docker rm $(docker ps -qf status=exited)` - удалить остановленные контейнеры

`docker rm $(docker stop $(docker ps -q))` - остановить, а после удалить остановленные контейнеры

`docker images -aq` - вывести на экран идентификаторы образов

`docker images -f dangling=true` - вывести на экран идентификаторы висячих неиспользуемых образов

`docker rmi $(docker images -qf dangling=true)` - удалить висячие неиспользуемые образы

`docker rmi $(docker images -aq)` - удалить все образы

`docker container inspect [идентификатор или имя контейнера]` - посмотреть данные контейнера

`docker rm -f [идентификатор или имя контейнера]` - остановить, а после удалить контейнер

`docker run --name myweb -d -p 8000:80 nginx` - запустить контейнер и связать порт хоста с портом контейнера

`docker port myweb` - узнать имя порта

`docker run --name myweb -d -p 127.0.0.1:8000:80 nginx` - запустить контейнер и связать порты хоста с портом контейнера (для определённого IP адреса)

`docker exec -it flask-container bash` - запустить внутри контейнера myweb процесс bash

`exit` - выйти из контейнера

`cd /usr/share/nginx/html/` - приветственная страница в nginx

`docker run --name flaskweb -d -P flask-back` - запустить контейнер и автоматически назначить порт

`docker run --name flask-container -d -p 127.0.0.1:8008:4000 --rm  -v ${PWD}/src:/app flask-back` - создать том (volume) с зависимостью от пути на хосте

`docker run --name flask-container -d -p 127.0.0.1:8008:4000 --rm  -v web-files:/app flask-back` - создать именованный том

`docker volume ls` - отобразить список томов

`docker volume inspect web-files` - посмотреть информацию определённого тома

`docker volume rm web-files` - удалить том (используемый том уудалить нельзя)

`docker volume create web-files` - создать новый том после `docker run --name flask-container -d -p 127.0.0.1:8008:4000 --rm  -v web-files:/app flask-back` - связать контейнер с уже созданным томом по имени

`docker run --name flask-container -d -p 127.0.0.1:8008:4000 --rm  -v /app flask-back` - создать тои с автоматической генерацией имени

`docker rm -f -v flask-container` - удалить контейнер вместе с томом

`docker volume rm $(docker volume ls -q)` - удалить все тома

`docker network ls` - получить список всех существующих сетей

`docker network create dbnet` - создать сеть `dbnet`


### Docker-compose commands

`docker-compose up` - запустить `docker-compose.yml` + `-d` - для запуска в фоновом режиме

`docker compose stop` - остановить все контейнеры без удаления

`docker compose stop <service_name>` - остановить определённый контейнер без удаления

`docker compose down` - остановить все контейнеры с удалением сетей и других ресурсов, `-v` - удалит тома


FROM python:3.12-slim
RUN groupadd -r groupflask && useradd -r -g groupflask userflask
RUN pip install --upgrade pip
RUN pip install flask psycopg2-binary
WORKDIR /app
COPY /src/site.py .
EXPOSE 4000
USER userflask
CMD ["python", "site.py"]

# docker build . -t flask-back
# docker run --name flask-container -p 127.0.0.1:8008:5000 --rm -d flask-back
# docker run --name flask-container -d -P flask-back - запустить контейнер и автоматически назначить порт
# docker run --name flask-container -d -p 127.0.0.1:8008:4000 --rm  -v ${PWD}/src:/app flask-back - `-v` - создать том (volume)
# docker run --name flask-container -d -p 127.0.0.1:8008:4000 --rm  -v web-files:/app flask-back - создать именованный том
# VOLUME /app - создать том с автоматической генерацией имени остальные способы создания томов можно использовать только через консоль с флагом -v или чероез docker-compose.yml
# docker run --name flask-container --rm --network dbnet --link psgr:dbps -p 127.0.0.1:8008:4000 -v ${PWD}/src:/app flask-back - создать сеть dbnet и связать с контейнером psgr
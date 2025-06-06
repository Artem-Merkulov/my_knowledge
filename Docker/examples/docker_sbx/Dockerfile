FROM python:3.13-alpine
RUN pip install --upgrade pip
ENV PYTHONUNBUFFERED=1
WORKDIR /python-app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
# CMD ["python", "project.py"]
ENTRYPOINT ["python", "project.py"]
# docker build . -t python-app:0.7
# docker run --name python-app -it python-app:0.1
# docker start python-app
# docker stop python-app
# docker run --name my-python-app --rm python-app:0.6
# docker run --name my-python-app --rm -d python-app:0.7
# docker stop my-python-app
# docker logs my-python-app
# docker exec my-python-app pip install pandas
# docker commit my-python-app my-python-app-from-container:0.8
# docker builder prune
# docker builder prune -a очистить весь кеш
# docker system prune удаляет всё неиспользуемое
# docker system prune -a удаляет вообще всё
FROM python:latest

WORKDIR /app/api

COPY ./requirements.txt .

RUN pip install -r requirements.txt

EXPOSE 8000

ENV PYTHONPATH='${PYTHONPATH}:/app/api'

COPY . .

CMD [ "gunicorn", "main:app", "-b", "0.0.0.0:8000", "-w", "4", "-k", "uvicorn.workers.UvicornWorker" ]
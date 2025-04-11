FROM python:3.11-slim

RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

CMD [ "python3", "test_load.py" ]
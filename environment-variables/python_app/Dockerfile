FROM python:3.11-alpine

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=3000
ENV APP_NAME="My Python App"

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port $PORT"]

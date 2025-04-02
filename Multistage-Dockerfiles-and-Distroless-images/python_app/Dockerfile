FROM python:3.11-alpine AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM gcr.io/distroless/python3
WORKDIR /app
COPY --from=build /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY . .

ENV PORT=4000
ENV APP_NAME="My Python App"

CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "4000"]



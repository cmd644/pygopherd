FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m pygopherduser -u 99 -g 100

WORKDIR /app

COPY . .

COPY /conf/pygopherd-docker.conf /app/pygopherd.conf

RUN python3 -m pip install .

RUN chown -R 99:100 /app

USER pygopherduser

EXPOSE 70 1965

CMD ["pygopherd", "/app/pygopherd.conf"]

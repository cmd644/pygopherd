FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m pygopherduser

WORKDIR /app

COPY setup.py ./
RUN python3 -m pip install .

COPY . .

RUN chown -R pygopherduser:pygopherduser /app

USER pygopherduser

EXPOSE 70

CMD ["pygopherd", "--config", "/app/pygopherd.conf"]

FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m pygopherduser

WORKDIR /app

COPY requirements.txt setup.py pyproject.toml ./
RUN pip install --no-cache-dir --upgrade pip && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi && \
    if [ -f setup.py ]; then pip install .; fi

COPY . .

RUN chown -R pygopherduser:pygopherduser /app

USER pygopherduser

EXPOSE 70

CMD ["pygopherd", "--config", "/app/pygopherd.conf"]

FROM python:3.9-slim

# Metadane
LABEL org.opencontainers.image.authors="Jakub Kramek"
LABEL org.opencontainers.image.description="Aplikacja pogodowa z API"
LABEL org.opencontainers.image.version="1.0.0"


RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app


RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY templates/ templates/

RUN chown -R appuser:appuser /app

USER appuser

ENV PORT=5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:${PORT}/health || exit 1

EXPOSE ${PORT}

CMD ["python", "app.py"]
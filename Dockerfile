FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY service/ ./service/
RUN useradd --create-home --uid 10001 appuser
USER appuser

EXPOSE 8080
CMD ["gunicorn", "--workers=1", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]

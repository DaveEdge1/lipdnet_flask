FROM python:3.8-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Set environment variables
ENV FLASK_APP=flask_app.py
ENV FLASK_ENV=production
ENV PYTHONUNBUFFERED=1
ENV FLASK_APP_DIR=/app/

# Expose port (matches external access at http://64.23.255.172:3002)
EXPOSE 3002

# Run the application on port 3002
CMD ["flask", "run", "--host=0.0.0.0", "--port=3002"]

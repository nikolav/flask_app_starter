
# Python image
FROM python:3.12-slim

# Prevent Python from writing .pyc files and buffering stdout/stderr
ENV \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /home/app

# Install system deps (optional but useful for many libs)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .
RUN chmod +x wserver.sh

# Expose Flask port
EXPOSE 5000

# Run app
# CMD ["waitress-serve", "--host", "0.0.0.0", "--port", "5000", "flask_app:app"]
CMD ["./wserver.sh"]

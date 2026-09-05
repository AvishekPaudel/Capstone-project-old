FROM python:3.12-slim

WORKDIR /app

# Install system dependencies needed for dbus-python and others
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    libdbus-1-dev \
    libglib2.0-dev \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy app source
COPY . .

WORKDIR /app/src

EXPOSE 8000

CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]
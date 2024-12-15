# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libjpeg-dev \
    zlib1g-dev \
    libpng-dev \
    libgl1-mesa-glx \
    python3-dev \
    build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the application files into the container
COPY . /app

# Install Python dependencies globally
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Expose the HTTP ports
EXPOSE 5000

# Define environment variables
ENV FLASK_APP=app.py
ENV FLASK_ENV=production

# Start the Flask-SocketIO server
CMD ["python", "app.py"]

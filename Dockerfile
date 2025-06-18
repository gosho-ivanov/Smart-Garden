FROM arm32v7/python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential i2c-tools libgpiod-dev python3-libgpiod libffi-dev libssl-dev && \
    pip install --no-cache-dir \
      adafruit-blinka adafruit-circuitpython-dht \
      paho-mqtt requests && \
    pip uninstall -y RPi.GPIO && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY smartgarden.py ./

# Force Blinka to use Pi 5’s new GPIO system
ENV BLINKA_FORCEBOARD=RASPBERRY_PI_5 PYTHONUNBUFFERED=1

CMD ["python3", "smartgarden.py"]

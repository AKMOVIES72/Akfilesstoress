FROM python:3.10-slim-bookworm

WORKDIR /app

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git dos2unix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -U pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

RUN dos2unix start.sh && find . -name "*.py" -exec dos2unix {} +
RUN chmod +x start.sh

CMD ["bash", "start.sh"]

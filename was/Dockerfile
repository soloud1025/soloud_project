# Python 3.11 slim 이미지 기반
FROM python:3.11-slim

WORKDIR /app

# 시스템 패키지 준비 (빌드 도구 포함)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# requirements.txt 복사 후 패키지 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 앱 소스 복사
COPY . .

# Gunicorn 실행 (bootstrap.py 안의 app 객체 실행)
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:8000", "bootstrap:app"]


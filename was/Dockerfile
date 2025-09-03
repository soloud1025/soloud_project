# 1. Python 3.11 slim 이미지를 기반으로 (가볍고 보안 업데이트 빠름)
FROM python:3.11-slim

# 2. 환경변수 (Python 캐시, 버퍼링 최적화)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# 3. 작업 디렉토리 생성
WORKDIR /app

# 4. DB 드라이버 빌드에 필요한 OS 패키지 설치
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      default-libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

# 5. requirements.txt 복사 및 Python 의존성 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 6. 앱 소스 복사
COPY app.py ./

# 7. 컨테이너 포트 노출 (Flask/Gunicorn 포트)
EXPOSE 8000

# 8. Gunicorn으로 실행 (app.py 안의 app 객체 실행)
#    - worker 2개, 포트 8000 바인딩
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:8000", "app:app"]


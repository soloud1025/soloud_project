# 가벼운 파이썬 베이스
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# ── 필요한 시스템 패키지 최소화
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
    && rm -rf /var/lib/apt/lists/*

# ── 의존성 먼저 설치(캐시 활용)
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

# ── 웹 앱 소스 복사(단순 Flask 앱 가정)
COPY app.py /app/app.py

# ── 웹은 80 포트를 사용(ingress/web-svc 기준)
EXPOSE 80

# ── 루트(0)로 80포트 바인딩(실습 편의 우선)
#    - 보안 강화하려면 8080으로 변경 + Service targetPort=8080 으로 조정 권장
CMD ["sh", "-lc", "exec gunicorn -w 2 -b 0.0.0.0:80 app:app"]


# 베이스 이미지는 가볍고 보안 업데이트가 빠른 python:3.11-slim 사용
FROM python:3.11-slim

# ── [옵션] 런타임 최적화용 환경변수(파이썬 캐시 파일 제거 등)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# ── 작업 디렉토리 생성 (/app에 코드를 모아두고 여기서 실행)
WORKDIR /app

# ── (보안/속도) 필요한 시스템 패키지만 설치 후 제거
#    - build-essential: 일부 패키지 빌드 시 필요할 수 있음(없으면 제거 가능)
#    - netcat 등 디버그 도구는 실습에서만 필요하면 추가
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
    && rm -rf /var/lib/apt/lists/*

# ── requirements.txt를 먼저 복사 → 의존성 설치 레이어 캐시 최대화
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

# ── 앱 소스 복사 (여기서는 app.py만 있다고 가정)
COPY app.py /app/app.py

# ── (중요) 부트스트랩 파일은 'K8s ConfigMap'으로 주입됨
#    컨테이너 내부 경로: /opt/bootstrap/bootstrap.py 로 마운트됨 (Deployment에서 설정)
#    → 여기 Dockerfile에는 bootstrap.py를 포함하지 않음

# ── 컨테이너가 외부로 노출할 포트 (WAS는 8000)
EXPOSE 8000

# ── 실행 커맨드
#    - gunicorn: 프로덕션용 WSGI 서버
#    - 0.0.0.0:8000 으로 바인딩(컨테이너 외부 접근 허용)
#    - 'bootstrap:app' → ConfigMap으로 마운트된 bootstrap.py 안의 app 객체 실행
#    - 참고: PYTHONPATH=/opt/bootstrap 는 Deployment에서 환경변수로 설정
CMD ["sh", "-lc", "exec gunicorn -w 2 -b 0.0.0.0:8000 bootstrap:app"]

# dummy test 2025. 09. 02. (화) 04:19:05 UTC

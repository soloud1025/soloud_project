# Python 베이스 이미지
FROM python:3.11-slim

# 작업 디렉토리
WORKDIR /app

# 의존성 복사 & 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 앱 코드 복사
COPY . .

# 컨테이너 포트 (app.py 안에서 5001 쓰게 맞추면 됨)
EXPOSE 5001

# Flask 앱 실행
CMD ["python", "app.py"]


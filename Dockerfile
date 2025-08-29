FROM python:3.11-slim

# 작업 디렉토리
WORKDIR /app

# 종속성 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 소스 복사
COPY . .

# Flask 실행 (app.py 파일 기준, 필요 시 수정)
EXPOSE 5000
CMD ["python", "app.py"]

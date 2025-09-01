FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Web 서비스는 포트 5000 사용
EXPOSE 5000

CMD ["python", "app.py"]


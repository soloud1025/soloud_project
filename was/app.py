# was/app.py
from flask import Flask, jsonify

# Flask 애플리케이션 객체 생성
app = Flask(__name__)

# 간단한 라우트 예시
@app.route("/")
def index():
    return "Hello, this is the WAS service."

@app.route("/health")
def health():
    return jsonify({"status": "ok"})

# Gunicorn이 실행할 때는 bootstrap.py에서 app 객체를 가져옴
# 로컬 실행용 엔트리포인트
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)


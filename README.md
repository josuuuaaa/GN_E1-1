# GN_E1-1
Docker/Git/GitHub 개발 workstation 구축 미션

# 프로젝트 개요
Dockerfile 기반 웹 서버 실행 과제

# 폴더 구조
- app/: 웹 파일
- screenshots/: 실행 증거 이미지
- logs/: 명령 실행 결과

# 사용 환경
- Windows
- Docker Desktop
- Git
- GitHub

# 실행 방법
1. docker build -t my-web .
2. docker run -d -p 8080:80 --name my-web-container my-web
3. 브라우저에서 http://localhost:8080 접속

# 실행 결과
![브라우저 실행 결과](./screenshots/browser-success.png)

# 체크리스트
- [x] GitHub Repository 생성
- [x] 폴더 구조 생성
- [x] Dockerfile 작성
- [x] 이미지 빌드
- [x] 컨테이너 실행
- [x] 브라우저 접속 확인
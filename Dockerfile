# 기존 베이스 이미지로 NGINX 사용
FROM nginx:latest

# 내가 만든 정적 HTML 파일을 NGINX 기본 웹 루트에 복사
COPY app/index.html /usr/share/nginx/html/index.html

# 내가 만든 NGINX 설정 파일을 기본 설정 위치에 복사
COPY app/default.conf /etc/nginx/conf.d/default.conf

# 컨테이너가 사용할 포트 명시
EXPOSE 80
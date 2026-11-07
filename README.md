# GN_E1-1
Docker/Git/GitHub 개발 workstation 구축 미션

# 1. 프로젝트 개요
본 프로젝트의 목표는 Docker를 활용하여 애플리케이션 실행 환경을 컨테이너로 구성하고, 
터미널 환경에서 Docker 이미지 빌드, 컨테이너 실행, 포트 연결, 볼륨 관리, Git/GitHub 연동 과정을 수행하는 것이다.

## 1.1 검증 항목
- 로컬 개발 환경에서 Docker 명령어를 사용할 수 있는지 확인
- Dockerfile을 이용해 이미지를 빌드할 수 있는지 확인
- 컨테이너 실행 및 포트 매핑 동작 확인
- 볼륨을 이용한 데이터 보존 또는 파일 연결 방식 확인
- Git을 이용해 작업 내용을 버전 관리하고 GitHub에 업로드
- 수행 과정에서 발생한 문제를 기록하고 해결 과정 문서화

# 2. 실행환경
| 항목 | 내용 |
|---|---|
| OS | `Windows 11` |
| Shell | `PowerShell` |
| Terminal | `VS Code Terminal` |
| Docker version | `Docker version 29.9.2` |
| Git version | `git version 2.56.0.windows.4` |

## 2.1 폴더 구조
- app/: 웹 파일
- screenshots/: 실행 증거 이미지
- logs/: 명령 실행 결과

# 3. 수행 항목 체크리스트

- [x] Docker 설치 준비 
    - [x] Docker 학습 목적 확인
    - [x] Docker Desktop 설치 필요성 확인
    - [x] Windows 환경에서 Docker 사용 시 WSL2 필요성 확인
    - [x] Docker 설치 전 필수 Windows 기능 확인    
- [x] Windows 가상화 기능 설정
    - [x] Virtual Machine Platform 필요성 확인
    - [x] Virtual Machine Platform 관련 오류 원인 파악
    - [x] Windows 기능에서 Virtual Machine Platform 활성화 진행
- [x] WSL 설치
- [x] Linux 설치
- [x] Ubuntu 설치

- [x] Docker 실습
    - [x] Ubuntu 컨테이너 실행 
            - [x] attach/exec 실습
    - [x] Dockerfile 기반 커스텀 이미지 제작(nginx)          
        - [x] Dockerfile 작성
        - [x] 이미지 빌드
        - [x] 컨테이너 실행
        - [x] 브라우저 접속 확인
    - [x] Docker Volume 실습
        - [x] Docker Volume 생성
        - [x] Volume 안에 테스트 파일 생성
        - [x] 컨테이너 삭제 
        - [x] 같은 Volume을 새 컨테이너에 연결
        - [x] 새 컨테이너 에서 데이터유지 확인
        
- [x] 권한 실습

# 4. DockerFile Custom

- base image : `nginx:latest`(docker hub 공식 nginx 이미지)

| 구분 | 커스텀 포인트 | 적용 목적 |
|---|---|---|
| 베이스 이미지 | `FROM nginx:latest` | NGINX 공식 이미지를 기반으로 웹 서버 환경 구성 |
| 정적 웹 페이지 | `COPY app/index.html /usr/share/nginx/html/index.html` | 기본 웹 페이지를 사용자 정의 HTML 파일로 교체 |
| NGINX 설정 | `COPY app/default.conf /etc/nginx/conf.d/default.conf` | 사용자 정의 NGINX 설정을 적용하여 웹 서버 동작 구성 |
| 포트 설정 | `EXPOSE 80` | 컨테이너가 HTTP 서비스에 80번 포트를 사용함을 명시 |


# 실행 방법
1. docker build -t my-web .
2. docker run -d -p 8080:80 --name my-web-container my-web
3. 브라우저에서 http://localhost:8080 접속

# 실행 결과
- [포트 매핑 결과](./screenshot/port-mapping.png)
- [브라우저 실행 결과](./screenshot/browser-success.png)
- [Docker 운영/검증 로그](./logs/)
- [Docker Bind mount, Volume]()
- [Git 설정 및 GitHub/VSCode 연동]()




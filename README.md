# GN_E1-1
Docker/Git/GitHub 개발 workstation 구축 미션

# 1. 프로젝트 개요
본 프로젝트의 목표는 Docker를 활용하여 애플리케이션 실행 환경을 컨테이너로 구성하고, 
터미널 환경에서 Docker 이미지 빌드, 컨테이너 실행, 포트 연결, 볼륨 관리, Git/GitHub 연동 과정을 수행

# 2. 실행환경
| 항목 | 내용 |
|---|---|
| OS | `Windows 11` |
| Shell | `PowerShell` `bash` |
| Terminal | `VS Code Terminal` |
| Docker version | `Docker version 29.9.2` |
| Git version | `git version 2.56.0.windows.4` |

## 2.1 폴더 구조

```text
E1-1_GN_E1-1/
├── app/                       # NGINX 웹 서버 관련 파일
│   ├── default.conf           # NGINX 설정 파일
│   └── index.html             # 정적 웹 페이지
│
├── logs/                      # 명령어 실행 결과 및 로그
│   └── docker/                # Docker 명령어 실행 결과
│
├── permission-practice/       # Linux 파일 및 디렉터리 권한 실습
│   ├── sample_dir/            # 권한 실습용 디렉터리
│   └── sample.txt             # 권한 실습용 파일
│
├── screenshot/                # 실습 결과 증빙 이미지
│   ├── docker/                # Docker 실습
│   │   ├── custom container/  # 커스텀 이미지 빌드 및 실행
│   │   ├── ubuntu container/  # Ubuntu 컨테이너 실습
│   │   └── volume/            # Docker 볼륨 실습
│   ├── git/                   # Git 설정 및 저장소 연동
│   ├── permission/            # Linux 권한 변경 실습
│   └── trouble shooting/      # 오류 발생 및 해결 과정
│
├── Dockerfile                 # NGINX 커스텀 이미지 빌드 설정
└── README.md                  # 프로젝트 실습 내용 및 결과 문서
```


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
- [x] Ubuntu 설치 및 Linux 환경 구성
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


# 4. DockerFile Custom Image

| 구분 | 커스텀 포인트 | 적용 목적 |
|---|---|---|
| base image | `FROM nginx:latest` | NGINX 공식 이미지를 기반으로 웹 서버 환경 구성 |
| web page | `COPY app/index.html /usr/share/nginx/html/index.html` | 기본 웹 페이지를 사용자 정의 HTML 파일로 교체 |
| NGINX 설정 | `COPY app/default.conf /etc/nginx/conf.d/default.conf` | 사용자 정의 NGINX 설정을 적용하여 웹 서버 동작 구성 |
| port 설정 | `EXPOSE 80` | 컨테이너가 HTTP 서비스에 80번 포트를 사용함을 명시 |

# 5. Trouble Shooting

## 5.1 Docker 컨테이너 이름 중복 오류

**문제**

기존 컨테이너와 동일한 이름으로 신규 컨테이너 생성 시 `Conflict` 오류 발생

```bash
docker run -dit --name ubuntu ubuntu bash
```

**원인 가설 및 확인**

- 기존 `ubuntu` 컨테이너가 종료된 상태로 남아 있을 것으로 추정
- `docker ps -a` 명령어로 기존 컨테이너가 `Exited (0)` 상태임을 확인
- Docker는 종료된 컨테이너도 이름을 점유하므로 중복 이름 사용 불가

**해결 방법**

기존 컨테이너를 재사용하기 위해 다음 명령어 실행

```bash
docker start ubuntu
```

**검증 결과**

`docker ps` 명령어로 해당 컨테이너가 `Up` 상태로 정상 실행 중임을 확인

**증빙 자료**

- [오류 발생](./screenshot/trouble%20shooting/trouble01/트러블슈팅_문제.png)
- [오류 해결](./screenshot/trouble%20shooting/trouble01/트러블슈팅_해결.png)

## 5.2 Docker 이미지 이름 불일치 및 이미지 삭제 오류

**문제**

커스텀 NGINX 이미지 빌드 후 컨테이너 실행 시 `pull access denied` 오류 발생

```bash
docker run -d --name my-nginx-container -p 8080:80 my-nginx:1.0
```

**원인 가설 및 확인**

- 이미지 빌드 시 지정한 이름(`my-nginx-custom:1.0`)과 컨테이너 실행 시 사용한 이름(`my-nginx:1.0`)이 일치하지 않음
- `docker images` 명령어로 실제 이미지 이름 확인
- 이후 올바른 이미지 이름으로 실행했으나, `docker rmi` 명령어로 해당 이미지가 삭제되어 동일한 오류 발생

**해결 방법**

Dockerfile을 이용해 이미지를 다시 빌드하고, 정확한 이미지 이름으로 컨테이너 실행

```bash
docker build -t my-nginx-custom:1.0 .
docker run -d --name my-nginx-container -p 8080:80 my-nginx-custom:1.0
```

**검증 결과**

- `docker images` 명령어로 커스텀 이미지 존재 여부 확인
- 이미지 이름을 일치시키고 재빌드하면 컨테이너 실행이 가능한 상태로 복구됨
- 실제 컨테이너 정상 실행 여부는 `docker ps` 및 브라우저 접속으로 최종 확인 필요

**증빙 자료**

- [오류 발생](./screenshot/trouble%20shooting/trouble02/트러블%20슈팅2_문제.png)
- [이미지 빌드 및 확인](./screenshot/trouble%20shooting/trouble02/트러블%20슈팅2_해결.png)


# 6. 검증 항목 및 결과

| 검증 항목 | 검증 명령어 및 방법 | 확인 내용 | 증빙 자료 |
|---|---|---|---|
| Docker 설치 확인 | `docker --version` | Docker 버전 확인 | [버전 로그](./logs/docker/docker-version.txt) |
| Docker 환경 확인 | `docker info` | Docker 엔진 및 실행 환경 정보 확인 | [환경 정보 로그](./logs/docker/docker-info.txt) |
| Docker 이미지 확인 | `docker images` | 로컬 Docker 이미지 목록 확인 | [이미지 로그](./logs/docker/docker-images.txt) |
| 컨테이너 실행 확인 | `docker ps -a` | 컨테이너 생성 및 실행 상태 확인 | [컨테이너 로그](./logs/docker/docker-ps-a.txt) |
| 컨테이너 로그 확인 | `docker logs <컨테이너명>` | 컨테이너 실행 로그 확인 | [컨테이너 로그](./logs/docker/container-log.txt) |
| 커스텀 이미지 빌드 | `docker build` | NGINX 기반 커스텀 이미지 빌드 과정 확인 | [빌드 결과](./screenshot/docker/custom%20container/docker01_build.png) |
| 포트 매핑 확인 | `docker run -p` | 호스트와 컨테이너의 포트 연결 확인 | [포트 매핑 결과](./screenshot/docker/custom%20container/docker03_port-mapping.png) |
| 웹 페이지 접속 확인 | 브라우저에서 `localhost` 접속 | NGINX 정적 웹 페이지 표시 확인 | [브라우저 실행 결과](./screenshot/docker/custom%20container/brower-success.png) |
| Ubuntu 컨테이너 실습 | `docker run`, Linux 명령어 | Ubuntu 컨테이너 실행 및 명령어 수행 확인 | [컨테이너 실행 결과](./screenshot/docker/ubuntu%20container/ubuntu01_컨테이너실행.png), [컨테이너 진입후 명령어실행](./screenshot/docker/ubuntu%20container/ubuntu02_간단명령어수행결과.png) |
| Docker 볼륨 확인 | `docker volume`, 컨테이너 생성·삭제 | 볼륨 생성 및 컨테이너 삭제 후 데이터 유지 확인 | [볼륨 생성](./screenshot/docker/volume/volume01_생성%20및%20컨테이너%20연결.png), [데이터 유지 확인](./screenshot/docker/volume/volume03_컨테이너생성후%20데이터%20유지%20확인.png) |
| 컨테이너 접속 | `docker attach`, `docker exec` | 실행 중인 컨테이너 접속 및 명령어 수행 확인 | [attach 결과](./screenshot/docker/docker%20attach.png), [exec 결과](./screenshot/docker/docker%20exec.png) |
| Git 기본 설정 | `git config` | Git 사용자 정보 및 기본 브랜치 설정 확인 | [설정 결과](./screenshot/git/git01_사용자정보%20및%20기본%20브랜치%20설정.png) |
| Git 원격 저장소 연동 | `git remote -v` 등 | 로컬 저장소와 GitHub 원격 저장소 연동 확인 | [연동 결과](./screenshot/git/git03_저장소연결%20확인.png) ,[버전관리 명령어](./screenshot/git/git02_저장소%20연동.png) |
| Linux 파일 권한 변경 | `chmod`, `ls -l` | 파일 및 디렉터리 접근 권한 변경 확인 | [권한 변경 결과](./screenshot/permission/permission01_권한변경확인.png) |
| 오류 해결 검증 | 오류 발생 전후 실행 결과 비교 | Docker 실행 오류 및 해결 과정 확인 | [오류 사례 1](./screenshot/trouble%20shooting/trouble01/), [오류 사례 2](./screenshot/trouble%20shooting/trouble02/) |


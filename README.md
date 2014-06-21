# Docker 사용법

## 사전 환경설정

DB 마이그레이션이나 컨테이너 실행 할때 환경변수를 설정하면 해당 값이 포함되서 출력됩니다.
로컬 컴퓨터의 `.profile`, `.bashrc`등에 다음과 같이 운영환경의 환경변수를 설정합니다.

```bash
export RORLA_DATABASE_URL='mysql://username:passwd@10.0.2.2:5432/rorla_production'
export RORLA_SECRET_KEY_BASE='test'
```


## 이미지 build

```bash
$ bin/rake docker:build[태그이름]
```


## DB 마이그레이션

```bash
$ bin/rake docker:migrate[태그이름]
docker run -i -t --rm -e DATABASE_URL="mysql://username:passwd@10.0.2.2:5432/rorla_production" -e SECRET_KEY_BASE="test" seapy/rorla:v0.0.1 bundle exec db migrate
```

출력된 명령어를 운영서버에서 붙여넣기


## 컨테이너 실행

```bash
$ bin/rake docker:start[태그이름]
docker run --name 컨테이너이름 -e DATABASE_URL="mysql://username:passwd@10.0.2.2:5432/rorla_production" -e SECRET_KEY_BASE="test" -d -p 80:80 seapy/rorla:태그이름
```

출력된 명령어를 운영서버에서 붙여넣기


## 참고

- 현재 Docker 빌드에 사용되는 소스는 Dockerfile이 실행되는 컴퓨터의 소스코드를 업로드 하는 방식입니다. 나중에는 git 소스를 이용하도록 변경해야겠죠? 
- 김대권님의 도커 이해하기 및 배포 : https://www.facebook.com/groups/rubyonrailskorea/permalink/658498414219259
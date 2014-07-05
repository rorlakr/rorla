# 개발환경 설정시 유의

## capybara-webkit

`capybara-webkit` gem 설치를 위해서는 관련 라이브러리가 필요하다.

[capybara-webkit 설치하기 문서](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit)

맥에서는 다음과 같이 설치

```shell
$ brew update
$ brew install qt
```

# Docker 이용해서 Production 환경 로컬에서 확인하기

소스를 Pull Request 하기전에 로컬에서 운영환경 테스트를 해보는것이 좋습니다.

## 1. 환경변수 설정

`.env` 파일 생성후 다음과 같이 추가하고 `source .env`를 실행하여 환경변수 설정. 레일스 4 이후에는 환경변수의 적용을 위해 `bin/spring stop` 실행 필수.

```bash
# .env
export RORLA_SECRET_KEY_BASE=암호화키
export MANDRILL_USERNAME=email@email.com
export MANDRILL_APIKEY=password
export RORLA_HOST=localhost
```

메일 보내는것을 확인해야 하는경우 `MANDRILL_USERNAME`, `MANDRILL_APIKEY`, `RORLA_HOST`를 본인의 환경에 맞게 설정. 메일 보내는것이 중요하지 않으면 아무값이나 입력.

## 2. 로컬에서 Docker 이미지 빌드

```bash
$ bin/rake dockera:build
```

## 3. MySQL DB 서버 연결 

### 3.1 기존 MySQL 컨테이너가 없는 경우

실행중인 MySQL 컨테이너가 있고 DB가 생성되있으면 `3.2`로 이동

#### 3.1.1 MySQL 컨테이너 실행

```bash
docker run --name mysql -e MYSQL_USERNAME="admin" -e MYSQL_PASS="yourpassword" -d tutum/mysql
```

계정 정보는 아무렇게나 입력해도 된다. docker link로 알아서 여기에 입력한 계정정보를 사용.

아무것도 할것이 없다.

#### 3.1.2 DB 생성 및 초기화

```bash
$ bin/rake dockera:db:create
```

출력된 명령어를 운영서버에서 붙여넣기

```bash
$ bin/rake dockera:db:setup
```

출력된 명령어를 운영서버에서 붙여넣기

### 3.2 DB 마이그레이션

```bash
$ bin/rake dockera:db:migrate
```

출력된 명령어를 운영서버에서 붙여넣기

## 4. 볼륨 컨테이너 연결(기존 볼륨 컨테이너가 없는 경우)

실행중인 볼륨 컨테이너가 있으면 현재 섹션 무시

```bash
$ docker run -v /app/public/uploads --name rorla_uploads busybox
```

## 5. 컨테이너 실행

```bash
$ bin/rake dockera:con:start
```

출력된 명령어를 운영서버에서 붙여넣기


## 참고

- 현재 Docker 빌드에 사용되는 소스는 Dockerfile이 실행되는 컴퓨터의 소스코드를 업로드 하는 방식입니다. 나중에는 git 소스를 이용하도록 변경해야겠죠? 
- MySQL Docker를 연결하는 방식으로는 어플리케이션서버와 MySQL 서버가 같은곳에 있어야 되는것으로 보입니다. 추후 좋은 방법이 있을거라 생각합니다.
- 김대권님의 도커 이해하기 및 배포 : https://www.facebook.com/groups/rubyonrailskorea/permalink/658498414219259
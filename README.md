# Docker 사용법

## 사전 환경설정

DB 마이그레이션이나 컨테이너 실행 할때 환경변수를 설정하면 해당 값이 포함되서 출력됩니다.
로컬 컴퓨터의 `.profile`, `.bashrc`등에 다음과 같이 운영환경의 환경변수를 설정합니다.

```bash
export RORLA_SECRET_KEY_BASE='test'
```


## 이미지 build

```bash
$ bin/rake docker:build[태그이름]
```

## MySQL DB 서버 구동

MySQL DB는 Docker 공식 저장소의 것을 사용하고 어플리케이션에서 MySQL 컨테이너의 접근은 [Docker Link](https://docs.docker.com/userguide/dockerlinks/)를 이용합니다.

MySQL 컨테이너 실행

```bash
docker run --name mysql -e MYSQL_ROOT_PASSWORD=yourpassword -d mysql
```

MySQL 컨테이너와 어플리케이션 컨테이너의 연결

```bash
docker run --link mysql:mysql 블라블라
```

### 이게 동작하는 방식

어플리케이션 컨테이너를 실행할때 MySQL 컨테이너를 link 옵션으로 연결하는경우 어플리케이션 컨테이너에 다음과 같은 환경변수가 설정된다. 앱은 이 환경변수를 사용하면 된다. 자세한 내용은 [Docker Link](https://docs.docker.com/userguide/dockerlinks/) 참고.

설정되는 환경변수 목록. `????` 문자열은 link 할때 `:` 뒷부분의 이름에 따라달라진다.

```bash
????_PORT_3306_TCP=tcp://172.17.0.2:3306
????_NAME=/sharp_franklin/mysql2
????_PORT_3306_TCP_ADDR=172.17.0.2
????_PORT_3306_TCP_PORT=3306
????_ENV_MYSQL_ROOT_PASSWORD=yourpassword
????_PORT_3306_TCP_PROTO=tcp
????_PORT=tcp://172.17.0.2:3306
```

### DB 생성

```bash
$ docker run -i -t --rm --link mysql:mysql -e SECRET_KEY_BASE="test" rorla/rorla:태그이름 bundle exec rake db:create
```

## DB 마이그레이션

```bash
$ bin/rake docker:migrate[태그이름]
$ docker run -i -t --rm --link mysql:mysql -e SECRET_KEY_BASE="test" rorla/rorla:태그이름 bundle exec rake db:migrate
```

### DB 시드 데이터 적용

```bash
$ docker run -i -t --rm --link mysql:mysql -e SECRET_KEY_BASE="test" rorla/rorla:태그이름 bundle exec rake db:seed
```

출력된 명령어를 운영서버에서 붙여넣기


## 컨테이너 실행

```bash
$ bin/rake docker:start[태그이름]
$ docker run --name 컨테이너이름 --link mysql:mysql -e SECRET_KEY_BASE="test" -d -p 80:80 rorla/rorla:태그이름
```

출력된 명령어를 운영서버에서 붙여넣기


## 참고

- 현재 Docker 빌드에 사용되는 소스는 Dockerfile이 실행되는 컴퓨터의 소스코드를 업로드 하는 방식입니다. 나중에는 git 소스를 이용하도록 변경해야겠죠? 
- MySQL Docker를 연결하는 방식으로는 어플리케이션서버와 MySQL 서버가 같은곳에 있어야 되는것으로 보입니다. 추후 좋은 방법이 있을거라 생각합니다.
- 김대권님의 도커 이해하기 및 배포 : https://www.facebook.com/groups/rubyonrailskorea/permalink/658498414219259
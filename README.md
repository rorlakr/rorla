# Capistrano 3를 이용한 배포

: `deploy` 브랜치에 `Capistrano 3` 배포 환경을 설정해 두었습니다.

### 0. 배포 전에 설정해야 할 것

* 배포 서버의 IP와 도메인명을 확인한다.
* 배포 서버에는 배포용 계정 `deployer`를 생성하고 `admin` 그룹에 할당해 준다.

  ```bash
  $ sudo adduser deployer
  $ sudo addgroup admin
  $ sudo usermod -a -G admin deployer
  ```

* 방금 생성한 `deployer` 계정에 대한 `nopasswd` 설정을 위해 아래와 같이 명령을 실행한다.

  ```bash
  $ sudo visudo
  ```

* 아래와 내용을 하단에 추가해 준다

  ```
  deployer ALL=(ALL) NOPASSWD: ALL
  ```

* 배포 서버의 `/etc/nginx/nginx.conf` 파일을 sudo 권한으로 열고 첫줄에 있는 `user` 값을 `deployer`로 변경한다.
* 배포 서버에 환경변수를 지정한다.

  ```bash
  $ sudo vi /etc/environment
  ```
  그리고 아래의 내용을 추가해 준다.
  ```
  MANDRILL_USERNAME=email@email.com
  MANDRILL_APIKEY=password
  MYSQL_PORT_3306_TCP_ADDR=localhost
  MYSQL_PORT_3306_TCP_PORT=3306
  MYSQL_ENV_MYSQL_USERNAME=deployer
  MYSQL_ENV_MYSQL_PASS=<deployer계정의 암호>
  ```
  > **주의** : https://mandrillapp.com/ 서비스를 이용하여 메일을 발송하기 위해서 해당 웹사이트를 방문하여 가입한 후 자신의 APIKEY 값을 `MANDRILL_APIKEY` 값으로 지정한다.

* 배포 서버를 재부팅한다.

  ```bash
  $ sudo reboot
  ```

* **config/deploy/production.rb** 파일을 열고 도메인이름을 배포 서버의 것으로 변경한다.
* **deploy.rb** 파일을 열고 6번째 줄의 `:repo_url`을 원하는 저장소 주소로 변경한다.



### 1. 배포 1단계

```bash
$ cap production setup
```

### 2. 배포 2단계

```bash
$ cap production deploy
```




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
export RORLA_LOGENTRIES_TOKEN=key
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

먼저 볼륨 컨테이너를 생성한다.

```bash
$ docker run -d -v /var/lib/mysql --name rorla_mysql_data busybox
```

이렇게 하면 호스트의 어딘가 저장되지만 볼륨 컨테이너 삭제시 데이터도 삭제 되므로 호스트의 특정 폴더와 연결해도 된다.

```bash
$ docker run -d -v /data/mysql:/var/lib/mysql --name rorla_mysql_data busybox
```

이제 MySQL을 실행하자.

```bash

$ docker run --name mysql --volumes-from rorla_mysql_data -e MYSQL_USERNAME="admin" -e MYSQL_PASS="yourpassword" -d -p 3306:3306 tutum/mysql
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
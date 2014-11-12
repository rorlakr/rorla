# Capistrano 3를 이용한 배포

: `deploy` 브랜치에 `Capistrano 3` 배포 환경을 설정해 두었습니다.

### 0. 배포 전에 설정해야 할 것

* 배포 서버의 IP와 도메인명을 확인한다.

  > **노트** : **Virtual Box**에 배포용 서버를 준비하는 과정은 http://rorla.rorlab.org/rblogs/24 와 http://rorla.rorlab.org/rblogs/24 를 참고한다.

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

  아래와 내용을 하단에 추가해 준다

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


# Fig 이용해서 Production 환경 로컬에서 확인하기

소스를 Pull Request 하기전에 로컬에서 운영환경 테스트를 해보는것이 좋습니다.

## Fig 설치하기

아래 실행 명령어는 참고만하고 [Fig 설치하기](http://www.fig.sh/install.html) 문서를 참고해서 최신 버전으로 설치하자

```shell
$ curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig
```

<<<<<<< HEAD
## 3. MySQL DB 서버 연결
=======
설치후 `fig --version` 명령어 결과를 확인
>>>>>>> master

## Fig 사용

아래 명령어는 최초 DB 설정관련 명령어로 이미 해당 컨테이너가 존재하면 입력하지 않아도됨

```
$ fig run --rm web bundle exec rake db:create
$ fig run --rm web bundle exec rake db:migrate
$ fig run --rm web bundle exec rake db:seed
```

create 첫번째 하면 오류나는데 한번더 실행하자

관련된 컨테이너들을 실행. `--no-recreate` 옵션이 없으면 위에서 설정했던 DB 변경 사항이 반영되지 않을수 있으므로 주의

```
$ fig up --no-recreate
```

메일 보내는것을 확인해야 하는경우 `fig.yml` 파일에서 `MANDRILL_USERNAME`, `MANDRILL_APIKEY`, `RORLA_HOST`를 본인의 환경에 맞게 설정. 메일 보내는것이 중요하지 않으면 아무값이나 입력.

실행중인 컨테이너들을 종료하기

```
$ fig stop
```

원래는 `ctrl + c` 누르면 종료되야 되는거 같은데 `--no-recreate` 옵션 때문인지 별도로 종료 명령을 입력해야한다.


## 참고

- 현재 Docker 빌드에 사용되는 소스는 Dockerfile이 실행되는 컴퓨터의 소스코드를 업로드 하는 방식입니다. 나중에는 git 소스를 이용하도록 변경해야겠죠?
- MySQL Docker를 연결하는 방식으로는 어플리케이션서버와 MySQL 서버가 같은곳에 있어야 되는것으로 보입니다. 추후 좋은 방법이 있을거라 생각합니다.
- 김대권님의 도커 이해하기 및 배포 : https://www.facebook.com/groups/rubyonrailskorea/permalink/658498414219259
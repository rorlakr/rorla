# 용어집

2016-06-14 작업시작
2016-06-?? 일차작업 종료

`Glossary` Modeling

```shell  
$ rails g scaffold Glossary user:references term:string word_class:integer idiomatic:boolean memo:text
```

Attributes:

 - term (용어)
 - word_class (품사)
 - idiomatic (단어/숙어)
 - memo:text (메모)


http://www.oxforddictionaries.com/words/word-classes-or-parts-of-speech

noun(명사), pronoun(대명사), adverb(부사), verb(동사), adjective(형용사), preposition(전치사), conjunction(접속사), determiner(관형사), exclamation(감탄사)

noun

verb

adjective

adverb

pronoun

preposition

conjunction

determiner

exclamation




`GlossaryDefinition` Model

```sh
$ rails g resource GlossaryDefinition glossary:references user:references definition sentence:text
```


Attributes:

 - glossary_id : FK  (용어집)
 - user_id : FK (작성자)
 - definition:string (뜻)
 - sentence:text (예문)


One-to-many association

```ruby
class Glossary < ActiveRecord::Base
  has_many : glossary_definitions, dependent: :destroy
  belong_to :user
end

class GlossaryDefinition < AcgtiveRecord::Base
  belongs_to :glossary
  belongs_to :user
end
```

[레일스튜토리얼 용어집](http://bit.ly/railstutorial_glossary)을 `CSV` 포맷으로 다운로드 받아 `glossaries`, `glossary_definitions` 테이블로 임포트하는 rake task를 작성했음.

`lib/tasks/import_glossary.rake`

```ruby
require 'csv'
desc "RailsTutorial 용어집 CSV 파일을 glossaries 와 glossary_definitions 테이블로 추가한다."
task :import_glossary, [:filename] => [:environment] do |t, args|
    user = User.first
    CSV.foreach( args[:filename], :headers => true) do |row|
      glossary = Glossary.create!(term: row[0], user: user, memo: row[2] )
      glossary.glossary_definitions.create!( definition: row[1], user: user )
    end
end
```


```sh
$ rake import_glossary[~/railstutorial_glossary_main.csv]
```



# 뉴스레터

테이블명 : newsletters
테이블속성 :

* published_at 발행일
* title 뉴스타이틀
* greeting 인사말
* editor 편집자
* poster 포스터 이미지

---

테이블명 : articles
테이블속성 :

* newsletter:references
* section: %w[행사안내 읽을꺼리 볼꺼리 신간소개 채용공고 업체홍보]
* title 제목
* content 내용
* poster 포스터 이미지
* reference_url 참고 URL
* reporter 제보자

---

newsletter has_many :articles

---


* events행사안내

  * 행사명
  * 행사정보
  * 제보자
  * URL

* 읽은꺼리
  * 제목
  * 내용요약
  * 제보자
  * URL

* 볼꺼리
  * 제목
  * 내용요약
  * 제보자
  * URL

* 신간소개
  * 책이름
  * 내용요약
  * 제보자
  * URL

* 채용공고
  * 업체명
  * 채용안내
  * 제보자
  * URL
  *

* 업체홍보
  * 업체명
  * 홍보내용
  * 제보자
  * URL

activate-power-mode 패키지입니다.
재밌군요. ㅎㅎㅎ

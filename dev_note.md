# 용어집 기능 추가

2016-06-14 작업시작
2016-06-?? 일차작업 종료

`Glossary` Modeling

```sh
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

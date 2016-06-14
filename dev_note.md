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

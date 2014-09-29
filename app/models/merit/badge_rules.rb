# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # grant_on 'users/registrations#create', badge: 'just-registered', model_name: 'User'
      grant_on 'posts#create', badge: '첫 걸음마', model_name: 'Post' do |post|
        post.writer.posts.count == 1
      end
      grant_on 'posts#create', badge: '재잘거리다', model_name: 'Post' do |post|
        post.writer.posts.count == 30
      end
      grant_on 'posts#create', badge: '글쓰기에 중독되다', model_name: 'Post' do |post|
        post.writer.posts.count == 100
      end
      grant_on 'questions#create', badge: '알고싶다', model_name: 'Question' do |question|
        question.user.questions.count == 1
      end
      grant_on 'questions#create', badge: '호기심이 많은', model_name: 'Question' do |question|
        question.user.questions.count == 10
      end
      grant_on 'questions#create', badge: '소크라테스', model_name: 'Question' do |question|
        question.user.questions.count == 30
      end
      grant_on 'answers#create', badge: '괜찮은 응대자', model_name: 'Answer' do |answer|
        answer.user.answers.count == 1
      end
      grant_on 'answers#create', badge: '좋은 해답자', model_name: 'Answer' do |answer|
        answer.user.answers.count == 10
      end
      grant_on 'answers#create', badge: '위대한 인도자', model_name: 'Answer' do |answer|
        answer.user.answers.count == 30
      end
      grant_on 'rblogs#create', badge: '지식 공유의 참맛', model_name: 'Rblog' do |rblog|
        rblog.writer.rblogs.count == 1
      end
      grant_on 'rblogs#create', badge: '지식 공유의 기쁨', model_name: 'Rblog' do |rblog|
        rblog.writer.rblogs.count == 5
      end
      grant_on 'rblogs#create', badge: '지식 공유의 참사랑', model_name: 'Rblog' do |rblog|
        rblog.writer.rblogs.count == 10
      end
      grant_on 'codebanks#create', badge: '신규계좌 개설', model_name: 'Answer' do |codebank|
        codebank.writer.codebanks.count == 1
      end
      grant_on 'codebanks#create', badge: '실버계좌', model_name: 'Answer' do |codebank|
        codebank.writer.codebanks.count == 20
      end
      grant_on 'codebanks#create', badge: '골드계좌', model_name: 'Answer' do |codebank|
        codebank.writer.codebanks.count == 50
      end

      # grant_on 'comments#create', badge: '호기심이 많은', model_name: 'Question' do |question|
      #   question.user.comments.count == 2
      # end
      # grant_on 'comments#create', badge: '소크라테스', model_name: 'Question' do |question|
      #   question.user.comments.count == 3
      # end
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # grant_on 'users#create', badge: 'just-registered', to: :itself

      # If it has 10 comments, grant commenter-10 badge
      # grant_on 'comments#create', badge: 'commenter', level: 10 do |comment|
      #   comment.user.comments.count == 10
      # end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', badge: 'relevant-commenter',
      #   to: :user do |comment|
      #
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', badge: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end
    end
  end
end

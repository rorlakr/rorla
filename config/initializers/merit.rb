# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
end

# Merit::Badge.create!(
#   id: 1,
#   name: "just-registered",
#   description: "Welcome to rorla!!",
#   custom_fields: { difficulty: :silver }
# )


# Create application badges (uses https://github.com/norman/ambry)
badge_id = 0
[{
  id: (badge_id = badge_id+1),
  name: 'just-registered',
  description: "Welcome to rorla!!",
  custom_fields: { difficulty: :bronze, image_url: 'http://dummyimage.com/100x100/965a38/fff&text=' }  
}, {
  id: (badge_id = badge_id+1),
  name: '첫 걸음마',
  description: "이제 막 포스팅을 시작한 유저",
  custom_fields: { difficulty: :bronze, image_url: 'http://dummyimage.com/100x100/965a38/fff&text=' }  
}, {
  id: (badge_id = badge_id+1),
  name: '재잘거리다',
  description: "총 포스팅이 30개 이상인 글쓰기에 흥미를 느끼는 유저",
  custom_fields: { difficulty: :silver, image_url: 'http://dummyimage.com/100x100/A8A8A8/fff&text=' }  
}, {
  id: (badge_id = badge_id+1),
  name: '글쓰기에 중독되다',
  description: "총 포스팅이 100개 이상인 글쓰기에 중독된 유저",
  custom_fields: { difficulty: :gold, image_url: 'http://dummyimage.com/100x100/C98910/fff&text=' }  
}, {
  id: (badge_id = badge_id+1),
  name: '알고싶다',
  description: "질문을 처음해보는 유저",
  custom_fields: { difficulty: :bronze, image_url: 'http://dummyimage.com/100x100/965a38/fff&text=' }  
}, {
  id: (badge_id = badge_id+1),
  name: '호기심이 많은',
  description: "총 질문이 10개 이상인 호기심이 많은 유저",
  custom_fields: { difficulty: :silver, image_url: 'http://dummyimage.com/100x100/A8A8A8/fff&text=' }  
}, {
  id: (badge_id = badge_id+1),
  name: '소크라테스',
  description: "총 질문이 30개 이상인 소크라테스 같은 유저",
  custom_fields: { difficulty: :gold, image_url: 'http://dummyimage.com/100x100/C98910/fff&text=' }  
}, {
  id: (badge_id = badge_id+1),
  name: '괜찮은 응대자',
  description: "자네 꽤나 괜찮은 대답을 할 기미가 보이는군",
  custom_fields: { difficulty: :bronze, image_url: 'http://dummyimage.com/100x100/965a38/fff&text=' }  
}, {
  id: (badge_id = badge_id+1),
  name: '좋은 해답자',
  description: "총 응답이 10개 이상인 무지한 유저들 사이의 좋은 해답자",
  custom_fields: { difficulty: :silver, image_url: 'http://dummyimage.com/100x100/A8A8A8/fff&text=' }  
}, {
  id: (badge_id = badge_id+1),
  name: '위대한 인도자',
  description: "총 응답이 30개 이상인 우리들의 위대한 인도자",
  custom_fields: { difficulty: :gold, image_url: 'http://dummyimage.com/100x100/C98910/fff&text=' }  
}].each do |attrs|
  Merit::Badge.create! attrs
end

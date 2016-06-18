class WelcomeController < ApplicationController
  def index
    set_meta_tags og: {
      title: "Homepage",
      description: "RORLab에 오신 것을 환영합니다. Ruby on Rails Korean Study Group with free offline lectures",
      url: root_url
    }, title: 'Homepage'
  end
end

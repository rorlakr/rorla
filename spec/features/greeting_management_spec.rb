require 'spec_helper'

Capybara.javascript_driver = :webkit

feature 'Greeting', js: true do
  background do
    pending "TODO"
    visit '/'
    click_link 'Bulletins'
    click_link '가입인사'
  end

  scenario 'has a Title' do
    within('.row') do
      expect(page).to have_content('가입인사')
    end  
  end

end

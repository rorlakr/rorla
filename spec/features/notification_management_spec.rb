require 'spec_helper'

Capybara.javascript_driver = :webkit

feature 'Notificaiton', js: true do
  background do
    visit '/'
    click_link 'Bulletins'
    click_link '공지사항'
  end

  scenario 'has a Title' do
    within('.row') do
      expect(page).to have_content('공지사항')
    end  
  end

end

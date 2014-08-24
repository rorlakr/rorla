require 'spec_helper'

Capybara.javascript_driver = :webkit

feature 'News', js: true do
  background do
    visit '/'
    click_link 'Bulletins'
    click_link '새소식'
  end

  scenario 'has a Title' do
    within('.row') do
      expect(page).to have_content('새소식')
    end  
  end
end

require 'spec_helper'

Capybara.javascript_driver = :webkit

feature 'Gallery', js: true do
  background do
    visit '/'
    click_link 'Bulletins'
    click_link '갤러리'
  end

  scenario 'has a Title' do
    within('.row') do
      expect(page).to have_content('갤러리')
    end  
  end

end

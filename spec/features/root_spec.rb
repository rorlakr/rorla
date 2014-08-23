require 'spec_helper'

Capybara.javascript_driver = :webkit

feature 'Root Page', js: true do

  scenario 'Fixed navbar' do
    visit '/'

    expect(page).to have_content('Home')
    expect(page).to have_content('Plaza')
    expect(page).to have_content('Bulletins')
    expect(page).to have_content('Favlinks')
    expect(page).to have_content('Sign in')
    expect(page).to have_content('Sign up')

    click_link 'Bulletins'

    expect(page).to have_content('공지사항')
    expect(page).to have_content('새소식')
    expect(page).to have_content('가입인사')
    expect(page).to have_content('Q&A')
  end
end

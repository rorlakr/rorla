require 'spec_helper'

feature 'rBlog 프로세스 테스트', js: true, focus: true do
  # pending "작성 중..."
  given(:user) { create(:user) }

  scenario 'editor 권한이 있는 사용자만 글을 작성할 수 있다.' do
    login_as(user)
    visit new_rblog_path
    # show_page
    expect(page).to have_content('rBlog 작성')
    fill_in "글제목", with: "title"
    #fill_in "글내용", with: "content"
    find(:xpath,'//textarea[@id="wmd-input-content"]').set "content"
    click_button I18n.t("helpers.submit.create")
    expect(page).to have_content('Rblog was successfully created.')
    show_page
  end


end

require 'spec_helper'

# js: true 옵션은 Selenium을 사용하기 위한 것으로 자바스크립트를 테스트할 수 있게 해 준다.
feature '즐겨찾기를 관리한다.', js: true do

  # feature 스펙에서는 let() => given(), before() => background()를 사용한다.
  given(:user) { create(:user) }

  background(:each) do
    create(
      :favlink,
      title: 'Official Website of ROR Lab.',
      description: '...',
      linkurl: "http://rorlab.org",
      writer: user
    )
    visit favlinks_path
  end

  scenario 'favlinks#index 페이지를 본다.' do
    login_as(user)
    expect(page).to have_content('Add a Favlink')
  end

  scenario '로그인하지 않으면 My Favlinks 링크를 볼 수 없다.' do
    expect(page).to_not have_content('My Favlinks')
  end

  scenario '즐겨찾기를 등록한다.' do
    # pending "더 이상 테스트하지 않음..."
    # replace login_as(user) with this sign_in_with macro
    sign_in_with(user)
    visit favlinks_path

    # save_and_open_page
    click_link "Add a Favlink"
    fill_in "Title", with: "ROR Lab."
    fill_in "Linkurl", with: "http://rorlab.org"
    click_button I18n.t("helpers.submit.create")
    expect(page).to have_content('Favlink was successfully created.')
  end

  context '태그 관련 테스트' do
    scenario '> 새로운 태그를 등록한다.'do
      sign_in_with(user)
      visit new_favlink_path
      fill_in "Title", with: "ROR Lab."
      fill_in "Linkurl", with: "http://rorlab.org"
      fill_in "Tag list", with: "tag1, tag2"

      # save_and_open_page => page를 브라우저로 보여 줌.(css 와 js는 제외)
      # page.save_screenshot('tmp/screenshot.png')  # 특정 위치에 이지지를 보여 줌.

      # save_and_open_page에서 css와 js를 포함. local server가 실행되어야 한다.
      # show_page

      click_button I18n.t("helpers.submit.create")

      # show_page
      expect(page).to have_content('Favlink was successfully created.')
      expect(find('.tag')).to have_content('tag1')
      expect(find('.tag')).to have_content('tag2')
    end
  end
end

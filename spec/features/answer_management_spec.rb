require 'spec_helper'

Capybara.javascript_driver = :webkit

feature '답변을 관리한다.', js: true do
  let(:questioner) { create(:user) }
  let(:answerer) { create(:user) }
  let(:question) { create(:question, user: questioner) }

  background do
    create(:answer,
      question: question,
      content: 'It is simple',
      user: answerer
    )

    login_as(answerer)

    visit '/questions'
    click_link 'Question Title'
  end

  scenario '답변 목록을 본다.' do
    expect(page).to have_content('It is simple')
  end

  scenario '답변 등록한다.' do
    click_link '답변등록'

    fill_in '답변', with: '첫번째 답변'

    click_button '등록'

    expect(page).to have_content('첫번째 답변')
  end

  scenario '내용을 입력하지 않아 등록에 실패한다.' do
    click_link '답변등록'

    fill_in '답변', with: ' '

    click_button '등록'

    expect(page).to have_content('답변에 내용을 입력해 주세요')
  end

  scenario '답변을 수정한다.' do
    click_link 'It is simple'

    click_link '수정'

    fill_in '답변', with: '!!! Why not !!!'

    click_button '갱신'

    expect(page).to have_content('!!! Why not !!!')
  end

  scenario '내용을 입력하지 않아 수정에 실패한다.' do
    click_link 'It is simple'

    click_link '수정'

    fill_in '답변', with: ' '

    click_button '갱신'

    expect(page).to have_content('답변에 내용을 입력해 주세요')
  end

  scenario '답변을 삭제한다.' do
    click_link 'It is simple'

    page.driver.accept_js_confirms!

    click_link '삭제'

    expect(page).to_not have_content('It is simple')
  end

  scenario '답변을 삭제하지 않는다.' do
    click_link 'It is simple'

    page.driver.dismiss_js_confirms!

    click_link '삭제'

    expect(page).to have_content('It is simple')
  end

end

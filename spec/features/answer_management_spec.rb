require 'spec_helper'

Capybara.javascript_driver = :webkit

feature '답변을 관리한다.', js: true do
  background do
    @user = create(:user, email: 'user@example.com', password: 'testtest', id: 1)
    @user.confirm!
    @user.save

    create(:question,
          id: 1,
          title: 'I have Question',
          content: 'If you..',
          user_id: @user.id)

    create(:answer,
          id: 1,
          content: 'If not!',
          question_id: 1)

    login_as(@user)

    visit '/'
    click_link 'Bulletins'
    click_link 'Q&A'    
    click_link 'I have Question'
  end

  scenario '답변 목록을 본다.' do
    expect(page).to have_content('If not!')
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
    click_link 'If not!'

    click_link '수정'

    fill_in '답변', with: '!!! Why not !!!'

    click_button '갱신'

    expect(page).to have_content('!!! Why not !!!')
  end

  scenario '내용을 입력하지 않아 수정에 실패한다.' do
    click_link 'If not!'

    click_link '수정'

    fill_in '답변', with: ' '

    click_button '갱신'

    expect(page).to have_content('답변에 내용을 입력해 주세요')
  end

  scenario '답변을 삭제한다.' do
    click_link 'If not!'

    page.driver.accept_js_confirms!

    click_link '삭제'

    expect(page).to_not have_content('If not!')
  end

  scenario '질문을 삭제하지 않는다.' do
    click_link 'If not!'

    page.driver.dismiss_js_confirms!

    click_link '삭제'

    expect(page).to have_content('If not!')
  end

end

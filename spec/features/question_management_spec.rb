require 'spec_helper'

Capybara.javascript_driver = :webkit

feature '질문을 관리한다.', js: true do
  background(:each) do
    @user = create(:user, email: 'user111@example.com', password: 'testtest')
    @user.confirm!
    @user.save

    create(:question,
          id: 1,
          title: 'I have Question',
          content: 'If you..',
          user_id: @user.id)

    create(:question,
          id: 2,
          title: '이거슨 좋은것.',
          content: '???',
          user_id: @user.id)

    create(:question,
          id: 3,
          title: '다른 사람이 작성한 질문?',
          content: '물론 확인 가능합니다.',
          user_id: @user.id)

    login_as(@user)

    visit '/'

    click_link 'Bulletins'

    click_link 'Q&A'
  end

  scenario '질문 목록을 본다.' do
    expect(page).to have_content('I have Question')
    expect(page).to have_content('이거슨 좋은것.')
    expect(page).to have_content('다른 사람이 작성한 질문?')
  end

  scenario '질문 내용을 본다.' do
    click_link 'I have Question'

    expect(page).to have_content('I have Question')
    expect(page).to have_content('If you..')

    click_link '목록보기'

    click_link '다른 사람이 작성한 질문?'

    expect(page).to have_content('다른 사람이 작성한 질문?')
    expect(page).to have_content('물론 확인 가능합니다.')
  end

  scenario '질문을 등록한다.' do
    click_link '질문 등록'

    fill_in '제목', with: '첫번째 질문입니다.'
    fill_in '내용', with: '첫번째 질문입니다. 이렇게 하면 될까요?'

    click_button '등록'

    expect(page).to have_content('Question was successfully created.')
  end

  scenario '질문을 수정한다.' do
    click_link 'I have Question'

    click_link '수정'

    expect(find_field('제목').value).to eq('I have Question')
    expect(find_field('내용').value).to eq('If you..')

    fill_in '제목', with: '한글로 질문'
    fill_in '내용', with: '어떻게 하면 개발을 잘 할 수 있을까요?'

    click_button '갱신'

    expect(page).to have_content('Question was successfully updated.') 
  end

  scenario '질문 정보를 입력하지 않아 수정에 실패한다.' do
    click_link 'I have Question'

    click_link '수정'

    expect(find_field('제목').value).to eq('I have Question')
    expect(find_field('내용').value).to eq('If you..')

    fill_in '제목', with: ' '
    fill_in '내용', with: ' '

    click_button '갱신'
    expect(page).to have_content('제목에 내용을 입력해 주세요')
  end

  scenario '질문을 삭제한다.' do
    click_link 'I have Question'

    page.driver.accept_js_confirms!

    click_link '삭제'

    expect(page).to_not have_content('I have Question')
  end

  scenario '질문을 삭제하지 않는다.' do
    click_link 'I have Question'

    page.driver.dismiss_js_confirms!

    click_link '삭제'

    expect(page).to have_content('I have Question')
  end

end
require 'spec_helper'

Capybara.javascript_driver = :webkit

feature '질문을 관리한다.' do
  background do
    @user = create(:user, email: 'user@example.com', password: 'testtest', id: 1)
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

    login_as(@user)

    visit '/'

    click_link 'Q&A'
  end

  scenario '질문 목록을 본다.' do
    expect(page).to have_content('I have Question')
  end

  scenario '질문 내용을 본다.' do
    within('.item-1') do
      click_link '보기'
    end

    expect(page).to have_content('I have Question')
    expect(page).to have_content('If you..')
  end

  scenario '질문을 등록한다.' do
    click_link '질문 등록'

    fill_in '질문', with: '첫번째 질문입니다.'
    fill_in '내용', with: '첫번째 질문입니다. 이렇게 하면 될까요?'

    click_button '등록'

    expect(page).to have_content('Question was successfully created.')
  end

  scenario '질문을 수정한다.' do
    within('.item-1') do
      click_link '수정'
    end

    expect(find_field('질문').value).to eq('I have Question')
    expect(find_field('내용').value).to eq('If you..')

    fill_in '질문', with: '한글로 질문'

    click_button '갱신'

    expect(page).to have_content('Question was successfully updated.') 
  end

end
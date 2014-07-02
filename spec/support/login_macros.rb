module LoginMacros
  def set_user_session(user)
    session[:user_id] = user.id
  end

  def sign_in_with(user)
    visit root_path
    click_link 'with RORLa'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end
module LoginHelper
  def login(admin)
    visit root_path
    fill_in 'session_email', with: admin.email
    fill_in 'session_password', with: admin.password
    click_button 'Log in'
    sleep 5
  end
end
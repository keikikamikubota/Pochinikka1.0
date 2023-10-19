module LoginHelper
  def login(admin)
    visit new_session_path
    fill_in 'spec@example.com', with: admin.email
    fill_in 'specsan', with: admin.password
    click_button 'Log in'
  end
end
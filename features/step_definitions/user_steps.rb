

And /^I am logged into the admin panel$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'admin'
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

Given /^I am logged into the admin panel as a "(.*?)"$/ do |profile|
  profiles = {
    "Blog administrator" => 1,
    "Blog publisher" => 2
  }

  name = 'admin'+rand(9999).to_s

  User.create!({:login => name,
                :password => 'aaaaaaaa',
                :email => name+'@snow.com',
                :profile_id => profiles[profile],
                :name => 'admin',
                :state => 'active'})

  visit '/accounts/login'
  fill_in 'user_login', :with => name
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end
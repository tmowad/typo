Given /^user "(.*?)" owns the following articles$/ do |user, table|
  user_id = User.find_by_login(user).id
  table.hashes.each do |hash|
    article = Article.new(hash)
    article.id = hash[:id]
    article.user_id = user_id
    article.save
  end
end

Then /^the article "(.*?)" should have body "(.*?)"$/ do |title, body|
  Article.find_by_title(title).body.should eq body
end

Then /^there should not be any article with id "(.*?)"$/ do |id|
  Article.find_by_id(id).should be nil
end

Given /^I am logged in as a publisher$/ do
  visit '/accounts/logout'
  visit '/accounts/login'
  fill_in 'user_login', :with => 'publisher'
  fill_in 'user_password', :with => '12341234'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

Then /^I should not see a "(.*?)" button$/ do |button_name|
  expect { click_button(button_name) }.to raise_error(Capybara::ElementNotFound)
end

Then /^I should not see a "(.*?)" text box$/ do |field_name|
  expect { fill_in(field_name, :with => 'any value') }.to raise_error(Capybara::ElementNotFound)
end


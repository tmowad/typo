Given /^the following articles exist$/ do |table|
  table.hashes.each do |hash|
    article = Article.new(hash)
    article.id = hash[:id]
    article.save
  end
  # Article.create table.hashes
end

Then /^the article "(.*?)" should have body "(.*?)"$/ do |title, body|
  Article.find_by_title(title).body.should eq body
end



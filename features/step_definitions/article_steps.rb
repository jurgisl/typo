

Given /^there are articles$/ do |articles|
  articles.hashes.each do |article|
  	author = User.where(:login => article['Author'])

  	a = Article.new({
  			:title => article['Title'],
  			:body => article['Content'],
  			:user_id => author.first.id,
  			:published => true
  		})

  	a.id = article['ID']
  	a.save!
  end
end
Given /^I have merged article's "(.*?)" and "(.*?)"$/ do |title1, title2| #'
  article1 = Article.where :title => title1
  article2 = Article.where :title => title2

  article1.first.merge_with(article2.first.id)
end

Given /^article "(.*?)" has a comment "(.*?)" by "(.*?)"$/ do |title, comment, author|
  article = Article.where :title => title

  article.first.add_comment({:body => comment, :author => author}).save
end

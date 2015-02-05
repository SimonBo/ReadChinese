Given(/^chinese texts in database$/) do
  @text1 = FactoryGirl.create(:text, title: "水中国" ,content: "中国水笨蛋", source: "http://news.qq.com/a/20150120/000895.htm?tu_biz=1.114.1.0")
end




Then(/^the user can see a list of texts available for reading$/) do
  expect(page).to have_content @text1.title
end
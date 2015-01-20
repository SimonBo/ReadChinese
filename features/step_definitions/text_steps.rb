Given(/^chinese texts in database$/) do
  @text1 = FactoryGirl.create(:text, content: "【灾区群众作诗赠总书记】看到总书记，当地干部群众十分激动。一位干部说，明天是大寒节气，大伙连夜自发创作了一首诗送给总书记：“大寒节令送大爱，龙头喜降丰年雪，千户万户瞳瞳日，十万乌蒙尽开颜”。现场响起热烈的掌声。望着远处被白雪覆盖的山峦，总书记感叹，这里地理条件确实复杂。
【习近平：灾后重建工作要统筹考虑】总书记叮嘱当地干部说，当前安置工作和灾后重建工作交叉在一起，要协调指挥，统筹有序安排，总体考虑设计。今后的产业发展问题不能拍脑瓜，要符合当地实际，把长远发展的基础打好。
【习近平：扶贫切忌形式主义】鲁甸县地处乌蒙山连片特困地区。总书记说，当地一定要做好扶贫、救灾双重任务。扶贫工作是2020年全面建成小康的重点，也是最艰巨的一项任务，不能光喊口号，更不能搞形式主义，一定要真抓实干。要是到2020年还有几个连片贫困区依然如旧，就谈不上全面小康。", source: "http://news.qq.com/a/20150120/000895.htm?tu_biz=1.114.1.0")
end

Given(/^a logged in user$/) do
  steps %{
    Given a registered user
    Given a user logs in  
  }
end

Given(/^clicks "(.*?)" link withing the navbar$/) do |arg1|
  within('nav'){ click_on arg1}
end

Then(/^the user can see a list of texts available for reading$/) do
  expect(page).to have_content @text1.content
end
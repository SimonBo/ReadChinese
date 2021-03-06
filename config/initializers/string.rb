String.class_eval do
  def is_chinese_character?
    non_chinese = %w(— … 。 ， ／ 、 《 》 ？ ‘ “ ； ： ［ ］ ｝ ｛ ｜ － —— ＝ ＋ ） （ ＊ & …… ％ ¥ ＃ @ ！ ～ ｀ ” , . / < > ? ; ' " : ] [ { } ` ~ ! @ # $ % ^ & * ( ) _ - + =)
    return false  if non_chinese.include? self
    chars.count < bytes.count
  end

  # def not_chinese_char?
  #   
  #   true if non_chinese.include? self
  #   chars.count > bytes.count
  # end

  def is_pinyin?
    match_against = %w[shuang chuang zhuang xiang qiong shuai niang guang sheng kuang shang jiong huang jiang shuan xiong zhang zheng zhong zhuai zhuan qiang chang liang chuan cheng chong chuai hang peng chuo piao pian chua ping yang pang chui chun chen chan chou chao chai zhun mang meng weng shai shei miao zhui mian yong ming wang zhuo zhua shao yuan bing zhen fang feng zhan zhou zhao zhei zhai rang suan reng song seng dang deng dong xuan sang rong duan cuan cong ceng cang diao ruan dian ding shou xing zuan jiao zong zeng zang jian tang teng tong bian biao shan tuan huan xian huai tiao tian hong xiao heng ying jing shen beng kuan kuai nang neng nong juan kong nuan keng kang shua niao guan nian ting shuo guai ning quan qiao shui gong geng gang qian bang lang leng long qing ling luan shun lian liao zhi lia liu qin lun lin luo lan lou qiu gai gei gao gou gan gen lao lei lai que gua guo nin gui niu nie gun qie qia jun kai kei kao kou kan ken qun nun nuo xia kua kuo nen kui nan nou kun jue nao nei hai hei hao hou han hen nai rou xiu jin hua huo tie hui tun tui hun tuo tan jiu zai zei zao zou zan zen eng tou tao tei tai zuo zui xin zun jie jia run diu cai cao cou can cen die dia xue rui cuo cui dun cun cin ruo rua dui sai sao sou san sen duo den dan dou suo sui dao sun dei zha zhe dai xun ang ong wai fen fan fou fei zhu wei wan min miu mie wen men lie chi cha che man mou mao mei mai yao you yan chu pin pie yin pen pan pou pao shi sha she pei pai yue bin bie yun nüe lve shu ben ban bao bei bai lüe nve ren ran rao xie re ri si su se ru sa cu ce ca ji ci zi zu ze za hu he ha ju ku ke qi ka gu ge ga li lu le qu la ni xi nu ne na ti tu te ta xu di du de bo lv ba ai ei ao ou an en er da wu wa wo fu fo fa nv mi mu yi ya ye me mo ma pi pu po yu pa bi nü bu lü e o a]
    words = self.split
    words.all? { |e|  match_against.include? e }
  end

  def is_i?
   /\A[-+]?\d+\z/ === self
 end
end
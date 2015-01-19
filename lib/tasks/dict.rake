namespace :dict do
  desc "Parses dictionary file and updates db"
  task :parse => :environment do
    File.foreach( 'lib/test-dict.txt' ) do |line|
      one_line = line.split
      traditional_char = one_line[0].to_s
      simplified_char = one_line[1].to_s
      char_count = traditional_char.length
      pinyin = one_line[2..1+char_count].to_s.gsub(/[^0-9a-z ]/i, '')
      pinyin_count = pinyin.split.count
      meaning = one_line[2+char_count..-1].join(" ").to_s.gsub(/\//, ',')[1..-2]

      Word.create(traditional_char: traditional_char, simplified_char: simplified_char, pronunciation: pinyin, pinyin_count: pinyin_count,meaning: meaning)
    end
  end
end
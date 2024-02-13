# ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]



first_line = gets
words_count = first_line.split(' ').first.to_i
bad_words_count = first_line.split(' ').last.to_i

bad_words = []
words = []

# puts "words_count: #{words_count}"
# puts "bad_words_count: #{bad_words_count}"

bad_words_count.times { bad_words << gets.gsub(/\n/, '') }
words_count.times { words << gets.gsub(/\n/, '') }

# puts "bad_words: #{bad_words.join(',')}"
# puts "words: #{words.join(',')}"

words.each do |word|
  included = bad_words.any? { |bad| word.include?(bad) }
  puts included ? "BANNED" : "SAFE"
end

# puts "---"
# puts "bad_words: #{bad_words.join(',')}"

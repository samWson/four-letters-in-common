# Four Letters in Common.
# Author: Samuel Wilson.
# This program takes a single word, and finds all the words that have
# four or more consecutive letters in common from a list of words.
# The list of words is sourced from a separate text file.

require 'set'

### Method definitions.

# Returns all four or more consectutive letter combinations of a word.
# A slice is a single letter combination.
def get_slices(word)

  slices = []
  
  # Slicing variables
  start = 0                # The index to start a slice from.
  length = 3               # The number of letters a slice will be after the first. Note this referes to the index of a letter.
  stop = start + length    # The index at which to stop the slice.

  # Get all the possible consecutive letter combinations
  until length == word.length

    until stop == word.length
      slice = word [start..stop]
      slices << slice
      start += 1
      stop += 1
    end

    length += 1           # Increase the slice size for the next loop
    start = 0             # Reset to the first index
    stop = start + length # Set to the next index to stop the slice

  end

  slices
end

# Return all the words in 'dictionary' that have four or more letters in common with 'word'.
def four_letters_in_common(word, dictionary)

  # Get all four or more consectutive letter combinations i.e. slices
  slices = get_slices(word)

  # To store all words that have letters in common with the slices
  matches = Set.new

  # Find all the matching words
  dictionary.each do |word|
    
    # Check if the word matches any of the slices
    slices.each do |slice|
      if word.include?(slice)
        matches << word
      end

    end
  end

  matches
end

# Show the results of 'matches'.
def show_results(matches, word)

  puts 'The matches:'
  puts matches.each { |match| puts match }
  puts "There are #{matches.length} words that have four or more letters in common with #{word}."

end

### Main program script

puts 'Enter a word of at least four letters: '
word = gets.chomp.upcase
puts 'Enter the file name of an English dictionary: '
word_list = gets.chomp

puts "You entered #{word}."

# Read the words into the dictionary
dictionary_array = []
file = File.new(word_list, 'r')
file.readlines.each do |line|
  dictionary_array << line.chomp
end

# This 'if' expression drives the logic of the program. It either exits the program
# if 'word' is to short, or it runs the methods defined above.
if word.length < 4
  puts 'You must enter a word of at least four letters.'
else
  matches = four_letters_in_common(word, dictionary_array)
  show_results(matches, word)
end

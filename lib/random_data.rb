module RandomData
    # Put 4, 5 or 6 random sentences together to make a random_paragraph
    def self.random_paragraph
        sentences = []
        rand(4..6).times do
            sentences << random_sentence
        end
        sentences.join(" ")
    end
    # Put between 3 and 8 words together to make a random sentence
    def self.random_sentence
        words = []
        rand(3..8).times do
            words << random_word
        end
        sentence = words.join(" ")
        sentence.capitalize << "."
    end
    # Put between 3 and 8 randomly chosen letters together to make a random word
    def self.random_word
        letters = ('a'..'z').to_a
        letters.shuffle!
        letters[0, rand(3..8)].join
    end
    # Capitalize 2 random words to create a name
    def self.random_name
        first_name = random_word.capitalize
        last_name = random_word.capitalize
        "#{first_name} #{last_name}"
    end
    # Use random words to spoof an email address
    def self.random_email
        "#{random_word}@#{random_word}.#{random_word}"
    end
    # Randomly return 1 or -1
    # a simpler method is **[1,-1].sample** used in Bloc checkpoint
    def self.flip_a_coin
        (2 * rand(0..1)) - 1
    end

    def self.random_password
      characters = ('a'..'z').to_a.concat(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'])
      characters.shuffle!
      characters[0, rand(8..12)]
    end

    def self.random_username
      characters = ('a'..'z').to_a.shuffle
      characters[0, rand(4..10)]
    end

end

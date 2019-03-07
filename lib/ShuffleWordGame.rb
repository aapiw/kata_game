class ShuffleWordGame
	attr_accessor :questions
	attr_reader :state

 	QUESTIONS = %w(buku roti roda motor gelas mangga mobil radio pegunungan perpustakaan perdamaian persetujuan good)

	def initialize level=1, score=0, stars=3
		@questions = build_question_and_level(QUESTIONS)
		@state = {score:score, level:level, stars:stars }
	end

	def build_question_and_level questions
		leveling = {1=>[], 2=>[], 3=>[]}
		questions.each do |question|
			obj = {}
			obj[:text] = shuffle_word(question)
			obj[:answear] = question

			if question.size < 5 
				leveling[1] << obj 
			elsif question.size == 5
				leveling[2] << obj 
			else
				leveling[3] << obj
			end
		end

		leveling
	end

	def shuffle_word question
		shuffle = ""
		loop do 
			shuffle	=	question.split("").shuffle.join()
			break if shuffle != question
		end
		shuffle
	end

	
	def play
		puts "================================================================="
		puts "Level: #{@state[:level]} | #{leveling_text(@state[:level])} | #{@questions[@state[:level]].size} Soal | Score: #{@state[:score]} | Stars: #{@state[:stars]}"
		puts "================================================================="
		get_questions()
		current_state()
	end

	def get_questions
		@questions[@state[:level]].shuffle.each do |question|
			
			break if @state[:stars] == 0

			puts "Tebak Kata: #{question[:text]}"
			print "Jawab :"
			word_input = gets.chomp
			if word_input == question[:answear]
				@state[:score] += 1
				puts "Great! your score : #{@state[:score]}!"
			else
				@state[:stars] -= 1
				puts "Wrong! Please try again | stars : #{@state[:stars]}" if @state[:stars] > 0
				redo
			end
		end
	end

	def current_state
		if @state[:stars] == 0
			game_over()
			game_winner("Your results ")
		else
			if @state[:level] < 3
				@state[:level] += 1
				ShuffleWordGame.new(@state[:level], @state[:score], @state[:stars]).play
			else
				game_winner(":) Selamat! ")
			end
		end
	end

	def game_winner text
		puts "=================================================="
		puts "#{text}| Level: #{@state[:level]} | Score: #{@state[:score]} | Stars: #{@state[:stars]}"
		puts "=================================================="		
	end

	def game_over
		puts "=================================================="
		puts ":( Game Over! | Please try again"
		puts "=================================================="
	end

	def leveling_text level
		case level
			when 1
				"Kurang dari 5 huruf"
			when 2
				"5 huruf"
			else
				"Lebih dari 6 huruf"
		end
	end

end
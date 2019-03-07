require "pry"
require_relative "../lib/ShuffleWordGame"


RSpec.describe ShuffleWordGame do
	before(:all) do
		QUESTIONS = %w(buku motor mangga) 
		@game = ShuffleWordGame.new
	end

	describe "initialize" do 
		it "returns default state" do
			expect(@game.state).to eq({:score=>0, :level=>1, :stars=>3})
		end
	end
	describe "#build_question_and_level" do
		it	"returns questions and answear with level" do
			questions = @game.build_question_and_level(QUESTIONS)
			
			expect(questions[1][0][:answear]).to eq("buku")
			expect(questions[2][0][:answear]).to eq("motor")
			expect(questions[3][0][:answear]).to eq("mangga")

			expect(questions.size).to eq(3)
		end
	end

	describe "#shuffle_word" do 
		it "returns not equal to qustion word" do 
			shuffle_word = @game.shuffle_word(QUESTIONS.last)
			expect(shuffle_word).not_to eq(QUESTIONS.last)
		end
	end

end
# frozen_string_literal: true

# PROJECT #
# => Build a Mastermind game from the command line where you have 12 turns to
# guess the secret code, starting with you guessing the computers random code.

require 'colorize'

# game class
class Mastermind
  def initialize(turns, length)
    @turns = turns
    @code_length = length
    @guess = Array.new(@code_length) { 0 }
    @range = (1..6)
    @wrong = true
  end

  def game_loop
    set_code
    first_turn
    until @wrong == false || @turns.zero?
      give_feedback
      guess_code
      display_guess
      wrong?
      puts "turns left: #{@turns}"
      @last_guess = @guess
    end
    end_game
  end

  def first_turn
    @guess = [1, 1, 2, 2]
  end

  # => @guess_code = Array.new(4) { rand(@range) }
  # logic for feedback and guess formation
  def guess_code
    index = 0
    @last_guess.each do |guess|
      @feedback.each do |key|
        case key
        when 2
          p @guess[random(1..4)] = @last_guess[random(1..4)]
        when 1
          p @guess[random(1..4)] = @last_guess[random(1..4)]
        end
      end
      index +=1
    end
    @turns -= 1
  end

  def display_guess
    puts '~~~~~~~~~~~~~~~~~'
    puts ' Guess code:'
    guess_colors
    puts ''
  end

  def self.keypeg
    case to_i
    when 2
      puts 'black '
    when 1
      puts 'white '
    when 0
      puts 'empty '
    end
  end

  def guess_colors
    @guess.each do |num|
      case num
      when 1 then puts '   yellow'.colorize(:light_yellow)
      when 2 then puts '   magenta'.colorize(:magenta)
      when 3 then puts '   red'.colorize(:red)
      when 4 then puts '   blue'.colorize(:blue)
      when 5 then puts '   green'.colorize(:green)
      when 6 then puts '   cyan'.colorize(:cyan)
      end
    end
  end

  ##########
  private

  def give_feedback
    index = 0
    @feedback = []
    @guess.each do |guess|
      if @code[index] == guess
        @feedback.push 2
      elsif @code.include? guess
        @feedback.push 1
      end
      index += 1
    end
    p @feedback.shuffle!
  end

  def show_code
    puts ' secret code:'
    @code.each do |num|
      case num
      when 1 then puts '   yellow'.colorize(:light_yellow)
      when 2 then puts '   magenta'.colorize(:magenta)
      when 3 then puts '   red'.colorize(:red)
      when 4 then puts '   blue'.colorize(:blue)
      when 5 then puts '   green'.colorize(:green)
      when 6 then puts '   cyan'.colorize(:cyan)
      end
    end
  end

  def wrong?
    @code == @guess ? @wrong = false : true
  end

  def set_code
    # @code = Array.new(@code_legnth) {rand(1..6)}
    @code = [1, 3, 4, 6]
  end

  def end_game
    if @turns.zero?
      puts '~~~~~~~~~~~~~~~~~'
      puts 'codebreaker failed'
    elsif @wrong == false
      puts '~~~~~~~~~~~~~~~~~'
      puts 'grats bro you did it'
    end
    show_code
  end
end

game = Mastermind.new(12, 4)
game.game_loop

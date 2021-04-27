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
    @last_guess = @guess
    display_guess
  end

  # => @guess_code = Array.new(4) { rand(@range) }
  # logic for feedback and guess formation
  def guess_code
    @guess = []
    index = 0
    @feedback.each do |feebak|
      random = rand(@range)
      case feebak
      when 2
        @guess.insert(index, @last_guess[index])
        #  keep 1 but move it
      when 1
        @guess.insert(index, @last_guess[rand(1..4)])
      else
        @guess.insert(index, random)
      end
      index +=1
    end
    @turns -= 1
  end

  def display_guess
    puts ''
    puts '~~~~~~~~~~~~~~~~~'
    puts ' Guess code:'
    guess_colors
    puts ''
  end

  def keypegs(num)
    case num
    when 2
      print ' black '.colorize(
        :color => :black,
        :background => :light_black
        )
    when 1
      print ' white '.colorize(
        :color => :light_white,
        :background => :light_black
        )
    when 0
      print ' empty '.colorize(
        :color => :red,
        :background => :light_black
        )
    end
  end

  def guess_colors
    @guess.each do |num|
      colors(num)
    end
  end

  def colors(num)
    case num
    when 1 then puts '   yellow'.colorize(:light_yellow)
    when 2 then puts '   magenta'.colorize(:magenta)
    when 3 then puts '   red'.colorize(:red)
    when 4 then puts '   blue'.colorize(:blue)
    when 5 then puts '   green'.colorize(:green)
    when 6 then puts '   cyan'.colorize(:cyan)
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
      else
        @feedback.push 0
      end
      index += 1
    end
    @feedback.shuffle!.each do |num|
      keypegs(num)
    end
    puts ''
  end

  def show_code
    puts ' secret code:'
    @code.each do |num|
      colors(num)
    end
  end

  def wrong?
    @code == @guess ? @wrong = false : true
  end

  def set_code
    @code = Array.new(@code_length) {rand(@range)}
    # @code = [1, 2, 3, 4]
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

game = Mastermind.new(120, 4)
game.game_loop

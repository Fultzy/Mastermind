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
    set_code
  end

  # game mode
  def player_computer(boolean)
    boolean ? loop_player_guess : loop_computer_guess
  end

  ####################
  # player as codebreaker
  def loop_player_guess
    until @wrong == false || @turns.zero?
      player_turn
      display_guess
      wrong?
      give_feedback
      puts "turns left: #{@turns}"
      @last_guess = @guess

    end
    end_game
  end

  def player_turn
    @guess = []
    puts ' Enter 4 colors to guess the code.'
    puts ' avalable colors: yellow, magenta, red, blue, green and cyan'
    print 'colors: '
    input = gets.chomp
    reverse_color(input.split)
    @turns -= 1
  end

  def reverse_color(colors)
    colors.each do |color|
      case color
      when 'yellow' then @guess.push 1
      when 'magenta' then @guess.push 2
      when 'red' then @guess.push 3
      when 'blue' then @guess.push 4
      when 'green' then @guess.push 5
      when 'cyan' then @guess.push 6
      end
    end
  end


  ####################
  # computer logic
  def loop_computer_guess
    first_turn
    until @wrong == false || @turns.zero?
      give_feedback
      computer_guess_code
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

  ####################
  # logic for guessing
  def computer_guess_code
    @guess = []
    index = 0
    @feedback.each do |feebak|
      case feebak
      when 2
        @guess.insert(index, @last_guess[index])
        #  keep 1 but move it
      when 1
        @guess.insert(index, @last_guess[rand(0..3)])
      else
        @guess.insert(index, rand(@range))
      end
      index += 1
    end
    @turns -= 1
  end

  ####################
  # display methods
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

  ####################
  # no touchy
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

  ##########
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

  ##########
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

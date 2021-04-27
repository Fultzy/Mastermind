  # PROJECT #
# => Build a Mastermind game from the command line where you have 12 turns to
# guess the secret code, starting with you guessing the computer’s random code.

class Mastermind
  def initialize
    @turns = 12
    @code_legnth = 4
    @feedback = Array.new
    @guess = Array.new
  end

  def game_loop
    set_code
    first_turn
    while wrong? == true do
      get_feedback
      turn
    end
    p 'you win!'
  end

  def turn
    compare
    guess
    @turns -= 1
  end

  def guess()
    @guess =

  end

  def compare

  end

  ##########
  private

  def get_feedback

  end

  def wrong?(guess, code)
    guess != code
  end

  def set_code
    # @code = Array.new(@code_legnth) {rand(1..6)}
    @code = (1,2,3,4)
  end
end

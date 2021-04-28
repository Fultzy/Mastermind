require './lib/game_state'
require 'colorize'

class Interaction


  def codebreaker
    puts ' whould you like to be the codebreaker?'
    print ' y/n: '
    inpt = gets.chomp.upcase
    inpt == 'Y'
  end



end

player = Interaction.new
game = Mastermind.new(12, 4)
game.player_computer(player.codebreaker)

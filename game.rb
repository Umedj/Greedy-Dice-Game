
require './diceset'

# Assumptions : Once the player Enters the game , he gets a throw of 5 dices irrespective 
# of how he got the 300. The score accumalated from this throw onwards will be added to the initial
# tally of 300+ which got the player in the game 

class Game 
  @numPlayers
  @score
  
  def begin_game
    print "Enter number of players: "
    @numPlayers = gets.chomp.to_i
    @score = Array.new(@numPlayers) # Final score tally
    
    puts "\nScore atleast 300 in one turn to get in game"
    @numPlayers.times { |playerNum|
      @score[playerNum] = 0
    }
    
    play()
  end


  def inGame?(playerNum)
    puts "\n***Turn for player #{playerNum}***"

    if(@score[playerNum] < 300)
      rem = 0
      first_score = 0
      dc = DiceSet.new()
      first_score, rem = dc.roll(5)
      
        if(first_score >= 300)
          puts "You are now in the game!!"
          @score[playerNum] = first_score
          return true
        else
          puts "Wait for next turn"
          return false
        end
    else   
      return true
    end
  end

  def play
    dices = DiceSet.new
    winner = 0 
    playerNum = 0
    while (@score[playerNum] < 3000)
      displayStats()

      # Check if the player in Game .If not give him chances to cross 300 threshold.
      while(!inGame?(playerNum))
        playerNum = (playerNum + 1) % @numPlayers
      end

      round_score = 0
      remaining = 5

      while remaining != 0 do
        roll_score, remaining = dices.roll(remaining)

        if (roll_score == 0)
          round_score = 0
          break
        elsif (remaining >= 1)
          round_score += roll_score
          print "Y to roll the #{remaining} dices. N to stop turn:  "
          choice = gets.chomp()
          break if (choice == "N" || choice == "n")
        end
      end
      puts "Round score for player #{playerNum} is #{round_score}"

      @score[playerNum] += round_score

      break if (@score[playerNum] >= 3000)
      playerNum = (playerNum + 1) % @numPlayers
    end

    
    puts "\n\n** Final Round of Game **"
    displayStats()

    (@numPlayers - 1).times do
      playerNum = (playerNum + 1) % @numPlayers
      
      round_score = 0
      remaining = 5
      while remaining != 0 do
        roll_score, remaining = dices.roll(remaining)
        puts "You scored #{roll_score} with #{remaining} unscored dices."

        if (roll_score == 0)
          round_score = 0
          break
        elsif (remaining > 0)
          round_score += roll_score  
          choice = gets.chomp()
          print "Y to roll the #{remaining} dices. N to stop turn:  "
          choice = gets.chomp()
          break if choice == "N" || choice == 'n'
        end
      end
      puts "Round score for player #{playerNum} is #{round_score}"
      @score[playerNum] += round_score
    end
    declareWinner()
  end


  def displayStats
    puts "\n"
    puts "---------------------------------"
    @numPlayers.times { |playerNum|
      puts "\tPlayer #{playerNum} at #{@score[playerNum]}"
    }
    puts "----------------------------------"
  end


  def declareWinner
    winner = 0 #Default = Player 0
    @numPlayers.times do |playerNum|
      if (@score[playerNum] > @score[winner])
        winner = playerNum
      end
    end
    displayStats()
    puts "\n\n Winner : #{winner} Score : #{@score[winner]}!"
  end
end    


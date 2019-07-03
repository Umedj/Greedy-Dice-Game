class DiceSet
  
  def roll(count)
    @values = []
    count.times do
      @values.push(1 + rand(6)) 
    end
    score(@values)
  end

  def score(dice)
    score = 0
    remaining = dice.length
    (1..6).each do |i|
      slice = dice.select {|d| d == i}
      if(slice.size >= 3)
        remaining -= 3
        if i == 1
          score += 1000
        else
          score += (i * 100)
        end
      end
      
      rest = slice.size % 3
      if i == 1
        score += rest * 100
        remaining -= rest
      elsif i == 5
        score += rest * 50
        remaining -= rest
      end
    end
    
    if (remaining == 0)
      remaining = 5
    end
      puts" Throw: #{dice} \tScore: #{score} \tunscored dice: #{remaining} ."
      return [score, remaining]
  end
end

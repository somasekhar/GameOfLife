
class GameOfLife

  #initialize sqaure matrix of nxn
  def initialize(n)
    @n=n
    @m=n
    @matrix = Array.new
    fill_array
  end

  #creates a matrix of nxm
  def fill_array
    @n.times { |i|
    puts "Enter 3 row elements separated by coma. eg: x,-,x"
      row_arr = Array.new
      gets.chomp.split(",").each { |ele|
        row_arr << ele
      }
      @matrix << row_arr
    }
  end

  #puts the matrix
  def print_array
   puts "updated below"
   @n.times { |row|
      @m.times { |col|
        putc @matrix[row][col]
      }
      puts "\n"
    }
  end

  #starts the logic.
  def start_game_of_life
    @n.times { |row|
      @m.times { |col|
        if is_alive?(row,col)                       #check if live cell else apply rule-4
          if check_rule_1(get_neighbours(row,col))  #if satisfying rule1 then kill
            kill(row,col)
            print_array
          elsif check_rule_2(get_neighbours(row,col))#if satisfying rule2 then kill
            kill(row,col)
            print_array
          elsif check_rule_3(get_neighbours(row,col))#if satisfying rule3 take no action, the cell gets carried to next generation
            print_array
          end
        else
          if check_rule_4(get_neighbours(row,col))   #if rule4 satisfied then cell gets alive
            birth(row,col)
          end
        end
      }
      puts "\n"
    }
  end

  #if live neighbours are less than 2 then satisfies rule1
  def check_rule_1(neighbours)
    if get_live_neighbours_count(neighbours) < 2
     return true
    end
  end

  #if live neighbours are greater than 3 then satisfies rule2
  def check_rule_2(neighbours)
    if get_live_neighbours_count(neighbours) > 3
     return true
    end
  end

  #if live neighbours are exactly equal to 2 or 3 then satisfies rule3
  def check_rule_3(neighbours)
    if 2 <= get_live_neighbours_count(neighbours) || get_live_neighbours_count(neighbours) <= 3
     return true
    end
  end

  #if dead cell has 3 live neighbours then satisfies rule4
  def check_rule_4(neighbours)
    if get_live_neighbours_count(neighbours) == 3
     return true
    end
  end

  def birth(row,col)
    @matrix[row][col] = "x"
  end

  def kill(row,col)
    @matrix[row][col] = "-"
  end

  def get_live_neighbours_count(neighbours)
    neighbours.select{|e| e == "x"}.length
  end

  #calculate the neighbouring cells horizontal,vertical and diagonal
  def get_neighbours(i,j)
    neighbours = Array.new
    if ((j-1) >= 0)
      neighbours << @matrix[i][j-1]
    end
    if ((j+1) <= @m-1)
      neighbours << @matrix[i][j+1]
    end
    if ((i-1) >= 0)
      neighbours << @matrix[i-1][j]
    end
    if ((i+1) <= @m-1)
      neighbours << @matrix[i+1][j]
    end
    if ((i-1) >= 0) && ((j-1) >= 0)
      neighbours << @matrix[i-1][j-1]
    end
    if ((i+1) <= @m-1) && ((j+1) <= @m-1)
      neighbours << @matrix[i+1][j+1]
    end
    if ((i-1) >= 0) && ((j+1) <= @m-1)
      neighbours << @matrix[i-1][j+1]
    end
    if ((i+1) <= @m-1) && ((j-1) >= 0)
      neighbours << @matrix[i+1][j-1]
    end
    return neighbours
#    [@matrix[i][j-1],@matrix[i][j+1],@matrix[i-1][j],@matrix[i+1][j],@matrix[i-1][j-1],@matrix[i+1][j+1],@matrix[i-1][j+1],@matrix[i+1][j-1]]
  end

  #checks if the cell is alive 'x' denotes a live cell else dead cell represented by '-'
  def is_alive?(row,col)
    if @matrix[row][col] == "x"
      return true
    end
  end

end

obj_gameoflife = GameOfLife.new(3) #as of now its hardcoded with 3. to generate 3x3 grid
obj_gameoflife.print_array

obj_gameoflife.start_game_of_life
puts "final state:"
obj_gameoflife.print_array

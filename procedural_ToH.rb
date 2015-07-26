class TowerOfHanoi

  def initialize(num_disks)
    @disks = num_disks
  end

  def start_game
    # introductory message
    puts "Welcome to Tower of Hanoi"
    puts "Instructions:"
    puts "Enter where you'd like to move disks from a column and to another column in the format [1,3].  Enter 'q' to quit."
  end

  def init_board
    # sets up board where first column contains initial number of disks
    first_column = []

    # fills first column as necessary
    @disks.times do |disk|
      first_column.push(disk + 1)
    end

    # array returned to render
    [
      # disks are doubled to center visually later on
      first_column.reverse.map{|num| num * 2},
      [],
      []
    ]
  end

  # check to see if user input valid columns
  def valid_input?(input)
    # make sure input only contains 2 columns
    if input.length == 2
      input.each do |column|
        # check to see if column choices are between 1 and 3
        if column < 1 || column > 3
          puts "Enter numbers between 1 and 3"
          return false
        end
      end

      return true
    else
      puts "\nEnter only two numbers separated by a comma\n"
      return false
    end
  end

  # check if disk being moved can be placed in new column
  def valid_move?(board, from, to)
    # check if 'from' column is empty
    if board[from - 1].last == nil
      puts "\nThere is no disk in that column\n"
      return false
    # check that disk being moved is smaller than disk in new column
    elsif (board[to - 1].last != nil) && (board[to - 1].last < board [from - 1].last)
      puts "\nA bigger disk cannot be placed on a smaller disk\n"
      return false
    else
      return true
    end
  end

  # prints board with disks centered to column
  def render(board)
    puts "\nCurrent Board:"
    (@disks - 1).downto(0) do |column|
      3.times do |row|
        print ("o" * board[row][column].to_i).center((@disks*2) + 2)
      end
      print "\n"
    end
    print "-C1-".center((@disks*2) + 2)
    print "-C2-".center((@disks*2) + 2)
    print "-C3-".center((@disks*2) + 2)
    print "\n"
  end

  # defines move method
  def move(board, from, to)
    board[to - 1].push(board[from - 1].last)
    board[from - 1].pop
    return board
  end

  def play
    start_game
    board = init_board
    render(init_board)

    # checks to see if top disk in column 3 at the last index is the smallest disk
    until board[2][@disks - 1] == 2
      valid_input = false
      until valid_input
        puts "Enter Move (type 'q' to quit) >"
        input = gets.chomp

        # ends program if user inputs 'q'
        exit if input == "q"

        # properly formats user input for necessary methods
        user_move = input.split(",").map(&:to_i)
        valid_input = valid_input?(user_move)
      end

      # check to see if input move is valid
      valid_move = valid_move?(board, user_move[0], user_move[1])
      unless valid_move == false
        move(board, user_move[0], user_move[1])
        render(board)
      end
    end

    puts "\nCongratulations! You have successfully solved the Tower of Hanoi"
  end
end
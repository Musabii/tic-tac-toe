class Game
    private
    def initialize(playerOne, playerTwo)
        @playerNames = [playerOne, playerTwo]
        @boxes = [*1..9]
        @players = ["o", "x"]
        setRandomPlayers
        drawBoard
        askMove(@player)
    end

    private
    def drawBoard
        puts "\t\t #{@boxes[6]} | #{@boxes[7]} | #{@boxes[8]}"
        puts "\t\t ---------"
        puts "\t\t #{@boxes[3]} | #{@boxes[4]} | #{@boxes[5]}"
        puts "\t\t ---------"
        puts "\t\t #{@boxes[0]} | #{@boxes[1]} | #{@boxes[2]}\n\n"
        
    end

    private
    def askMove(player)
        puts "#{@playerNames[player]} please enter a number to play, remember you are playing as #{@players[player]}."
        move = gets.chomp.to_i
        makeMove(move, player)
        
    end

    private
    def checkWinner(player)
        boxes_to_check = [@boxes[0..2], @boxes[3..5], @boxes[6..8],
         @boxes.values_at(0, 3, 6), @boxes.values_at(1, 4, 7), 
         @boxes.values_at(2, 5, 8), @boxes.values_at(0, 4, 8), 
         @boxes.values_at(2, 4, 6)]
        if boxes_to_check.any? { |boxes| boxes.all? { |box| box == @players[player] } }
            anounceGameResult(player)
            return true  
        elsif @boxes.all? { |box| box == "o" || box == "x" }
            anounceGameResult(-1)
            return true
        else
            return false
        end
    end

    private
    def anounceGameResult(player)
        if player = -1
            puts "It was a draw!"
            return
        end
        puts "Congrats #{@playerNames[player]}, You Won!"
    end

    private
    def makeMove(move, player)
        if @boxes[move-1] == "x" || @boxes[move-1] == "o"
            puts "Please enter a number that's not played already!"
            askMove(player)
            return
        end
        @boxes[move-1] = @players[player]
        drawBoard
        if checkWinner(player)
            return
        end
        changeTurn
        askMove(@player)
    end

    private
    def setRandomPlayers
        @player = Random.new.rand(2)
    end

    private
    def changeTurn
        @player == 0 ? @player = 1 : @player = 0
    end
end




puts "This is a tic tac toe game for two players!\n"
puts "Player one please enter your name:"
playerOne = gets.chomp
puts "Player two please enter your name:"
playerTwo = gets.chomp

round = Game.new(playerOne, playerTwo)
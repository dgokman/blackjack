require 'pry'

class Card
  attr_reader :value, :suit
  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def create_card
    "#{@value}#{@suit}"
  end

end

class Deck
  attr_reader :cards
  def initialize
    @cards = []
      ['A','2','3','4','5','6','7','8','9','10','J','Q','K'].each do |value|
        ['♣','♥','♦','♠'].each do |suit|
          card = Card.new(value, suit)
          @cards << card.create_card
          @shuffled_cards = @cards.shuffle
        end
      end
  end

  def deal(num)
    @player_cards = []
    num.times do
      @player_cards << @shuffled_cards.pop
      end
      puts "Player was dealt #{@player_cards[0]}"
      puts "Player was dealt #{@player_cards[1]}"

  end

  def player_score
    player_score = 0
    @player_cards.each do |card|
       if card[0] == 'J' || card[0] == 'Q' || card[0] == 'K' || card[0] == '1'
          score = 10
       elsif card[0] == 'A'
          score = 11
       else
          score = card[0].to_i
       end

      player_score += score
    end
    player_score
  end

  def dealer_score
    dealer_score = 0
    @dealer_cards.each do |card|
       if card[0] == 'J' || card[0] == 'Q' || card[0] == 'K' || card[0] == '1'
          score = 10
       elsif card[0] == 'A'
          score = 11
       else
          score = card[0].to_i
       end
      dealer_score += score
    end
    dealer_score
  end

  def hit_or_stand(hit_or_stand)
    @dealer_cards = []
    player_index = 2
    if player_score > 21 && hit_or_stand == 'h'
       puts "Dealer wins!"
    elsif player_score < 21 && hit_or_stand == 'h'
        @player_cards << @shuffled_cards.pop
        puts "Player was dealt #{@player_cards[player_index]}"
        puts "Player score: #{player_score}"
        player_index += 1
        puts "Hit or stand (h/s):"
        hit_or_stand = gets.chomp
    elsif player_score < 21 && hit_or_stand == 's'
        2.times do
          @dealer_cards << @shuffled_cards.pop
        end
        puts "Dealer was dealt #{@dealer_cards[0]}"
        puts "Dealer was dealt #{@dealer_cards[1]}"
        puts "Dealer score: #{dealer_score}"
    else
      puts "Hit or stand (h/s):"
      hit_or_stand = gets.chomp
    end

    while dealer_score < 17
      dealer_index = 0
      @dealer_cards << @shuffled_cards.pop
      puts "Dealer was dealt #{@dealer_cards[dealer_index]}"
      puts "Dealer score: #{dealer_score}"
      dealer_index += 1
      #binding.pry
    end

  end
end

class Hand
  attr_reader :player_score, :dealer_score
  def initialize(player_score, dealer_score)
    @player_score = player_score
    @dealer_score = dealer_score
  end

  def winner
    if (@player_score > @dealer_score) || @dealer_score > 21
      puts "Player wins!"
    elsif (@dealer_score > @player_score) || @player_score > 21
      puts "Dealer wins!"
    else
      puts "Player pushes!"
    end
  end
end

deck = Deck.new

puts "Welcome to Blackjack!\n\n"
deck.deal(2)
puts "Player score: #{deck.player_score}"
if deck.player_score == 21
  puts "Blackjack!"
else
  puts "Hit or stand (h/s):"
  hit_or_stand = gets.chomp
end
deck.hit_or_stand(hit_or_stand)
hand = Hand.new(deck.player_score, deck.dealer_score)
hand.winner











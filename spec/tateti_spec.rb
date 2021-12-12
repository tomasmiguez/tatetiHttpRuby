require 'tateti'

def emptyBoard
  Array.new(3) { Array.new(3, :empty_square)}
end

RSpec.describe Tateti, "#play" do
  before(:each) do
    @tateti = Tateti.new
  end

  context "just created" do
    it "board is empty" do
      expect(@tateti.board).to eq emptyBoard
    end

    it "first player can play valid square" do
      @tateti.play(0, [0, 0])

      expectedBoard = emptyBoard
      expectedBoard[0][0] = 0
      expect(@tateti.board).to eq expectedBoard
    end

    it "first player can't play invalid square" do
      expect {
        @tateti.play(0, [5, 0])
      }.to raise_error(TatetiError)
    end

    it "second player can't play first" do
      expect {
        @tateti.play(1, [0, 0])
      }.to raise_error(TatetiError)
    end
  end

  context "first turn played" do
    it "second player can play" do
      @tateti.play(0, [0, 0])

      @tateti.play(1, [1, 0])

      expectedBoard = emptyBoard
      expectedBoard[0][0] = 0
      expectedBoard[1][0] = 1
      expect(@tateti.board).to eq expectedBoard
    end

    it "players can't overwrite occupied squares" do
      @tateti.play(0, [0, 0])

      expect {
        @tateti.play(1, [0, 0])
      }.to raise_error(TatetiError)
    end
  end
end

RSpec.describe Tateti, "#ending" do
  before(:each) do
    @tateti = Tateti.new
  end

  context "just created" do
    it "game hasn't ended" do
      expect(@tateti.ended?).to eq false
    end
  end

  context "a player won with complete row" do
    before(:each) do
      @tateti.play(0, [0, 0])
      @tateti.play(1, [1, 0])
      @tateti.play(0, [0, 1])
      @tateti.play(1, [1, 1])
      @tateti.play(0, [0, 2])
    end

    it "game ended" do
      expect(@tateti.ended?).to eq true
    end

    it "another move cannot be made" do
      expect {
        @tateti.play(1, [1, 2])
      }.to raise_error(TatetiError)
    end

    it "the correct player is the winner" do
      expect(@tateti.winner).to eq 0
    end 
  end

  context "a player won with complete column" do
    it "game ended" do
      @tateti.play(0, [0, 0])
      @tateti.play(1, [0, 2])
      @tateti.play(0, [1, 0])
      @tateti.play(1, [1, 2])
      @tateti.play(0, [2, 0])

      expect(@tateti.ended?).to eq true
    end
  end

  context "a player won with complete left to right diagonal" do
    it "game ended" do
      @tateti.play(0, [0, 0])
      @tateti.play(1, [0, 2])
      @tateti.play(0, [1, 1])
      @tateti.play(1, [1, 2])
      @tateti.play(0, [2, 2])

      expect(@tateti.ended?).to eq true
    end
  end

  context "a player won with complete right to left diagonal" do
    it "game ended" do
      @tateti.play(0, [0, 2])
      @tateti.play(1, [0, 1])
      @tateti.play(0, [1, 1])
      @tateti.play(1, [1, 2])
      @tateti.play(0, [2, 0])

      expect(@tateti.ended?).to eq true
    end
  end
end
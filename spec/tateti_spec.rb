require 'tateti'

def emptyBoard
  Array.new(3) { Array.new(3, :empty_square)}
end

RSpec.describe Tateti, "#board" do
  context "just created" do
    it "board is empty" do
      tateti = Tateti.new

      expect(tateti.board).to eq emptyBoard
    end

    it "first player can play valid square" do
      tateti = Tateti.new

      tateti.play(0, [0, 0])

      expectedBoard = emptyBoard
      expectedBoard[0][0] = 0
      expect(tateti.board).to eq expectedBoard
    end

    it "first player can't play invalid square" do
      tateti = Tateti.new

      expect {
        tateti.play(0, [5, 0])
      }.to raise_error(TatetiError)
    end

    it "second player can't play first" do
      tateti = Tateti.new

      expect {
        tateti.play(1, [0, 0])
      }.to raise_error(TatetiError)
    end
  end

  context "first turn played" do
    it "second player can play" do
      tateti = Tateti.new
      tateti.play(0, [0, 0])

      tateti.play(1, [1, 0])

      expectedBoard = emptyBoard
      expectedBoard[0][0] = 0
      expectedBoard[1][0] = 1
      expect(tateti.board).to eq expectedBoard
    end

    it "players can't overwrite occupied squares" do
      tateti = Tateti.new
      tateti.play(0, [0, 0])

      expect {
        tateti.play(1, [0, 0])
      }.to raise_error(TatetiError)
    end
  end
end

RSpec.describe Tateti, "#winning" do
  context ""
end
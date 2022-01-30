require 'redis'

require 'match'

RSpec.describe Match do
  before(:each) do
    Redis.new.flushall
    @match = Match.new(1)
  end

  context "facade just created" do
    it "game hasn't started" do
      expect(@match.gameStarted?).to eq false
    end

    it "can add both players and game starts" do
      @match.addPlayer(:Pablo)
      @match.addPlayer(:Paola)

      expect(@match.gameStarted?).to eq true
    end

    it "can't add player to a full game" do
      @match.addPlayer(:Pablo)
      @match.addPlayer(:Paola)

      expect{
        @match.addPlayer(:Mariano)
      }.to raise_error(MatchError)
    end
  end
end

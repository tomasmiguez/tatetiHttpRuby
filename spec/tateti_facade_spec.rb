require 'tateti_facade'

RSpec.describe TatetiFacade do
  before(:each) do
    @tateti_facade = TatetiFacade.new
  end

  context "facade just created" do
    it "game hasn't started" do
      expect(@tateti_facade.gameStarted?).to eq false
    end

    it "can add both players and game starts" do
      @tateti_facade.addPlayer(:Pablo)
      @tateti_facade.addPlayer(:Paola)

      expect(@tateti_facade.gameStarted?).to eq true
    end

    it "can't add player to a full game" do
      @tateti_facade.addPlayer(:Pablo)
      @tateti_facade.addPlayer(:Paola)

      expect{
        @tateti_facade.addPlayer(:Mariano)
      }.to raise_error(TatetiFacadeError)
    end
  end
end
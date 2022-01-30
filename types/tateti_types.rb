require './lib/match'

module Types
  class BaseObject < GraphQL::Schema::Object
  end

  class BoardType < Types::BaseObject
    field :board, [[Boolean]]
  end

  class MatchType < Types::BaseObject
    description "A tateti match"
    field :id, ID, null: false
    field :board, BoardType
  end

  class QueryType < Types::BaseObject
    description "The query root of this schema"

    # First describe the field signature:
    field :match, MatchType , "Find a match by ID" do
      argument :id, ID, required: true
    end

    # Then provide an implementation:
    def match(id:)
      Match.new(id)
    end
  end

end

class Schema < GraphQL::Schema
  query Types::QueryType
end 

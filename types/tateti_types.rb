require './lib/match'

module Types
  class BaseObject < GraphQL::Schema::Object
  end

  class BoardType < Types::BaseObject
    field :board, [[String]],
      method: :print_board
  end

  class MatchType < Types::BaseObject
    description "A tateti match"
    field :id, ID, null: false
    field :board, BoardType
    field :status, String
  end
end

module Mutations
  class JoinMatch  < GraphQL::Schema::Mutation
    argument :player, String, required: true

    field :match, ::Types::MatchType, null: true
    field :errors, [String], null: false

    def resolve(player:)
      begin
        match = Match.new(1)  
        match.addPlayer(player) 
        {
          match: match,
          errors: []
        }
      rescue StandardError => e
        {
          match: nil,
          errors: [e.message]
        }
      end
    end
  end
end

module Types
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

  class MutationType < Types::BaseObject
    field :join_match, mutation: Mutations::JoinMatch 
  end
end

class Schema < GraphQL::Schema
  query Types::QueryType
  mutation Types::MutationType
end 

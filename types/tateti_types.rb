require './lib/match'
require 'redis'

module Types
  class BaseObject < GraphQL::Schema::Object
  end

  class Match < Types::BaseObject
    description "A tateti match"
    field :id, ID, null: false
    field :board, [[String]],
      method: :print_board
    field :status, String
    field :player0, String
    field :player1, String
    field :winner, String
  end
end

module Mutations
  class JoinMatch  < GraphQL::Schema::Mutation
    argument :player, String, required: true

    field :match, ::Types::Match, null: true
    field :errors, [String], null: false

    def resolve(player:)
      begin
        next_id = REDIS.get('server:next_id')
        match = Tateti::Match.new(next_id)  
        match.addPlayer(player)
        REDIS.incr('server:next_id') if match.status == "Game ready."
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

  class Play < GraphQL::Schema::Mutation
    argument :id, ID, required: true
    argument :player, String, required: true
    argument :position, [Integer], required: true

    field :match, ::Types::Match, null: true
    field :errors, [String], null: false

    def resolve(id:, player:, position:)
      begin
        match = Tateti::Match.new(id)
        match.play(player, position)
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
  class Query < Types::BaseObject
    description "The query root of this schema"

    field :match, Types::Match , "Find a match by ID" do
      argument :id, ID, required: true
    end

    def match(id:)
      Tateti::Match.new(id)
    end
  end

  class Mutation < Types::BaseObject
    field :join_match, mutation: Mutations::JoinMatch
    field :play, mutation: Mutations::Play 
  end
end

class Schema < GraphQL::Schema
  query Types::Query
  mutation Types::Mutation
end 

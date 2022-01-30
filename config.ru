require 'redis'
require 'graphql'
require 'pry'
require 'rack'

REDIS = Redis.new
REDIS.flushall
REDIS.set('server:next_id', 0)

require './lib/redis_model'
require './lib/match'
require './types/tateti_types'
require './lib/tateti_server'

run GraphQLServer.new(schema: Schema)
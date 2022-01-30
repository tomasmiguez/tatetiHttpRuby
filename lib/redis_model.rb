require 'redis'

REDIS = Redis.new
REDIS.flushall
class RedisModel
  class << self
    private
    def redis_attr_accessor(*attributes)
      attributes.each do |attr|
        define_method("#{attr}=") do |value|
          REDIS.hset("#{self.class.name}:#{instance_variable_get("@id")}", "#{attr}", Marshal.dump(value))          
        end

        define_method(attr) do
          Marshal.load(REDIS.hget("#{self.class.name}:#{instance_variable_get("@id")}", "#{attr}"))
        end
      end
    end
  end

  attr_accessor :id

  def initialize(id)
    @redis = REDIS
    @id = id
  end
end

require 'redis'
require 'base64'

REDIS = Redis.new
REDIS.flushall
class RedisModel
  class << self
    def redis_attr_accessor(*attributes)
      attributes.each do |attr|
        attr_accessor attr

        define_method("#{attr}=") do |value|
          REDIS.hset("#{self.class.name}:#{instance_variable_get("@id")}", "#{attr}", Base64.strict_encode64(Marshal.dump(value)))
        end

        define_method(attr) do
          val = REDIS.hget("#{self.class.name}:#{instance_variable_get("@id")}", "#{attr}")
          Marshal.load(Base64.strict_decode64(val)) if val
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

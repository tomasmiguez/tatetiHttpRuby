class RedisModel
  class << self
    private
    def redis_attr_accessor(*attributes)
      attributes.each do |attr|
        define_method("#{attr}=") do |value|
          REDIS.hset("#{self.class.name}:#{instance_variable_get("@id")}", "#{attr}", value)          
        end

        define_method(attr) do
          REDIS.hget("#{self.class.name}:#{instance_variable_get("@id")}", "#{attr}")
        end
      end
    end
  end

  attr_accessor :id

  def initialize(id)
    @id = id
  end
end

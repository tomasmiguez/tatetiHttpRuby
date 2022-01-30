require 'rack'

class GraphQLServer
  def initialize(schema:, context: {})
    @schema = schema
    @context = context
  end

  def response(status: 200, response:)
    [
      200,
      {
        'Content-Type' => 'application/json',
        'Content-Length' => response.bytesize.to_s
      },
      [response]
    ]
  end

  def call(env)
    request = Rack::Request.new(env)
    payload = if request.get?
      request.params
    elsif request.post?
      body = request.body.read
      JSON.parse(body)
    end

    [403, nil, nil] unless payload

    result = @schema.execute(
      payload['query'],
      variables: payload['variables'],
      operation_name: payload['operationName']
    ).to_json

    response(status: 200, response: result)
  end
end
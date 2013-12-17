module Dawn
  class << self

    def request(options)
      Dawn.authenticate unless @connection
      @connection.request(options)
    end

  end
end
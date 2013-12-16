module Dawn
  class << self

    def request(options)
      @connection.request(options)
    end

  end
end
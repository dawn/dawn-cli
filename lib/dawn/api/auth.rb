module Dawn
  class << self

    def authenticate(options={})
      options = OPTIONS.merge(options)
      options[:headers] = options[:headers].merge(HEADERS)
      @api_key = options.delete(:api_key) || ENV['DAWN_API_KEY']
      if !@api_key
        if options.key?(:username) && options.key?(:password)
          usn = options.delete(:username)
          psw = options.delete(:password)
          @connection = Excon.new("#{options[:scheme]}://#{options[:host]}",
                                  headers: HEADERS)
          @api_key = post_login(username: usn, password: psw)['api_key']
          netrc = Netrc.read
          netrc['dawn.in'] = usn, @api_key
          netrc.save
        else
          netrc = Netrc.read
          usn, api_key = netrc['dawn.in']
          if api_key
            @api_key = api_key
          else
            fail "Authentication failed: please provide a DAWN_API_KEY, username and password or update your .netrc with the dawn details (use dawn login)"
          end
        end
      end
      @headers = HEADERS.merge('Authorization' => "Token token=\"#{@api_key}\"")
      @connection = Excon.new("#{options[:scheme]}://#{options[:host]}", headers: @headers)
    end

    def git_host
      OPTIONS[:host]
    end

  end
end
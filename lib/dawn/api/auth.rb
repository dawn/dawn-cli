require 'netrc'

module Dawn
  class AuthenticationError < RuntimeError
  end
  class << self

    def authenticate(options={})
      options = OPTIONS.merge options
      options[:headers] = options[:headers].merge(HEADERS)
      @api_key = options.delete(:api_key) || ENV['DAWN_API_KEY']

      if !@api_key
        hostname = options[:host]
        url = "#{options[:scheme]}://#{hostname}"

        if options.key?(:username) && options.key?(:password)
          username = options.delete(:username)
          password = options.delete(:password)

          @connection = Excon.new url, headers: HEADERS

          @api_key = User.login(username: username, password: password)['api_key']

          netrc = Netrc.read
          netrc[hostname] = username, @api_key
          netrc.save
        else
          netrc = Netrc.read
          username, api_key = netrc[hostname]
          if api_key
            @api_key = api_key
          else
            raise AuthenticationError, "api_key was not found, try dawn login to reset your .netrc"
            # "please provide a DAWN_API_KEY, username and password, or update your .netrc with the dawn details (use dawn login)"
          end
        end
      end
      @headers = HEADERS.merge 'Authorization' => "Token token=\"#{@api_key}\""
      @connection = Excon.new "#{options[:scheme]}://#{options[:host]}", headers: @headers
    end

  end
end
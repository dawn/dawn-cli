require 'json'
require 'excon'
require 'netrc'

require 'dawn/api/app'
require 'dawn/api/key'
require 'dawn/api/version'

module Dawn

  HEADERS = {
    'Accept'                => 'application/json',
    'Accept-Encoding'       => 'gzip',
    'User-Agent'            => "dawn/#{Api::VERSION}",
    'X-Ruby-Version'        => RUBY_VERSION,
    'X-Ruby-Platform'       => RUBY_PLATFORM
  }

  OPTIONS = {
    headers:  {},
    host:     'api.anzejagodic.com:5000',
    nonblock: false,
    scheme:   'http'
  }

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

    def request(options)
      @connection.request(options)
    end

    def post_login(options={})
      JSON.load(request(
        expects: 200,
        method: :post,
        path: '/login',
        query: options
      ).body)
    end

  end
end
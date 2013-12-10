__LIB_DIR__ = File.expand_path(File.join(File.dirname(__FILE__), ".."))
unless $LOAD_PATH.include?(__LIB_DIR__)
  $LOAD_PATH.unshift(__LIB_DIR__)
end

require 'dawn/api/app'
require 'dawn/api/key'

module Dawn

  VERSION = "0.0.1".freeze

  HEADERS = {
    'Accept'                => 'application/json',
    'Accept-Encoding'       => 'gzip',
    'User-Agent'            => "dawn/#{VERSION}",
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

    def authenticate(options)
      options = OPTIONS.merge(options)
      options[:headers] = options[:headers].merge(HEADERS)
      @api_key = options.delete(:api_key) || ENV['DAWN_API_KEY']
      if !@api_key
        if options.key?(:username) && options.key?(:password)
          usn = options.delete(:username)
          psw = options.delete(:password)
          @connection = Excon.new("#{options[:scheme]}://#{options[:host]}",
                                  options.merge(headers: HEADERS))
          @api_key = post_login['api_key']
        else
          netrc = Netrc.read
          usn, api_key = netrc['dawn.in']
          if api_key
            @api_key = api_key
          else
            fail "Authentication failed: please provide a DAWN_API_KEY, username and password or update your netrc with the dawn details"
          end
        end
      end
      @headers = { 'Authorization' => "Token token=\"#{@api_key}\"" }
      @connection = Excon.new("#{options[:scheme]}://#{options[:host]}", headers: @headers)
    end

    def request(options)
      @connection.request(options)
    end

    def post_login(options={})
      request(
        expects: 200,
        method: :post,
        path: '/login',
        query: options
      )
    end

  end
end
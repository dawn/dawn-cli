module Dawn

  HEADERS = {
    'Accept'                => 'application/json',
    'Content-Type'          => 'application/json',
    'Accept-Encoding'       => 'gzip',
    'User-Agent'            => "dawn/#{Api::VERSION}",
    'X-Ruby-Version'        => RUBY_VERSION,
    'X-Ruby-Platform'       => RUBY_PLATFORM
  }

  OPTIONS = {
    headers:  {},
    host:     'api.dawn.dev',
    nonblock: false,
    scheme:   'http'
  }

end
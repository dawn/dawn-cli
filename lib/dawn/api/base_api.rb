require 'dawn/api/authenticate'
require 'json'

module Dawn
  module BaseApi
    module Extension
      def request(options)
        Dawn.request options
      end

      def json_request(options)
        JSON.load request(options).body
      end
    end

    include Extension

    def self.included(mod)
      mod.extend Extension
    end

  end
end

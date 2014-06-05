require 'dawn/api/base_api'
require 'dawn/api/domain'

module Dawn
  class App
    class Domain < Dawn::Domain

      attr_reader :app

      def initialize(app, hsh)
        @app = app
        super hsh
      end

    end
  end
end

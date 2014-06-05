require 'dawn/api/base_api'
require 'dawn/api/gear'

module Dawn
  class App
    class Gear < Dawn::Gear

      attr_reader :app

      def initialize(app, hsh)
        @app = app
        super hsh
      end

    end
  end
end

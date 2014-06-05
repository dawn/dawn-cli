require 'dawn/api/base_api'
require 'dawn/api/drain'

module Dawn
  class App
    class Drain < Dawn::Drain

      attr_reader :app

      def initialize(app, hsh)
        @app = app
        super hsh
      end

    end
  end
end

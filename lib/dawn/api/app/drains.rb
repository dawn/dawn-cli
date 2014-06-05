require 'dawn/api/base_api'
require 'dawn/api/drain'

module Dawn
  class App
    class Drains

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def create(options={})
        Drain.new(json_request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/drains",
          body: options.to_json
        )["drain"]).tap { |d| d.app = @app }
      end

      def all(options={})
        json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/drains",
          query: options
        ).map { |hsh| Drain.new(hsh["drain"]).tap { |d| d.app = @app } }
      end

      def find(options={})
        Drain.find(options).tap { |d| d.app = @app }
      end

    end
  end
end

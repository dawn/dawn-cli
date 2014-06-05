require 'dawn/api/base_api'
require 'dawn/api/gear'

module Dawn
  class App
    class Gears

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def create(options={})
        Gear.new(json_request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/gears",
          body: options.to_json
        )["gear"]).tap { |d| d.app = @app }
      end

      def all(options={})
        json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/gears",
          query: options
        ).map { |hsh| Gear.new(hsh["gear"]).tap { |d| d.app = @app } }
      end

      def find(options={})
        Gear.find(options).tap { |d| d.app = @app }
      end

      def restart(options={})
        request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/gears/restart",
          body: options.to_json
        )
      end

    end
  end
end

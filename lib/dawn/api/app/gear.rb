require 'dawn/api/base_api'

module Dawn
  class App
    class Gear

      include BaseApi

      attr_reader :app
      attr_reader :data

      def initialize(app, hsh)
        @app = app
        @data = hsh
      end

      def name
        data["name"]
      end

      def id
        data["id"]
      end

      def uptime
        data["uptime"]
      end

      def type
        data["type"]
      end

      def number
        data["number"]
      end

      def refresh
        @data = request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/gears/#{id}",
          query: options
        )["gear"]
      end

      def restart(options={})
        request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/gears/#{id}/restart",
          query: options
        )
      end

      def update(options={})
        request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/gears/#{id}",
          body: options.to_json
        )
      end

    end
  end
end
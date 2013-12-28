module Dawn
  class App
    class Gear

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
        data["id"]["$oid"]
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

      def restart(options={})
        Dawn.request(
          expects: 200,
          method: :delete,
          path: "/apps/#{app.id}/gears/#{id}",
          query: options
        )
      end

      def update(options={})
        Dawn.request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/gears/#{id}",
          query: options
        )
      end

    end
  end
end
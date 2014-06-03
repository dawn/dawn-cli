require 'dawn/api/base_api'

module Dawn
  class App
    class Drain

      include BaseApi

      attr_reader :app
      attr_reader :data

      def initialize(app, hsh)
        @app = app
        @data = hsh
      end

      def id
        data["id"]["$oid"]
      end

      def url
        data["url"]
      end

      def update(options={})
        request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/drain/#{id}",
          query: options
        )
      end

    end
  end
end
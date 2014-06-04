require 'dawn/api/base_api'

module Dawn
  class App
    class Domain

      include BaseApi

      attr_reader :app
      attr_reader :data

      def initialize(app, hsh)
        @app = app
        @data = hsh
      end

      def id
        data["id"]
      end

      def url
        data["url"]
      end

      def refresh
        data = request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/domains/#{id}",
          query: options
        )
      end

      def update(options={})
        request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/domains/#{id}",
          body: options.to_json
        )
      end

    end
  end
end
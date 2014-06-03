require 'dawn/api/base_api'

module Dawn
  class App
    class Domains

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def all(options={})
        json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/domains",
          query: options
        )["domains"]
      end

      def add(options={})
        request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/domains",
          query: options
        )
      end

      def destroy(options={})
        request(
          expects: 200,
          method: :delete,
          path: "/apps/#{app.id}/domains",
          query: options
        )
      end

    end
  end
end
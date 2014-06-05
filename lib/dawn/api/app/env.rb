require 'dawn/api/base_api'

module Dawn
  class App
    class Env < Hash

      include BaseApi

      attr_reader :app

      def initialize(app, data)
        @app = app
        super()
        replace(data)
      end

      def refresh(options={})
        replace json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/env",
          query: options
        )["env"]
      end

      def save(options={})
        replace json_request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/env",
          body: { env: merge(options) }.to_json
        )["env"]
      end

    end
  end
end

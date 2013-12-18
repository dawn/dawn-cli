module Dawn
  class App
    class Env < Hash

      attr_reader :app

      def initialize(app, data)
        @app = app
        super()
        merge!(data)
      end

      def refresh(options={})
        merge!(JSON.load(Dawn.request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/env",
          query: options
        ).body)["env"])
      end

      def save(options={})
        merge!(JSON.load(Dawn.request(
          expects: 200,
          method: :put,
          path: "/apps/#{app.id}/env",
          body: { env: merge(options) }.to_json
        ).body)["env"])
      end

    end
  end
end
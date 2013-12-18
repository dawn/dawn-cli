module Dawn
  class App
    class Env

      attr_reader :app
      attr_reader :data

      def initialize(app, data)
        @app = app
        @data = data
      end

      def [](key)
        data[key]
      end

      def []=(key, value)
        data[key] = value
      end

      def update(options={})
        Dawn.request(
          expects: 200,
          method: :put,
          path: "/apps/#{app.id}/env",
          query: { env: data.merge(options) }
        )
      end

    end
  end
end
module Dawn
  class App
    class Drains

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def add(options={})
        Drain.new JSON.load(Dawn.request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/drains",
          body: options.to_json
        ).body)["drain"]
      end

      def all(options={})
        JSON.load(Dawn.request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/drains",
          query: options
        ).body).map { |hsh| Drain.new(app, hsh["drain"]) }
      end

      def find(options={})
        drain_id = options.delete(:id)
        Drain.new JSON.load(Dawn.request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/drains/#{drain_id}",
          query: options
        ).body)["drain"]
      end

    end
  end
end
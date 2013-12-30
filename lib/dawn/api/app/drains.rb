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

    end
  end
end
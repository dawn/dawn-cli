module Dawn
  class App
    class Gears

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def all(options={})
        JSON.load(Dawn.request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/gears",
          query: options
        ).body).map { |hsh| Gear.new(app, hsh["gear"]) }
      end

      def find(options={})
        gear_id = options.delete(:id)
        Drain.new JSON.load(Dawn.request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/gears/#{gear_id}",
          query: options
        ).body)["gear"]
      end

    end
  end
end
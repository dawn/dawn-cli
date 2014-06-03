require 'dawn/api/base_api'

module Dawn
  class App
    class Gears

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def all(options={})
        json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/gears",
          query: options
        ).map { |hsh| Gear.new(app, hsh["gear"]) }
      end

      def find(options={})
        gear_id = options.delete(:id)
        Drain.new json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/gears/#{gear_id}",
          query: options
        )["gear"]
      end

    end
  end
end
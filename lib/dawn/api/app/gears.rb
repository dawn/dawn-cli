require 'dawn/api/base_api'
require 'dawn/api/app/gear'

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

      def restart(options={})
        request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/gears/restart",
          query: options
        )
      end

      def find(options={})
        gear_id = options.delete(:id)
        Gear.new json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/gears/#{gear_id}",
          query: options
        )["gear"]
      end

    end
  end
end
require 'dawn/api/base_api'
require 'dawn/api/gear'
require 'dawn/api/app/gear'

module Dawn
  class App
    class Gears

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def create(options={})
        Dawn::App::Gear.new @app, json_request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/gears",
          body: options.to_json
        )["gear"]
      end

      def all(options={})
        json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/gears",
          query: options
        ).map { |hsh| Dawn::App::Gear.new @app, hsh["gear"] }
      end

      def find(options={})
        Dawn::App::Gear.new @app, Dawn::Gear.find(options).data
      end

      def restart(options={})
        request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/gears/restart",
          body: options.to_json
        )
      end

    end
  end
end

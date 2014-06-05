require 'dawn/api/base_api'
require 'dawn/api/drain'
require 'dawn/api/app/drain'

module Dawn
  class App
    class Drains

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def create(options={})
        Dawn::App::Drain.new @app, json_request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/drains",
          body: options.to_json
        )["drain"]
      end

      def all(options={})
        json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/drains",
          query: options
        ).map { |hsh| Dawn::App::Drain.new @app, hsh["drain"] }
      end

      def find(options={})
        Dawn::App::Drain.new @app, Dawn::Drain.find(options).data
      end

    end
  end
end

require 'dawn/api/base_api'
require 'dawn/api/app/drain'

module Dawn
  class App
    class Drains

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def all(options={})
        json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/drains",
          query: options
        ).map { |hsh| Drain.new(@app, hsh["drain"]) }
      end

      def create(options={})
        Drain.new json_request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/drains",
          body: options.to_json
        )["drain"]
      end

      def destroy(options)
        json_request(
          expects: 200,
          method: :delete,
          path: "/apps/#{app.id}/drains",
          body: options.to_json
        )
      end

      def find(options={})
        drain_id = options.delete(:id)
        Drain.new json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/drains/#{drain_id}",
          query: options
        )["drain"]
      end

    end
  end
end
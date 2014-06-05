require 'dawn/api/base_api'
require 'dawn/api/domain'

module Dawn
  class App
    class Domains

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def create(options={})
        Domain.new(json_request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/domains",
          body: options.to_json
        )["domain"]).tap { |d| d.app = @app }
      end

      def all(options={})
        json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/domains",
          query: options
        ).map { |hsh| Domain.new(hsh["domain"]).tap { |d| d.app = @app } }
      end

      def find(options={})
        Domain.find(options).tap { |d| d.app = @app }
      end

    end
  end
end

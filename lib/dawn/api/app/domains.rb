require 'dawn/api/base_api'
require 'dawn/api/domain'
require 'dawn/api/app/domain'

module Dawn
  class App
    class Domains

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def create(options={})
        Dawn::App::Domain.new @app, json_request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/domains",
          body: options.to_json
        )["domain"]
      end

      def all(options={})
        json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/domains",
          query: options
        ).map { |hsh| Dawn::App::Domain.new @app, hsh["domain"] }
      end

      def find(options={})
        Dawn::App::Domain.new @app, Dawn::Domain.find(options).data
      end

    end
  end
end

require 'dawn/api/base_api'
require 'dawn/api/app/domain'

module Dawn
  class App
    class Domains

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def all(options={})
        json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/domains",
          query: options
        ).map { |hsh| Domain.new(@app, hsh) }
      end

      def get(options)
        id = options.delete(:id)

        Domain.new(json_request(
          expects: 200,
          method: :get,
          path: "/apps/#{app.id}/domains/#{id}",
          query: options
        )["domain"])
      end

      def create(options={})
        request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/domains",
          body: options
        )
      end

      def destroy(options={})
        request(
          expects: 200,
          method: :delete,
          path: "/apps/#{app.id}/domains",
          query: options
        )
      end

    end
  end
end
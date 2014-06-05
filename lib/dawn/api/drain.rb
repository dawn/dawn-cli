require 'dawn/api/base_api'

module Dawn
  class Drain

    include BaseApi

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def id
      data["id"]
    end

    def url
      data["url"]
    end

    def refresh
      @data = json_request(
        expects: 200,
        method: :get,
        path: "/drains/#{id}",
        query: options
      )["drain"]
    end

    def update(options={})
      request(
        expects: 200,
        method: :post,
        path: "/drains/#{id}",
        body: options.to_json
      )
    end

    def destroy(options={})
      request(
        expects: 200,
        method: :delete,
        path: "/drains/#{id}",
        query: options
      )
    end

    def self.all(options={})
      json_request(
        expects: 200,
        method: :get,
        path: "/drains",
        query: options
      ).map { |hsh| new hsh["drain"] }
    end

    def self.find(options={})
      id = options.delete(:id)

      new json_request(
        expects: 200,
        method: :get,
        path: "/drains/#{id}",
        query: options
      )["drain"]
    end

  end
end

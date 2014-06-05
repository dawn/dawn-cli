require 'dawn/api/base_api'

module Dawn
  class Gear

    include BaseApi

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def id
      data["id"]
    end

    def name
      data["name"]
    end

    def uptime
      data["uptime"]
    end

    def type
      data["type"]
    end

    def number
      data["number"]
    end

    def refresh
      @data = json_request(
        expects: 200,
        method: :get,
        path: "/gears/#{id}",
        query: options
      )["gear"]
    end

    def restart(options={})
      request(
        expects: 200,
        method: :post,
        path: "/gears/#{id}/restart",
        query: options
      )
    end

    def update(options={})
      request(
        expects: 200,
        method: :post,
        path: "/gears/#{id}",
        body: options.to_json
      )
    end

    def destroy(options={})
      request(
        expects: 200,
        method: :delete,
        path: "/gears/#{id}",
        query: options
      )
    end

    def self.all(options={})
      json_request(
        expects: 200,
        method: :get,
        path: "/gears",
        query: options
      ).map { |hsh| new hsh["gear"] }
    end

    def self.find(options)
      id = options.delete(:id)

      new json_request(
        expects: 200,
        method: :get,
        path: "/gears/#{id}",
        query: options
      )["gear"]
    end

  end
end

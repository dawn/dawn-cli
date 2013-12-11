module Dawn
  class App

    attr_reader :data

    def initialize(hsh)
      @data = hsh
    end

    def name
      data["name"]
    end

    def id
      data["id"]["$oid"]
    end

    def update(options={})
      Dawn.request(
        expects: 200,
        method: :patch,
        path: "/apps/#{id}",
        query: options
      )
    end

    def destroy(options={})
      Dawn.request(
        expects: 204,
        method: :delete,
        path: "/apps/#{id}",
        query: options
      )
    end

    def self.all(options={})
      resp = Dawn.request(
        expects: 200,
        method: :get,
        path: "/apps",
        query: options
      )
      JSON.load(resp.body).map { |hsh| new(hsh["app"]) }
    end

    def self.create(options)
      new JSON.load(Dawn.request(
        expects: 200,
        method: :post,
        path: '/apps',
        query: options
      ).body)["app"]
    end

    def self.find(options)
      new JSON.load(Dawn.request(
        expects: 200,
        method: :get,
        path: "/apps/#{options[:id]}",
        query: options
      ).body)
    end

    def self.destroy(options)
      app = find(options)
      app.destroy if app
    end

  end
end
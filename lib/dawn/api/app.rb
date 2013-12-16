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

    def formation
      data["formation"]
    end

    def update(options={})
      Dawn.request(
        expects: 200,
        method: :patch,
        path: "/apps/#{id}",
        query: options
      )
    end

    def scale(options={})
      Dawn.request(
        expects: 200,
        method: :post,
        path: "/apps/#{id}/scale",
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
      path = options[:id] ? "/apps/#{options.delete(:id)}" : "/apps"
      hsh = JSON.load(Dawn.request(
        expects: 200,
        method: :get,
        path: path
        query: options
      ).body)
      hsh = hsh.first if hsh.is_a?(Array)
      new hsh["app"]
    end

    def self.destroy(options)
      app = find(options)
      app.destroy if app
    end

  end
end
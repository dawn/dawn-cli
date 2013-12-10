module Dawn
  class App

    attr_reader :options

    def initialize(options)
      @options = options
    end

    def id
      options["id"]
    end

    def update
      Dawn.request(
        expects: 200,
        method: :post,
        path: "/apps/#{id}",
        query: options
      )
    end

    def destroy
      Dawn.request(
        expects: 203,
        method: :delete,
        path: "/apps/#{id}",
        query: options
      )
    end

    def self.create(options)
      new Dawn.request(
        expects: 200,
        method: :post,
        path: '/apps',
        query: options
      )
    end

    def self.find(options)
      new Dawn.request(
        expects: 200,
        method: :post,
        path: "/apps/#{options[:id]}",
        query: options
      )
    end

  end
end
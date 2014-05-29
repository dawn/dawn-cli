module Dawn
  class Key

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def id
      data["id"]
    end

    def fingerprint
      data["fingerprint"]
    end

    def key
      data["key"]
    end

    def destroy
      Dawn.request(
        method: :delete,
        expects: 204,
        path: "/account/keys/#{id}"
      )
    end

    def self.add(pubkey)
      new JSON.load(Dawn.request(
        method: :post,
        expects: 200,
        path: '/account/keys',
        query: { key: pubkey }
      ).body)["key"]
    end

    def self.get(id)
      new JSON.load(Dawn.request(
        method: :get,
        expects: 200,
        path: "/account/keys/#{id}"
      ).body)["key"]
    end

    def self.all(options={})
      resp = Dawn.request(
        method: :get,
        expects: 200,
        path: '/account/keys',
        query: options
      )
      JSON.load(resp.body).map { |hsh| new(hsh["key"]) }
    end

    def self.destroy(options={})
      Dawn.request(
        method: :delete,
        expects: 204,
        path: "/account/keys/#{options[:id]}"
      )
    end

    class << self
      private :new
    end

  end
end
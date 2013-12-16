module Dawn
  class Key

    def self.add
      file = "#{Dir.home}/.ssh/id_rsa.pub"
      pubkey = File.read(file)
      fingerprint = `ssh-keygen -lf #{file}`
      Dawn.request(
        method: :post,
        expects: 200,
        path: '/account/keys',
        query: { key: pubkey, fingerprint: fingerprint }
      )
    end

    def self.get(id)
      JSON.load(Dawn.request(
        method: :get,
        expects: 200,
        path: "/account/keys/#{id}"
      ).body)
    end

    def self.all(options={})
      JSON.load(Dawn.request(
        method: :get,
        expects: 200,
        path: '/account/keys',
        query: options
      ).body)
    end

    def self.delete(id)
      Dawn.request(
        method: :delete,
        expects: 204,
        path: "/account/keys/#{id}"
      )
    end

    class << self
      private :new
    end

  end
end
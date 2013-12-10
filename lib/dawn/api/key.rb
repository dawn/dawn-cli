module Dawn
  class Key

    def self.add
      file = "#{Dir.home}/.ssh/id_rsa.pub"
      pubkey = File.read(file)
      fingerprint = `ssh-keygen -lf #{file}`
      Dawn.request(method: :post, path: '/account/keys',
                   query: { key: pubkey, fingerprint: fingerprint })
    end

    def self.get(id)
      resp = Dawn.request(method: :get, path: "/account/keys/#{id}")
      key = JSON.load(resp.body)
    end

    def self.list
      resp = Dawn.request(method: :get, path: '/account/keys')
      keys = JSON.load(resp.body)
    end

    def self.delete(id)
      resp = Dawn.request(method: :delete, path: "/account/keys/#{id}")
    end

    class << self
      private :new
    end

  end
end
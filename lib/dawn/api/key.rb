module Dawn
  class Key

    def self.add
      file = "#{Dir.home}/.ssh/id_rsa.pub"
      pubkey = File.read(file)
      fingerprint = `ssh-keygen -lf #{file}`
      Dawn.request(method: :post,
                   expects: 200,
                   path: '/account/keys',
                   query: { key: pubkey, fingerprint: fingerprint })
    end

    def self.get(id)
      resp = Dawn.request(method: :get,
                          expects: 200,
                          path: "/account/keys/#{id}")
      key = JSON.load(resp.body)
    end

    def self.all(options={})
      resp = Dawn.request(method: :get,
                          expects: 200,
                          path: '/account/keys',
                          query: options)
      JSON.load(resp.body)
    end

    def self.delete(id)
      resp = Dawn.request(method: :delete,
                          expects: 204,
                          path: "/account/keys/#{id}")
    end

    class << self
      private :new
    end

  end
end
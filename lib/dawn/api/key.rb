module Dawn
  class Key

    def self.add
      file = "#{Dir.home}/.ssh/id_rsa"
      id_rsa = File.read(file)
      pubkey = SSHKey.new(id_rsa).public_key
      Dawn.request(
        method: :post,
        expects: 200,
        path: '/account/keys',
        query: { key: pubkey }
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
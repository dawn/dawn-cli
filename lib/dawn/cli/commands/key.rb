module Dawn
  module CLI
    module Key

      extend self

      # "Lists all your Keys currently on dawn"
      def list
        puts format_keys(Dawn::Key.all)
      end

      # "Adds this machine's sshkey to Dawn"
      def add
        filename = File.join(Dir.home, ".ssh/id_rsa.pub")
        pubkey = File.read filename
        key    = Dawn::Key.create(key: pubkey)
      end

      # "Retrieve a Key by ID"
      def get(id)
        key = Dawn::Key.find(id: id)
        puts format_keys([key])
      end

      # "Delete a Key by ID"
      def delete
        Dawn::Key.destroy(id: id)
      end

    end
  end
end

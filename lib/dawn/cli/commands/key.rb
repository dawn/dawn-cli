module Dawn
module CLI
class Application
def key_commands

command "key:add" do |c|
  c.syntax = "dawn key:add"
  c.description = "Adds your local ssh_key"

  c.action do |args, options|
    filename = File.join(Dir.home, ".ssh/id_rsa.pub")
    pubkey = File.read filename
    key    = Dawn::Key.add(pubkey)
    puts "Key (#{key.id}) was successfully added"
  end
end

command "key:list" do |c|
  c.syntax = "dawn key:list"
  c.description = "Lists all your Keys currently on dawn"

  c.action do |args, options|
    keys = Dawn::Key.all
    print_keys(keys)
  end
end

command "key:get" do |c|
  c.syntax = "dawn key:get <key_id>"
  c.description = "Retrieve a Key by ID"

  c.action do |args, options|
    key_id = args.first
    key = Dawn::Key.find(id: key_id)
    print_keys([key])
  end
end

command "key:delete" do |c|
  c.syntax = "dawn key:delete <key_id>"
  c.description = "Delete a Key by ID"

  c.action do |args, options|
    key_id = args.first
    Dawn::Key.destroy(id: key_id)
    puts "Key (#{key_id}) was successfully deleted"
  end
end

end
end
end
end
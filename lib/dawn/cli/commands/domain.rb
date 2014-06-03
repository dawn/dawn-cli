module Dawn
module CLI
class Application
def domain_commands

command "domain:add" do |c|
  c.syntax = "dawn domain:add <name>"
  c.description = "Add a new domain to the current app"

  c.action do |args, options|
    name = args.first
    app = current_app

    app.domains.add name: name
  end
end

command "domain:delete" do |c|
  c.syntax = "dawn domain:delete <name>"
  c.description = "Remove an existing domain from the current app"

  c.action do |args, options|
    name = args.first
    app = current_app

    app.domains.destroy name: name
  end
end

command "domain:ls" do |c|
  c.syntax = "dawn domain:ls"
  c.description = "List all domains for the current app"

  c.action do |args, options|
    app = current_app

    print_domains app.domains.all
  end
end

end
end
end
end
module Dawn
module CLI
class Application
def drain_commands

command "drain:add" do |c|
  c.syntax = "dawn drain:add <drain_url>"
  c.description = "Add a Drain url"

  c.action do |args, options|
    drain_url = args.first
    app = current_app
    drain = app.drains.add(drain_url: drain_url)
  end
end

command "drain:delete" do |c|
  c.syntax = "dawn drain:delete <drain_url>"
  c.description = "Remove a Drain url"

  c.action do |args, options|
    drain_url = args.first
    app = current_app
    drain = app.drains.delete(drain_url: drain_url)
  end
end

command "drain:ls" do |c|
  c.syntax = "dawn drain:ls"
  c.description = "Lists all Drains for this App"

  c.action do |args, options|
    drain_url = args.first
    app = current_app
    drains = app.drains.all
    say format_drains(drains)
  end
end

end
end
end
end
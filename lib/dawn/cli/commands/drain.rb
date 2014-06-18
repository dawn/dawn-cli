module Dawn
module CLI
class Application
def drain_commands

command "drain:add" do |c|
  c.syntax = "dawn drain:add <url>"
  c.description = "Add a Drain url"

  c.action do |args, options|
    url = args.first
    app = current_app

    drain = app.drains.create(drain: { url: url })
  end
end

command "drain:delete" do |c|
  c.syntax = "dawn drain:delete <url>"
  c.description = "Remove a Drain url"

  c.action do |args, options|
    url = args.first
    app = current_app

    drain = app.drains.all.find { |drain| drain.url == url }
    if drain
      drain.destroy
    else
      say "Drain (url: #{url}) could not be found"
    end
  end
end

command "drain:ls" do |c|
  c.syntax = "dawn drain:ls"
  c.description = "Lists all Drains for this App"

  c.action do |args, options|
    url = args.first
    app = current_app
    drains = app.drains.all
    say format_drains(drains)
  end
end

end
end
end
end

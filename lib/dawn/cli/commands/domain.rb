module Dawn
module CLI
class Application
def domain_commands

command "domain:add" do |c|
  c.syntax = "dawn domain:add <url>"
  c.description = "Add a new domain to the current app"

  c.action do |args, options|
    url = args.first
    app = current_app

    app.domains.create(domain: { url: url })
  end
end

command "domain:delete" do |c|
  c.syntax = "dawn domain:delete <url>"
  c.description = "Remove an existing domain from the current app"

  c.action do |args, options|
    url = args.first
    app = current_app

    domain = app.domains.all.find { |domain| domain.url == url }
    if domain
      domain.destroy
    else
      say "Domain (url: #{url}) could not be found"
    end
  end
end

command "domain:ls" do |c|
  c.syntax = "dawn domain:ls"
  c.description = "List all domains for the current app"

  c.action do |args, options|
    app = current_app

    say format_domains(app.domains.all)
  end
end

end
end
end
end

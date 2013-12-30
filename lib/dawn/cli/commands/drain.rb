command "drain:add" do |c|
  c.syntax = "dawn drain:add <drain_url>"
  c.description = "Add a drain url"
  c.action do |args, options|
    drain_url = args.first
    app = current_app
    drain = app.drains.add(drain_url: drain_url)
    say "Drain #{drain.name} has been added"
  end
end

command "drain:list" do |c|
  c.syntax = "dawn drain:list"
  c.description = "Lists all the drains for this app"
  c.action do |args, options|
    drain_url = args.first
    app = current_app
    drains = app.drains.all
    print_drains(drains)
  end
end
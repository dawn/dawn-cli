command "drain:add" do |c|
  c.syntax = "dawn drain:add <drain_url>"
  c.description = "Add a drain url"
  c.action do |args, options|
    drain_url = args.first
    app = current_app
    app.drains.add(drain_url: drain_url)
  end
end
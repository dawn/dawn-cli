module Dawn
module CLI
class Application
def env_commands

command "env:set" do |c|
  c.syntax = "dawn env:set [<key_name=value>..]"
  c.description = "Set multiple ENV variables"

  c.action do |args, options|
    env = current_app.env
    vars = args.each_with_object({}) do |arg, hsh|
      key, value = arg.split("=", 2)
      hsh[key] = value
    end
    env.update(vars)
    env.save
    say "App ENV has been updated"
  end
end

command "env:get" do |c|
  c.syntax = "dawn env:get [<key_name> ..]"
  c.description = "Get an ENV var, if none is given prints all the variables"

  c.action do |args, options|
    env = current_app.env
    if args.empty?
      env.each do |key, value|
        say "#{key}: #{value}"
      end
    else
      args.each do |key|
        value = env[key]
        say "#{key}: #{value}"
      end
    end
  end
end

command "env:unset" do |c|
  c.syntax = "dawn env:unset <key_name> [<key_name>..]"
  c.description = "Deletes an ENV var"

  c.action do |args, options|
    env = current_app.env
    dlt_keys = [] # list of the deleted keys
    arg.each do |key|
      if env.key?(key)
        env.delete(key)
        dlt_keys << key
      end
    end
    env.save
    say "deleted #{dlt_keys.join(", ")}"
  end
end

end
end
end
end
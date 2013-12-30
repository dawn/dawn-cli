def print_apps(apps)
  say "ID\t\t\t\tNAME\t\tFORMATION"
  apps.each do |app|
    form = app.formation.map { |k,v| "#{k}: #{v}" }.join(",")
    say "#{app.id}\t#{app.name}\t#{form}"
  end
end

def print_drains(drains)
  say "ID\t\t\t\tNAME\t\tURL"
  drains.each do |drain|
    say "#{drain.id}\t#{drain.name}\t#{drain.url}"
  end
end

def print_gears(gears)
  say "ID\t\t\t\tNAME\t\tUPTIME"
  gears.each do |gear|
    n = gear.uptime.to_i
    if n > 0
      scale  = TimeLord::Scale.new(n)
      uptime = "#{scale.to_value} #{scale.to_unit}"
    else
      uptime = "just now"
    end
    say "#{gear.id}\t#{gear.name}\t\t#{uptime}"
  end
end
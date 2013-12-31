def print_apps(apps)
  say Terminal::Table.new headings: ['ID', 'Name', 'Formation'] do |t|
    apps.each do |app|
      form = app.formation.map { |k,v| "#{k}: #{v}" }.join("\n")
      t << [app.id, app.name, form]
      t << :separator
    end
  end
end

def print_drains(drains)
  say Terminal::Table.new headings: ['ID', 'Name', 'URL'] do |t|
    drains.each do |drain|
      t << [drain.id, drain.name, drain.url]
      t << :separator
    end
  end
end

def print_gears(gears)
  say Terminal::Table.new headings: ['ID', 'Name', 'Uptime'] do |t|
    gears.each do |gear|
      n = gear.uptime.to_i
      if n > 0
        scale  = TimeLord::Scale.new(n)
        uptime = "#{scale.to_value} #{scale.to_unit}"
      else
        uptime = "just now"
      end
      t << [gear.id, gear.name, uptime]
      t << :separator
    end
  end
end
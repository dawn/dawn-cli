def table_style
  { width: 80 }
end

def print_apps(apps)
  table = Terminal::Table.new title: 'Apps',
                              headings: ['ID', 'Name', 'Formation'],
                              style: table_style
  apps.each do |app|
    form = app.formation.map { |k,v| "#{k}: #{v}" }.join("\n")
    table << [app.id, app.name, form]
    table << :separator
  end
  say table
end

def print_drains(drains)
  table = Terminal::Table.new title: 'Drains',
                              headings: ['ID', 'Name', 'URL'],
                              style: table_style
  drains.each do |drain|
    table << [drain.id, drain.name, drain.url]
    table << :separator
  end
  say table
end

def print_gears(gears)
  table = Terminal::Table.new title: 'Gears',
                              headings: ['ID', 'Name', 'Uptime'],
                              style: table_style
  gears.each do |gear|
    n = gear.uptime.to_i
    if n > 0
      scale  = TimeLord::Scale.new(n)
      uptime = "#{scale.to_value} #{scale.to_unit}"
    else
      uptime = "just now"
    end
    table << [gear.id, gear.name, uptime]
    table << :separator
  end
  say table
end
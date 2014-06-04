module Dawn
  module CLI
    module OutputFormatter

      def table_style
        { } #width: 80 }
      end

      def format_keys(keys)
        table = Terminal::Table.new title: 'Keys',
                                    headings: ['ID', 'Fingerprint', 'Key'],
                                    style: table_style
        keys.each do |key|
          table << [key.id, key.fingerprint, " ... "]#key.key[0, 20]] # truncate the key
          table << :separator
        end

        table
      end

      def format_apps(apps)
        table = Terminal::Table.new title: 'Apps',
                                    headings: ['ID', 'Name', 'Formation'],
                                    style: table_style
        apps.each do |app|
          form = app.formation.map { |k,v| "#{k}: #{v}" }.join("\n")
          table << [app.id, app.name, form]
          table << :separator
        end

        table
      end

      def format_domains(domains)
        table = Terminal::Table.new title: 'Domains',
                                    headings: ['ID', 'URL'],
                                    style: table_style
        domains.each do |domain|
          table << [domain.id, domain.url]
          table << :separator
        end

        table
      end

      def format_drains(drains)
        table = Terminal::Table.new title: 'Drains',
                                    headings: ['ID', 'URL'],
                                    style: table_style
        drains.each do |drain|
          table << [drain.id, drain.url]
          table << :separator
        end

        table
      end

      def format_gears(gears)
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

        table
      end

    end
  end
end
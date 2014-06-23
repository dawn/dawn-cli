require "dawn/cli/helpers"

module Dawn
  module CLI
    module App

      extend Dawn::CLI::Helpers

      # "Displays a list of all the apps you have deployed to dawn"
      def self.list
        say format_apps(Dawn::App.all)
      end

      # "Modify the gears of the current app"
      def self.scale(modifiers)
        app = current_app

        #formation = app.formation.dup
        formation = {}

        modifiers.each do |type, a|
          operator, value = *a

          old_formation = (app.formation[type] || 0).to_i

          formation[type] = case operator
                            when "+" then old_formation + value.to_i
                            when "-" then old_formation - value.to_i
                            when "=" then value.to_i
                            end
        end

        app.scale(app: { formation: formation })
      end

      # "Deletes the app on dawn"
      def self.delete
        app = current_app

        app.destroy
        git_remove_dawn_remote app
      end

      # "Prints the App's log to STDOUT"
      def self.logs(follow=false)
        # this is the only method which requires the uri & net/http
        require 'uri'
        require 'net/http'

        filter_regex = %r{\A(?<timestamp>\S+)\s(?<token>\S+)\[(?<proc_id>\S+)\]\:(?<message>.*)}
        timestamp_regex = %r{(?<year>\d+)-(?<month>\d+)-(?<day>\d+)T(?<hour>\d+)\:(?<minute>\d+)\:(?<second>\d+)\.(?<other>.*)}

        opts = {}
        opts[:tail] = follow
        filters = args
        app = current_app
        url = app.logs(opts)
        uri  = URI.parse(url)

        begin
          http = Net::HTTP.new(uri.host, uri.port)
          http.read_timeout = 60 * 60 * 24
          begin
            http.start do
              link_url = uri.path + ("?srv=1")
              #say uri.host + ":" + uri.port.to_s + link_url
              http.request_get(link_url) do |request|
                request.read_body do |chunk|
                  if filters.size > 0
                    chunk.each_line do |line|
                      if mtch_data = line.chomp.match(filter_regex)
                        say mtch_data[0] if filters.include?(mtch_data[:proc_id])
                      end
                    end
                  else
                    say chunk.to_s
                  end
                end
              end
            end
          rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT, SocketError
            raise "Could not connect to logging service"
          rescue Timeout::Error, EOFError
            raise "\nRequest timed out"
          end
        rescue Interrupt
        end
      end

      # "Lists all currently running Gears"
      def self.list_gears
        app = current_app
        gears = app.gears.all.sort_by(&:number)

        ## Print all Gears
        gears_by_type = gears.each_with_object({}) do |gear, hsh|
          (hsh[gear.type] ||= []) << gear
        end
        gears_by_type.keys.sort.each do |key|
          grs = gears_by_type[key]
          say "=== #{key}:"
          say format_gears grs
        end
      end

      def self.restart
        current_app.restart
      end

    end
  end
end

require "docopt"
require 'highline/import'

module Dawn
  module CLI
DOC_TOP = %Q(Usage:
  dawn --version
  dawn [-a APPNAME] [-h] <command> [<argv>...]

Commands:
  create [<name>]
  ls
  ps
  login
  logs [-f]
    -f, --follow               follow logs
  app
  domain
  drain
  env
  key
  release
  run

Options:
  -a APPNAME, --app=APPNAME  specify app
  -h, --help                 display help
  --version                  print version
)

DOC_SUBCOMMAND = {}
DOC_SUBCOMMAND["app"] = %Q(Usage: dawn app [<command>]

Commands:
  delete
  restart
  scale <gear_modifier>

GearModifier:
  type=number
  type+number
  type-number
)

DOC_SUBCOMMAND["domain"] = %Q(Usage: dawn domain [<command>]

Commands:
  add <url>
  delete <url>
)

DOC_SUBCOMMAND["drain"] = %Q(Usage: dawn drain [<command>]

Commands:
  add <url>
  delete <url>
)

DOC_SUBCOMMAND["env"] = %Q(Usage: dawn env [<command>]

Commands:
  get <key_name>...
  set <key_name=value>...
  unset <key_name>...
)

DOC_SUBCOMMAND["key"] = %Q(Usage: dawn key [<command>]

Commands:
  add
  delete <id>
  get <id>
)

DOC_SUBCOMMAND["release"] = %Q(Usage: dawn key [<command>]

Commands:
  add
)

    @@selected_app = nil

    ###
    # @return [String]
    ###
    def self.selected_app
      @@selected_app
    end

    ###
    # @param [String] appname
    ###
    def self.selected_app=(appname)
      @@selected_app = appname
    end

    ###
    # @param [String] basename
    ###
    def self.not_a_command(basename, command)
      # oh look, git style error message
      abort "#{basename}: '#{command}' is not a #{basename} command. See '#{basename} --help'."
    end

    ###
    # @param [String] command
    # @param [Hash] options
    ###
    def self.run_app_command(command, options)
      case command.to_s
      when ""
        Dawn::CLI::App.list
      when "delete"
        Dawn::CLI::App.delete
      when "restart"
        Dawn::CLI::App.restart
      when "scale"
        data = options["<argv>"].inject({}) do |str, hash|
          if str =~ /(\S+)([+-=])(\d+)/
            hash[$1] = [$2, $3.to_i]
          end
        end
        Dawn::CLI::App.scale(data)
      end
    end

    def self.run_domain_command(command, options)
      case command.to_s
      when ""
        Dawn::CLI::Domain.list
      when "add"
        url = options["<argv>"].first
        Dawn::CLI::Domain.add(url)
      when "delete"
        url = options["<argv>"].first
        Dawn::CLI::Domain.delete(url)
      end
    end

    def self.run_drain_command(command, options)
      case command.to_s
      when ""
        Dawn::CLI::Drain.list
      when "add"
        url = options["<argv>"].first
        Dawn::CLI::Drain.add(url)
      when "delete"
        url = options["<argv>"].first
        Dawn::CLI::Drain.delete(url)
      end
    end

    def self.run_env_command(command, options)
      case command.to_s
      when ""
        Dawn::CLI::Env.list
      when "get"
        keys = options["<argv>"]
        Dawn::CLI::Env.get(*keys)
      when "set"
        data = options["<argv>"].each_with_object({}) do |str, hash|
          if str =~ /(\S+)=(.*)/
            key, value = $1, $2
            hash[key] = value
          end
        end
        Dawn::CLI::Env.set(data)
      when "unset"
        keys = options["<argv>"]
        Dawn::CLI::Env.unset(*keys)
      end
    end

    def self.run_key_command(command, options)
      case command.to_s
      when ""
        Dawn::CLI::Key.list
      when "add"
        Dawn::CLI::Key.add
      when "get"
        id = options["<argv>"].first
        Dawn::CLI::Key.get(id)
      when "delete"
        id = options["<argv>"].first
        Dawn::CLI::Key.delete(id)
      end
    end

    def self.run_release_command(command, options)
      case command.to_s
      when ""
        Dawn::CLI::Release.list
      when "add"
        Dawn::CLI::Release.add
      end
    end

    def self.run_subcommand(command, argv)
      result = Docopt.docopt(DOC_SUBCOMMAND[command], argv: command_argv)
      send("run_#{command}_command", result["<command>"], result)
    end

    def self.run(argv)
      result = Docopt.docopt(DOC_TOP, version: Dawn::CLI::VERSION, argv: argv)
      if result["--version"]
        say "Dawn CLI #{Dawn::CLI::VERSION}"
      else
        self.selected_app = result["--app"]

        command = result["<command>"]
        command_argv = result["<argv>"]
        case command
        when "create"
          Dawn::CLI::App.create command_argv.first
        when "ls"
          Dawn::CLI::App.list
        when "ps"
          Dawn::CLI::App.list_gears
        when "login"
          username = ask("Username: ")
          password = ask("Password: ") { |q| q.echo = false }
          Dawn::CLI::Auth.login username, password
        when "logs"
          Dawn::CLI::App.logs
        when *DOC_SUBCOMMAND.keys
          run_subcommand(command, command_argv)
        else
          not_a_command("dawn", command)
        end
      end
    rescue Docopt::Exit => ex
      abort ex.message
    end

  end
end

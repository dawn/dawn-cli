require "docopt"
require 'highline/import'
require "dawn/cli/commands"
require "dawn/cli/version"

module Dawn
  module CLI
DOC_TOP =
%Q(usage: dawn [-a APPNAME] [-h] [<command>] [<argv>...]

Options:
  -a APPNAME, --app=APPNAME           specify app.
  -h, --help                          display help.
  --version                           print version.

Commands:
  create [<name>]                     initialize a new app in this the wd.
  ls                                  print all deployed apps.
  ps                                  print all running gears for current app.
  login                               setup your netrc login details for dawn.
  logs [-f]
    -f, --follow                      follow logs.
  app                                 App control command.
  domain                              Domain control command.
  drain                               Drain control command.
  env                                 ENV control command.
  key                                 Key control command.
  release                             Release control command.
  run                                 run command on current app.
)

DOC_SUBCOMMAND = {}
DOC_SUBCOMMAND["app"] =
%Q(usage: dawn app
       dawn app delete
       dawn app restart
       dawn app scale <gear_modifier>...

Options:
  -h, --help                          display help.

Commands:
  delete                              remove the app from dawn.
  restart                             self explanatory.
  scale                               scale app services.
                                        gear_modifier takes the format
                                        type=number, type+number or type-number
                                        EG: web=3 db+1

  if no command is given, prints all available apps.
)

DOC_SUBCOMMAND["domain"] =
%Q(usage: dawn domain
       dawn domain add <url>
       dawn domain delete <url>

Options:
  -h, --help                          display help.

Commands:
  add                                 add a new domain to the current app.
  delete                              remove a domain from the current app.

  if no command is given, prints all domains for current app.

)

DOC_SUBCOMMAND["drain"] =
%Q(usage: dawn drain
  dawn drain add <url>
  dawn drain delete <url>

Options:
  -h, --help                          display help.

Commands:
  add                                 add a new log drain to current app.
  delete                              remove a log drain from the current app.

  if no command is given, prints all drains for current app.
)

DOC_SUBCOMMAND["env"] =
%Q(usage: dawn env
       dawn env get <key_name>...
       dawn env set <key_name=value>...
       dawn env unset <key_name>...

Options:
  -h, --help                          display help.

Commands:
  get                                 print filtered ENV variables.
  set                                 set ENV variables.
  unset                               unset ENV variables.

  if no command is given, prints the ENV for the current app.
)

DOC_SUBCOMMAND["key"] =
%Q(usage: dawn key
       dawn key add
       dawn key delete <id>
       dawn key get <id>

Options:
  -h, --help                          display help.

Commands:
  add                                 add your current public key to dawn.
  delete                              remove a key.
  get                                 retrieve a key.

  if no command is given, prints all keys deployed to dawn.
)

DOC_SUBCOMMAND["release"] =
%Q(usage: dawn release
       dawn release add

Options:
  -h, --help                          display help.

Commands:
  add                                 create a new release for the current app.

  if no command is given, list all releases for the current app.
)

    @@selected_app = nil
    @@no_operation = nil

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
    # @return [String]
    ###
    def self.no_operation
      @@no_operation
    end

    ###
    # @param [String] appname
    ###
    def self.no_operation=(appname)
      @@no_operation = appname
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
    def self.run_app_command(options)
      if options["delete"]
        Dawn::CLI::App.command(:delete)
      elsif options["restart"]
        Dawn::CLI::App.command(:restart)
      elsif options["scale"]
        data = options["<gear_modifier>"].inject({}) do |str, hash|
          if str =~ /(\S+)([+-=])(\d+)/
            hash[$1] = [$2, $3.to_i]
          end
        end
        Dawn::CLI::App.command(:scale, data)
      else
        Dawn::CLI::App.command(:list)
      end
    end

    def self.run_domain_command(options)
      if options["add"]
        url = options["<url>"]
        Dawn::CLI::Domain.command(:add, url)
      elsif options["delete"]
        url = options["<url>"]
        Dawn::CLI::Domain.command(:delete, url)
      else
        Dawn::CLI::Domain.command(:list)
      end
    end

    def self.run_drain_command(options)
      if options["add"]
        url = options["<url>"]
        Dawn::CLI::Drain.command(:add, url)
      elsif options["delete"]
        url = options["<url>"]
        Dawn::CLI::Drain.command(:delete, url)
      else
        Dawn::CLI::Drain.command(:list)
      end
    end

    def self.run_env_command(options)
      if options["get"]
        keys = options["<key_name>"]
        Dawn::CLI::Env.command(:get, *keys)
      elsif options["set"]
        data = options["<argv>"].each_with_object({}) do |str, hash|
          if str =~ /(\S+)=(.*)/
            key, value = $1, $2
            hash[key] = value
          end
        end
        Dawn::CLI::Env.command(:set, data)
      elsif options["unset"]
        keys = options["<key_name>"]
        Dawn::CLI::Env.command(:unset, *keys)
      else
        Dawn::CLI::Env.command(:list)
      end
    end

    def self.run_key_command(options)
      if options["add"]
        Dawn::CLI::Key.command(:add)
      elsif options["get"]
        id = options["<id>"].first
        Dawn::CLI::Key.command(:get, id)
      elsif options["delete"]
        id = options["<id>"].first
        Dawn::CLI::Key.command(:delete, id)
      else
        Dawn::CLI::Key.command(:list)
      end
    end

    def self.run_release_command(options)
      if options["add"]
        Dawn::CLI::Release.command(:add)
      else
        Dawn::CLI::Release.command(:list)
      end
    end

    ###
    # @param [String] command
    # @param [Array<String>] argv
    ###
    def self.run_subcommand(command, argv)
      if argv.empty?
        subcommand = ""
      else
        result = Docopt.docopt(DOC_SUBCOMMAND[command], argv: argv,
                               version: Dawn::CLI::VERSION, help: true)
      end
      send("run_#{command}_command", result)
    end

    ###
    # @param [Array<String>] argv
    ###
    def self.run(argv)
      # initial run to retrieve command
      result = Docopt.docopt(DOC_TOP, argv: argv,
                             version: Dawn::CLI::VERSION, help: false)
      command = result["<command>"]
      # run the docopt again this time with help enabled if there was no command
      unless command
        result = Docopt.docopt(DOC_TOP, argv: argv,
                               version: Dawn::CLI::VERSION, help: true)
      end

      # set the selected_app
      self.selected_app = result["--app"]
      case command
      when "create"
        Dawn::CLI::App.command(:create, argv.first)
      when "ls"
        Dawn::CLI::App.command(:list)
      when "ps"
        Dawn::CLI::App.command(:list_gears)
      when "login"
        username = ask("Username: ")
        password = ask("Password: ") { |q| q.echo = false }
        Dawn::CLI::Auth.command(:login, username, password)
      when "logs"
        Dawn::CLI::App.command(:logs)
      when *DOC_SUBCOMMAND.keys
        run_subcommand(command, argv)
      else
        not_a_command("dawn", command)
      end
    rescue Docopt::Exit => ex
      abort ex.message
    end

  end
end

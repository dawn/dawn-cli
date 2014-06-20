require "docopt"

module Dawn
  module CLI
DOC_TOP = %Q(Usage:
  dawn [-a APPNAME] [-h] <command> [<argv>...]

Commands:
  create [<name>]
  ls
  ps
  login
  logs [-f]
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
  -f, --follow               follow logs

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
    def self.parse_argv(argv)
      result = Docopt.docopt DOC_TOP, argv: argv
      subcommand = result["<command>"]
      if DOC_SUBCOMMAND.key?(subcommand)
        Docopt.docopt DOC_SUBCOMMAND[subcommand], argv: result["<argv>"]
      else
        return result
      end
    end

  end
end

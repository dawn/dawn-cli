require 'terminal-table'

class Terminal::Table

  ##
  # say uses to_str instead of to_s
  alias :to_str :to_s

end

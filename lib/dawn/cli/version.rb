module Dawn
  module CLI
    module Version
      MAJOR = 0
      MINOR = 8
      PATCH = 0
      BUILD = "dev"
      STRING = [[MAJOR, MINOR, PATCH].compact.join("."), BUILD].compact.join("-").freeze
    end
    # backward compatibility
    VERSION = Version::STRING
  end
end

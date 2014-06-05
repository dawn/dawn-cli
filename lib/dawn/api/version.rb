module Dawn
  module API
    module Version
      MAJOR = 0
      MINOR = 8
      PATCH = 0
      BUILD = nil
      STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join(".").freeze
    end
    # backward compatibility
    VERSION = Version::STRING
  end
end

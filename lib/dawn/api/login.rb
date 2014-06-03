require 'dawn/api/base_api'

module Dawn
  class User

    include BaseApi

    def self.login(options={})
      json_request(
        expects: 200,
        method: :post,
        path: '/login',
        body: options.to_json
      )
    end

  end
end
module Dawn
  class << self

    def post_login(options={})
      JSON.load(request(
        expects: 200,
        method: :post,
        path: '/login',
        body: options
      ).body)
    end

  end
end
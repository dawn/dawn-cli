module Dawn
  class << self

    def post_login(options={})
      JSON.load(request(
        expects: 200,
        method: :post,
        path: '/login',
        query: options
      ).body)
    end

  end
end
require 'dawn/api/base_api'
require 'dawn/api/app/env'
require 'dawn/api/app/gear'
require 'dawn/api/app/gears'
require 'dawn/api/app/drain'
require 'dawn/api/app/drains'
require 'dawn/api/app/domains'

module Dawn
  class App

    include BaseApi

    attr_reader :data
    attr_reader :env

    def initialize(hsh)
      @data = hsh
      @env = Env.new(self, @data.delete("env"))
    end

    def name
      data["name"]
    end

    def id
      data["id"]
    end

    def formation
      data["formation"]
    end

    def git
      data["git"]
    end

    def restart(options={})
      request(
        expects: 200,
        method: :delete,
        path: "/apps/#{id}/gears",
        query: options
      )
    end

    def gears
      @gears ||= Gears.new self
    end

    def drains
      @drains ||= Drains.new self
    end

    def domains
      @domains ||= Domains.new self
    end

    def logs(options={})
      url = json_request(
        expects: 200,
        method: :get,
        path: "/apps/#{id}/logs",
        query: options
      )["logs"]
      "http://#{Dawn.log_host}#{url}"
    end

    def update(options={})
      data.merge!(json_request(
        expects: 200,
        method: :patch,
        path: "/apps/#{id}",
        body: { name: name }.merge(options).to_json
      )["app"])
    end

    def scale(options={})
      request(
        expects: 200,
        method: :post,
        path: "/apps/#{id}/scale",
        body: options.to_json
      )
    end

    def destroy(options={})
      request(
        expects: 200,
        method: :delete,
        path: "/apps/#{id}",
        query: options
      )
    end

    def self.all(options={})
      json_request(
        expects: 200,
        method: :get,
        path: "/apps",
        query: options
      ).map { |hsh| new(hsh["app"]) }
    end

    def self.create(options)
      new json_request(
        expects: 200,
        method: :post,
        path: '/apps',
        body: options.to_json
      )["app"]
    end

    def self.find(options)
      path = options[:id] ? "/apps/#{options.delete(:id)}" : "/apps"
      hsh = json_request(
        expects: 200,
        method: :get,
        path: path,
        query: options
      )
      hsh = hsh.first if hsh.is_a?(Array)
      hsh && new(hsh["app"])
    end

    def self.destroy(options)
      app = find options
      app.destroy if app
    end

  end
end
# frozen_string_literal: true

require 'roda'
require 'rack/cors'
require 'json'

module NTHUtouristAttractions
  # Web controller for NTHUtouristAttractions API
  class Api < Roda
    use Rack::Cors, debug: true, logger: Logger.new($stdout) do
      allowed_methods = %i[get post put delete options head]
      allow do
        origins 'localhost:3000'
        resource '*', headers: :any, methods: allowed_methods, credentials: true
      end
    end
    plugin :halt
    plugin :multi_route

    def secure_request?(routing)
      routing.scheme.casecmp(Api.config.SECURE_SCHEME).zero?
    end

    route do |routing|
      response['Content-Type'] = 'application/json'

      secure_request?(routing) ||
        routing.halt(403, { message: 'TLS/SSL Required' }.to_json)

      routing.root do
        { message: 'NTHUtouristAttractions API up at /api/v1' }.to_json
      end

      routing.on 'api' do
        routing.on 'v1' do
          @api_root = 'api/v1'
          routing.multi_route
        end
      end
    end
  end
end

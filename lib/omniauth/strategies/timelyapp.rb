require 'omniauth-oauth2'
require 'openssl'
require 'base64'

module OmniAuth
  module Strategies
    class Timelyapp < OmniAuth::Strategies::OAuth2

      option :client_options, {
        :site          => 'https://api.timelyapp.com',
        :authorize_url => '/1.1/oauth/authorize',
        :token_url     => '/1.1/oauth/token',
        :grant_type    => 'authorization_code'
      }
      option :authorize_options, [
        :redirect_uri,
        :grant_type
      ]

      #def request_phase
      #  req = Rack::Request.new(@env)
      #  options.update(req.params)
      #  ua = req.user_agent.to_s
      #  super
      #end

      #def auth_hash
      #  signed_value = access_token.params['id'] + access_token.params['issued_at']
      #  raw_expected_signature = OpenSSL::HMAC.digest('sha256', options.client_secret.to_s, signed_value)
      #  expected_signature = Base64.strict_encode64 raw_expected_signature
      #  signature = access_token.params['signature']
      #  fail! "TimelyApp user id did not match signature!" unless signature == expected_signature
      #  super
      #end

      uid { raw_info['id'] }

      info do
        unless @info
          api = OmniAuth::TimelyApp::API.new(token)
          @info = api.get("/accounts")
        end

        @info
      end

      def token
        access_token.token
      end

      credentials do
        hash = {'token' => access_token.token}
        hash.merge!('token_type' => access_token.token_type) if access_token.token_type
        hash.merge!('refresh_token' => access_token.refresh_token) if access_token.refresh_token
        hash
      end

      def raw_info
        {'id'=> '555554'}
        #access_token.options[:mode] = :header
        #@raw_info ||= access_token.get('/accounts').parsed
      end

      extra do
        raw_info.merge({
         #'instance_url' => access_token.params['instance_url'],
         # 'pod' => access_token.params['instance_url'],
         # 'signature' => access_token.params['signature'],
         # 'issued_at' => access_token.params['issued_at']
        })
      end

    end

  end
end

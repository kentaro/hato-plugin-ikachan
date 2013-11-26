require 'hato/plugin'
require 'hato/plugin/ikachan/version'

require 'erb'
require 'uri'
require 'net/http'

module Hato
  module Plugin
    class Ikachan < Base
      def notify(args)
        channel = config.channel
        channel = [channel] if channel.is_a?(String)

        channel.each do |c|
          send_message(:join, c)
          send_message(:notice, c, args)
        end
      end

      protected

      def send_message(action, channel, args = {})
        message = args[:message]

        if action != :join && config.template
          erb = ERB.new(config.template)
          message = erb.result(binding).strip.gsub(/[\r\n]+/)
        end

        url = '%s://%s:%s/%s' % [
          config.scheme || 'http',
          config.host,
          config.port   || 4979,
          action.to_s,
        ]
        params = {
          'channel' => "##{channel}",
          'message' => message,
        }

        send_request(url, params)
      end

      def send_request(url, params)
        http = Net::HTTP.new(URI(url).host, URI(url).port)
        req  = Net::HTTP::Post.new(URI(url).path)
        req.form_data = params

        http.request(req)
      end
    end
  end
end


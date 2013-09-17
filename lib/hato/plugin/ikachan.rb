require 'hato/plugin'
require 'hato/plugin/ikachan/version'

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
          send_message(:notice, c, args[:message])
        end
      end

      protected

      def send_message(action, channel, message='')
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

        res = send_request(url, params)
        res.value
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


# Hato::Plugin::Ikachan [![BuildStatus](https://secure.travis-ci.org/kentaro/hato-plugin-ikachan.png)](http://travis-ci.org/kentaro/hato-plugin-ikachan)

This plugin provides a method to send messages via [Ikachan](https://metacpan.org/release/App-Ikachan).

## Configuration

```ruby
Hato::Config.define do
  api_key 'test'
  host    '0.0.0.0'
  port    9699

  # ...

  tag 'test' do
    plugin 'Ikachan' do
      scheme  'http'
      host    'irc.example.com'
      port    4979
      channel %w[hato pigeon],
    end
  end

  # ...
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'hato-plugin-ikachan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hato-plugin-ikachan

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


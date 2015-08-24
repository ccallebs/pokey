# Pokey

[![Gem Version](https://badge.fury.io/rb/pokey.svg)](http://badge.fury.io/rb/pokey) [![Code Climate](https://codeclimate.com/github/ccallebs/pokey/badges/gpa.svg)](https://codeclimate.com/github/ccallebs/pokey)

Pokey is a Ruby gem designed to easily simulate webhooks / other HTTP requests common 
to a production environment.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pokey'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pokey

## Usage

If you're using Rails, create the initializer by running:

    $ rails g pokey:install

Otherwise, create a new file in your initializers directory named `pokey.rb`. You'll be
setting the default hook directory and (optionally) defining custom hooks here.

``` RUBY
Pokey.configure do |config|
  config.hook_dir = "app/pokey" # Defaults to app/pokey
  config.run_on = [:development, :qa] # Only set environments you want pokey to
                                      # simulate requests for. If not using Rails,
                                      # this currently has no effect

  config.add_hook do |hook|
    hook.destination = "/my/webhook/endpoint"
    hook.data = {
      name: "Test endpoint",
      endpoint_id: 1
    }
    hook.interval = 20 # in seconds
    hook.http_method = :post # supports GET and POST for right now
  end
end
```

If you would like to add many hooks to your project, you can place them in the `hook_dir`
you specified in the initializer. Please note that **each file** must have a `_hook.rb`
suffix. If you're using Rails, you can run

    $ rails g pokey:hook sendgrid_event

to create a new `Pokey::Hook` template. Otherwise, create a file like the following:

``` RUBY
# app/pokey/my_custom_hook.rb
class MyCustomHook < Pokey::Hook
  # The API endpoint to hit
  def destination
  end

  # The data to pass along to the API endpoint
  def data
    { }
  end

  # The HTTP method to use (only supports GET/POST right now)
  def http_method
    :post
  end

  # Time (in seconds) between requests
  def interval
    5
  end
end
```

As your data will inevitably get more complex to simulate actual events,
`Pokey::Hook` subclasses are preferred over ad-hoc hook definitions.

## Pre-made Hooks
I'm attempting to create a suite of pre-made hooks to make simulating
production data easier. Here is a list:

- https://github.com/ccallebs/pokey-sendgrid

## Contributing

1. Fork it ( https://github.com/ccallebs/pokey/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

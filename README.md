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
you specified in the initializer. If you're using Rails, you can run

    $ rails g pokey:hook sendgrid_event

to create a new `Pokey::Hook` template. Otherwise, create a file like the following:

``` RUBY
# app/pokey/sendgrid_event_hook.rb
class SendgridEventHook < Pokey::Hook
  def destination
    if Rails.env.development?
      "http://localhost:3000/api/sendgrid/events"
    elsif Rails.env.qa?
      "http://our-qa-environment.domain.com/api/sendgrid/events"
    end
  end

  def data
    {
      name: event,
      email: email,
      category: category,
      useragent: user_agent,
      ip: ip_address,
      stmp_id: stmp_id
    }
  end

  def http_method
    :post
  end

  def interval
    5
  end

  protected

  def stmp_id
    "<54d39f028d4ab_#{Random.rand(200000)}@web3.mail>"
  end

  def ip_address
    "192.168.0.#{Random.rand(255)}"
  end

  def user_agent
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.95 Safari/537.36"
  end

  def category
    [
      ["User", "Welcome Email"],
      ["User", "Forgot Password"]
    ].sample
  end

  def event
    ['delivered', 'open', 'click'].sample
  end

  def email
    "autogen-#{Random.rand(200)}@domain.com"
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

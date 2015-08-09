# Pokey

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

Create a new file in your initializers directory named `pokey.rb`. Here
is where you'll be defining your API calls.

``` RUBY
Pokey.configure do |config|
  config.add_hook do |hook|
    hook.destination = "/my/webhook/endpoint"
    hook.data = {
      name: "Test endpoint",
      endpoint_id: 1
    }
  end

  Pokey::Scheduler.commit! # This isn't necessary in the config block
                           # but is a decent enough place to put it. This
                           # signifies that all endpoints have been added
                           # and Rufus will begin to schedule hooks.
end
```

In addition, you can also define classes inside a designated directory to
streamline creation of Pokey events.

``` RUBY
# initializers/pokey.rb
Pokey.configure do |config|
  config.hook_dir = "app/pokey" # Defaults to app/pokey
end

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
      name: ["delivered", "click"].sample,
      timestamp: Time.zone.now.to_s,
      :"smtp-id" => "test-blarg@domain.com",
      category: ["User", "Welcome Email"]
    }
  end

  def http_method
    :post
  end

  def interval
    5
  end
end
```

As your data will inevitably get more complex to simulate actual events,
Pokey::Hook sub-classes are the preferred way to declare endpoints.


## Contributing

1. Fork it ( https://github.com/ccallebs/pokey/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

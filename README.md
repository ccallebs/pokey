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
Pokey::Hook sub-classes are the preferred way to declare endpoints.


## Contributing

1. Fork it ( https://github.com/ccallebs/pokey/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

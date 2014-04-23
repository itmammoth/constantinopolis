# Constantinopolis

Constantinopolis allows you to set constants from your ERBed YAML file.
Remarkably, your constants are available not only in ruby context, but in javascript's.
It works with Rails, Sinatra, or any Ruby projects.
It's inspired by [settingslogic](https://github.com/binarylogic/settingslogic).

## Installation

Add this line to your application's Gemfile:

    gem 'constantinopolis'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install constantinopolis

## Usage

### Setup your Fort class

You need to create a class in your application like below.

```ruby
class Istanbul < Constantinopolis::Fort
  yml "#{Rails.root}/config/istanbul.yml"  # Indicate your yaml file path.
  namespace Rails.env  # Indicate top level namespace (If you want).
end
Istanbul.build!  # Don't forget this line!
```

If you are setting for rails application, you'd better to create this file in ```config/initializer```.

### Define constants

Secondly, define constant YAML file.
Of course, you can use ERB expressions in it.
Top level keys are used for 'namespace' if you indicated it in your Fort class.

```yaml
defaults: &defaults
  common: Common value

development:
  <<: *defaults
  greeting: Hello, development!
  number: 1
  memorable_date: <%= Date.today %>
  is:
    located: Turkey

test:
  <<: *defaults
  greeting: Hello, test!
  number: 2
  memorable_date: <%= Date.today + 1 %>
  is:
    located: Turkey

production:
  <<: *defaults
  greeting: Hello, production!
  number: 3
  memorable_date: <%= Date.today + 2 %>
  is:
    located: Turkey
```

### Access from Ruby

Congratulation!
you've been already able to access these constants anywhere like below.

```ruby
Istanbul.common          #=> "Common value"
Istanbul.greeting        #=> "Hello, development!"
Istanbul.number          #=> 1
Istanbul.memorable_date  #=> Wed, 23 Apr 2014
Istanbul.is.located      #=> Turkey
```

### Access from Javascript

You can access your constants in javascript the same way as in ruby context.
Constantinopolis provides you a simple helper method to define javascript's constants.

```html
<%= javascript_tag Istanbul.js_code %><!-- You need to call this line before using constants. -->

<h1>Javascript context</h1>
<p id="common"></p>
<p id="greeting"></p>
<p id="number"></p>
<p id="memorable_date"></p>
<p id="is-located"></p>

<%= javascript_tag do %>
  document.getElementById("common").innerText = Istanbul.common;
  document.getElementById("greeting").innerText = Istanbul.greeting;
  document.getElementById("number").innerText = Istanbul.number;
  document.getElementById("memorable_date").innerText = Istanbul.memorable_date;
  document.getElementById("is-located").innerText = Istanbul.is.located;
<% end %>
```

It's can be a nice to define ```<%= javascript_tag Istanbul.js_code %>``` in ```layouts/application.html.erb``` if you are developing a rails application.

## Contributing

1. Fork it ( http://github.com/itmammoth/constantinopolis/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

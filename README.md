# omniauth-timelyapp

[OmniAuth](https://github.com/intridea/omniauth) Strategy for [timelyapp.com](timelyapp.com).

## Basic Usage

```ruby
require "sinatra"
require "omniauth"
require "omniauth-timelyapp"

class MyApplication < Sinatra::Base
  use Rack::Session
  use OmniAuth::Builder do
    provider :timelyapp, ENV['TIMELYAPP_KEY'], ENV['TIMELYAPP_SECRET']
  end
end
```


## Resources

* [Documentation: This document provides a full list of all Timely APIs currently available](https://dev.timelyapp.com/)

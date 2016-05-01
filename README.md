Namara
======

The official Ruby client for the Namara Open Data service. [namara.io](https://namara.io)

## Installation

```bash
gem install namara
```

## Usage

### Instantiation

You need a valid API key in order to access Namara (you can find it in your My Account details on namara.io).

```ruby
require 'namara'

namara = Namara.new({YOUR_API_KEY})
```

You can also optionally enable debug mode:

```ruby
namara = Namara.new({YOUR_API_KEY}, true)
```

### Getting Data

To make a basic request to the Namara API you can call `get` on your instantiated object
passing in the ID of the data set you want and the version of the data set:

```ruby
response = namara.get('5885fce0-92c4-4acb-960f-82ce5a0a4650', 'en-1')
```

Without a third options argument passed, this will return data with the Namara default offset (0) and limit (250) applied. To specify options, you can pass an options argument:

```ruby
options = {
  'offset' => 0,
  'limit' => 150
}

namara.get('5885fce0-92c4-4acb-960f-82ce5a0a4650', 'en-1', options)
```

### Options

All [Namara data options](https://namara.io/#/api) are supported.

**Basic options**

```ruby
options = {
  'select' => 'market_nam,website',
  'where' => 'town = "Toronto" AND nearby(geometry, 43.6, -79.4, 10km)',
  'offset' => 0,
  'limit' => 20
}
```

**Aggregation options**
Only one aggregation option can be specified in a request, in the case of this example, all options are illustrated, but passing more than one in the options object will throw an error.

```ruby
options = {
  'operation' => 'sum(p0)',
  'operation' => 'avg(p0)',
  'operation' => 'min(p0)',
  'operation' => 'max(p0)',
  'operation' => 'count(*)',
  'operation' => 'geocluster(p3, 10)',
  'operation' => 'geobounds(p3)'
}
```

### License

Apache License, Version 2.0

Namara
======

The official python client for the Namara Open Data service. [namara.io](http://namara.io)

## Installation

```bash
git clone git@github.com:namara-io/namara-ruby.git
sudo gem install minitest
```

## Usage

### Instantiation

You need a valid API key in order to access Namara (you can find it in your My Account details on namara.io).
Update config.py with your API_KEY

```ruby
from namara import Namara

namara = Namara({YOUR_API_KEY})
```

You can also optionally enable debug mode:

```ruby
namara = Namara({YOUR_API_KEY}, true)
```

### Getting Data

To make a basic request to the Namara API you can call `get` on your instantiated object and pass it the ID of the dataset you want and the ID of the version of the data set:

```ruby
response = namara.get('18b854e3-66bd-4a00-afba-8eabfc54f524', 'en-2')
```

Without a third options argument passed, this will return data with the Namara default offset (0) and limit (10) applied. To specify options, you can pass an options argument:

```ruby
options = {
  'offset' => 0,
  'limit' => 150
};

namara.get('18b854e3-66bd-4a00-afba-8eabfc54f524', 'en-2', options)
```

### Options

All [Namara data options](http://namara.io/#/api) are supported.

**Basic options**

```ruby
options = {
  'select' => 'p0,p1',
  'where' => 'p0 = 100 AND nearby(p3, 43.25, -123.1, 10km)',
  'offset' => 0,
  'limit' => 10
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

### Running Tests

From command line:

```bash
ruby -Ilib:test test_namara.rb
```
require 'json'
require 'open-uri'

class Namara
  def initialize(api_key, debug=false, host='api.namara.io', api_version='v0')
    @api_key = api_key
    @debug = debug
    @host = host
    @api_version = api_version
    @headers = {'Content-Type' => 'application/json', 'X-API-Key' => api_key}
  end

  def get(dataset, version, options={})
    puts "REQUEST: #{path(dataset, version, options)}" if @debug

    uri = URI.parse(path(dataset, version, options))
    JSON.parse(uri.open(@headers).read)
  end

  def path(dataset, version, options={})
    encoded_options = URI.encode_www_form(options)
    if is_aggregation?(options)
      "#{base_path(dataset, version)}/aggregation?api_key=#{@api_key}&#{encoded_options}"
    else
      "#{base_path(dataset, version)}?api_key=#{@api_key}&#{encoded_options}"
    end
  end

  def base_path(dataset, version)
    "https://#{@host}/#{@api_version}/data_sets/#{dataset}/data/#{version}"
  end

  private

  def is_aggregation?(options)
    options.include?('operation')
  end
end

require 'minitest/autorun'
require_relative 'lib/namara'

describe Namara do
  before do
    @subject = Namara.new('myapikey')
    @dataset = '18b854e3-66bd-4a00-afba-8eabfc54f524'
    @version = 'en-2'
  end

  describe 'base_path' do
    it 'should have the proper api path' do
      @subject.base_path(@dataset, @version).must_equal('https://api.namara.io/v0/data_sets/18b854e3-66bd-4a00-afba-8eabfc54f524/data/en-2')
    end
  end

  describe 'path' do
    it 'should have the proper api path' do
      @subject.path(@dataset, @version).must_equal('https://api.namara.io/v0/data_sets/18b854e3-66bd-4a00-afba-8eabfc54f524/data/en-2?api_key=myapikey&')
    end

    it 'should append limit at the end of the path' do
      options = {'limit' => 1}
      @subject.path(@dataset, @version, options).must_equal('https://api.namara.io/v0/data_sets/18b854e3-66bd-4a00-afba-8eabfc54f524/data/en-2?api_key=myapikey&limit=1')
    end

    it 'should append offset at the end of the path' do
      options = {'offset' => 1}
      @subject.path(@dataset, @version, options).must_equal('https://api.namara.io/v0/data_sets/18b854e3-66bd-4a00-afba-8eabfc54f524/data/en-2?api_key=myapikey&offset=1')
    end

    it 'should append select at the end of the path' do
      options = {'select' => 'facility_code'}
      @subject.path(@dataset, @version, options).must_equal('https://api.namara.io/v0/data_sets/18b854e3-66bd-4a00-afba-8eabfc54f524/data/en-2?api_key=myapikey&select=facility_code')
    end

    it 'should append sum at the end of the path' do
      options = {'operation' => 'sum(facility_code)'}
      @subject.path(@dataset, @version, options).must_equal('https://api.namara.io/v0/data_sets/18b854e3-66bd-4a00-afba-8eabfc54f524/data/en-2/aggregation?api_key=myapikey&operation=sum%28facility_code%29')
    end

    it 'should append avg at the end of the path' do
      options = {'operation' => 'avg(facility_code)'}
      @subject.path(@dataset, @version, options).must_equal('https://api.namara.io/v0/data_sets/18b854e3-66bd-4a00-afba-8eabfc54f524/data/en-2/aggregation?api_key=myapikey&operation=avg%28facility_code%29')
    end

    it 'should append min at the end of the path' do
      options = {'operation' => 'min(facility_code)'}
      @subject.path(@dataset, @version, options).must_equal('https://api.namara.io/v0/data_sets/18b854e3-66bd-4a00-afba-8eabfc54f524/data/en-2/aggregation?api_key=myapikey&operation=min%28facility_code%29')
    end

    it 'should append max at the end of the path' do
      options = {'operation' => 'max(facility_code)'}
      @subject.path(@dataset, @version, options).must_equal('https://api.namara.io/v0/data_sets/18b854e3-66bd-4a00-afba-8eabfc54f524/data/en-2/aggregation?api_key=myapikey&operation=max%28facility_code%29')
    end

    it 'should append where at the end of the path' do
      options = {'where' => 'facility_code>1000'}
      @subject.path(@dataset, @version, options).must_equal('https://api.namara.io/v0/data_sets/18b854e3-66bd-4a00-afba-8eabfc54f524/data/en-2?api_key=myapikey&where=facility_code%3E1000')
    end
  end

  describe 'get' do
    it 'should handle count properly' do
      def @subject.get(dataset, version, option); {'result' => 129} end
      response = @subject.get(@dataset, @version, options={'operation' => 'count(*)'})
      response['result'].must_equal(129)
    end

    it 'should handle select properly' do
      def @subject.get(dataset, version, option); [{'facility_code' => 1000}] end
      response = @subject.get(@dataset, @version, options={'select' => 'facility_code'})
      response[0]['facility_code'].must_equal(1000)
    end
  end
end

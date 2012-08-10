require 'film_server'
require 'film_reviewer'
require 'net/http'
require 'spec_helper'

class MockResponse
  attr_accessor :body
end

describe FilmServer do
  let (:presenter) { stub }
  let (:film_server) { FilmServer.new presenter  }
  let (:response) { MockResponse.new }

  it 'should return the films from the presenter' do
    request = stub :path => "/films"
    presenter.stub :get_showings => "showings json"
    film_server.handleGET request, response
    response.body.should == "showings json"
  end

  it 'should ignore requests which start with an unrecognised path' do
    request = stub :path => "/wibble"
    film_server.handleGET request, response
    response.body.should include "Unexpected url."
  end 

  it 'should allow caching of a configurable number of days' do
    request = stub :query => {'days' => '4'}, :path => "/cache"
    presenter.should_receive(:build_cache).with 4.days
    film_server.handleGET request, response
  end

  it 'should respond to a cache call by building up the cache for 7 days' do
    request = stub :query => {}, :path => "/cache"
    presenter.should_receive(:build_cache).with 7.days
    film_server.handleGET request, response
  end

  it 'should integrate with the presenter for the film url' do
    store = stub :get_json => "some json"
    real_presenter = Presenter.new stub, stub, store
    film_server = FilmServer.new real_presenter
    request = stub :path => "/films"
    film_server.handleGET request, response
    response.body.should == "some json"
  end

  it 'should integrate with the presenter for the cache url' do
    store = stub :reset => nil, :add => nil, :persist => nil
    tv = stub :get_showings => [], :showings_retrieved_up_to? => true
    real_presenter = Presenter.new tv, stub, store
    film_server = FilmServer.new real_presenter
    request = stub :query => {}, :path => "/cache"
    film_server.handleGET request, response
    response.body.should be_nil
  end
end


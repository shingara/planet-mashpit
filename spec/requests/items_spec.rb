require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/items" do
  before(:each) do
    @response = request("/items")
  end
end
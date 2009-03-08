require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

given "a feed exists" do
  Feed.all.destroy!
  request(resource(:feeds), :method => "POST", 
    :params => { :feed => { :id => nil }})
end

describe "resource(:feeds)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:feeds))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of feeds" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a feed exists" do
    before(:each) do
      @response = request(resource(:feeds))
    end
    
    it "has a list of feeds" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Feed.all.destroy!
      @response = request(resource(:feeds), :method => "POST", 
        :params => { :feed => { :id => nil }})
    end
    
    it "redirects to resource(:feeds)" do
      @response.should redirect_to(resource(Feed.first), :message => {:notice => "feed was successfully created"})
    end
    
  end
end

describe "resource(@feed)" do 
  describe "a successful DELETE", :given => "a feed exists" do
     before(:each) do
       @response = request(resource(Feed.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:feeds))
     end

   end
end

describe "resource(:feeds, :new)" do
  before(:each) do
    @response = request(resource(:feeds, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@feed, :edit)", :given => "a feed exists" do
  before(:each) do
    @response = request(resource(Feed.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@feed)", :given => "a feed exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Feed.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @feed = Feed.first
      @response = request(resource(@feed), :method => "PUT", 
        :params => { :feed => {:id => @feed.id} })
    end
  
    it "redirect to the feed show action" do
      @response.should redirect_to(resource(@feed))
    end
  end
  
end


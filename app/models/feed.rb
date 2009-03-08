class Feed
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :unique => true, :nullable => :false
  property :feed_url, String, :unique => true, :nullable => :false, :length => 255
  property :url, String, :unique => true, :nullable => :false, :length => 255
  property :last_fetched_at, DateTime
  property :last_fetch_successful, Boolean
  property :last_fetch_message, String, :lenght => 255
  has n, :items

  def self.find_by_name(name)
    all(:name => name, :order => [:id.desc])
  end


end

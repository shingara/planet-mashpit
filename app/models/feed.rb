class Feed
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :unique => true, :nullable => :false
  property :feed_url, String, :unique => true, :nullable => :false, :length => 255
  property :url, String, :unique => true, :nullable => :false, :length => 255

  def self.find_by_name(name)
    all(:name => name, :order => [:id.desc])
  end


end

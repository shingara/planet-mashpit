class Feed
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :unique => true, :nullable => :false

  def self.find_by_name(name)
    all(:name => name, :order => [:id.desc])
  end


end

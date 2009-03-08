class Item
  include DataMapper::Resource
  
  property :id, Serial
  property :feed_id, Integer, :nullable => false
  property :title, String, :nullable => false, :length => 255
  property :content, Text, :nullable => false
  property :author, String, :length => 255
  property :permalink, String, :length => 255
  belongs_to :feed
  validates_is_unique :permalink
end

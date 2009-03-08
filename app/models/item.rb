class Item
  include DataMapper::Resource
  
  property :id, Serial
  property :feed_id, Integer, :nullable => false
  property :title, String, :nullable => false, :length => 255
  property :content, Text, :nullable => false
  property :author, String, :length => 255
  property :permalink, String, :length => 255, :nullable => false
  property :created_at, DateTime, :nullable => false
  belongs_to :feed
  validates_is_unique :permalink
  is_paginated :per_page => 20
  has_tags_on :tags, :categories
end

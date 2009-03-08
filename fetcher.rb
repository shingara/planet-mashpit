require 'rss/1.0' # gem install rubyrss
require 'rss/2.0'

raise "Run this script with `merb --script-runner fetcher.rb'" unless defined?(Merb)

USER_AGENT = "Planet-Mashpit/0.1 (github.com/shingara/planet-mashpit)"

Feed.all.each do |feed|
  feed.last_fetched_at = DateTime.now
  begin
    saved = 0
    pf = RSS::Parser.parse(open(feed.feed_url,"User-Agent" => USER_AGENT).read, false)
    pf.items.each do |article|
      t = Item.new({:title => article.title, :permalink => article.link, :feed_id => article.id, :author => article.author, :content => article.description})
      saved += 1 if t.save
    end
  rescue
    feed.last_fetch_successful = false
    feed.last_fetch_message = "ERROR: #{$!}"
    feed.save
    puts "Error when working on feed ##{feed.id} : #{$!}" if Merb.env=="development"
    next
  end
  feed.last_fetch_successful = true
  feed.last_fetch_message = "OK, imported #{saved} items"
  feed.save
end

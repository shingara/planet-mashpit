require 'rss/1.0' # gem install rubyrss
require 'rss/2.0'

raise "Run this script with `merb --script-runner fetcher.rb'" unless defined?(Merb)

USER_AGENT = "Planet-Mashpit/0.1 (github.com/shingara/planet-mashpit)"

Feed.all.each do |feed|
  feed.last_fetched_at = DateTime.now
  begin
    saved = 0
    puts "Fetching #{feed.id}"
    pf = RSS::Parser.parse(open(feed.feed_url,"User-Agent" => USER_AGENT).read, false)
    puts "Parsing feed"
    pf.items.each do |article|
      t = Item.new({:title => article.title, :permalink => article.link, :feed_id => feed.id, :author => article.author, :content => article.description, :created_at => article.pubDate})
      #tags = []
      article.categories.each do |tag|
        t.tag_list << tag.content
      end
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

FileUtils.rm_f(File.join(Merb::Cache[:page_store].stores[0].dir, 'index.html'))
FileUtils.rm_f(File.join(Merb::Cache[:page_store].stores[0].dir, 'page'))

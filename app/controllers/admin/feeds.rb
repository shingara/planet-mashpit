class Feeds < Application
  # provides :xml, :yaml, :js

  def index
    @feeds = Feed.all
    display @feeds
  end

  def show(id)
    @feed = Feed.get(id)
    raise NotFound unless @feed
    display @feed
  end

  def new
    only_provides :html
    @feed = Feed.new
    display @feed
  end

  def edit(id)
    only_provides :html
    @feed = Feed.get(id)
    raise NotFound unless @feed
    display @feed
  end

  def create(feed)
    @feed = Feed.new(feed)
    if @feed.save
      redirect resource(:admin, @feed), :message => {:notice => "Feed was successfully created"}
    else
      message[:error] = "Feed failed to be created"
      render :new
    end
  end

  def update(id, feed)
    @feed = Feed.get(id)
    raise NotFound unless @feed
    if @feed.update_attributes(feed)
       redirect resource(:admin, @feed)
    else
      display @feed, :edit
    end
  end

  def destroy(id)
    @feed = Feed.get(id)
    raise NotFound unless @feed
    if @feed.destroy
      redirect resource(:admin, :feeds)
    else
      raise InternalServerError
    end
  end

end # Feeds

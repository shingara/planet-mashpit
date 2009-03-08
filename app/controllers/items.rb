class Items < Application

  def index
    @current_page = params[:page] ? params[:page].to_i : 1
    @page_count, @items = Item.paginated :page => @current_page, :per_page => 20, :order => [:created_at.desc]
    display @items
  end
  
  def tag(tag)
    @items = Item.tagged_with(tag)
    display @items
  end
  
end

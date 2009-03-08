module Admin
  class Users < Application
    # provides :xml, :yaml, :js
    
    # No authentification send if no user
    before :ensure_authenticated, :if => Proc.new { !User.first.nil? }, :only => [:new, :create]
    before :ensure_authenticated, :exclude => [:new, :create]
  
    def index
      @user = User.all
      display @user
    end
  
    def show(id)
      @user = User.get(id)
      raise NotFound unless @user
      display @user
    end
  
    def new
      only_provides :html
      @user = User.new
      display @user
    end
  
    def edit(id)
      only_provides :html
      @user = User.get(id)
      raise NotFound unless @user
      display @user
    end
  
    def create(user)
      @user = User.new(user)
      if @user.save
        redirect resource(:admin, @user), :message => {:notice => "User was successfully created"}
      else
        message[:error] = "User failed to be created"
        render :new
      end
    end
  
    def update(id, user)
      @user = User.get(id)
      raise NotFound unless @user
      if @user.update_attributes(user)
         redirect resource(:admin, @user)
      else
        display @user, :edit
      end
    end
  
    def destroy(id)
      @user = User.get(id)
      raise NotFound unless @user
      if @user.destroy
        redirect resource(:user)
      else
        raise InternalServerError
      end
    end
  
  end # User
end # Admin

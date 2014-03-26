class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def index
    @micropost  = current_user.microposts.build
    @feed_items = Micropost.all.paginate(page: params[:page])
    render 'static_pages/home'
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    ## yet another `correct_user` imprementation
    # def correct_user
    #   @micropost = current_user.microposts.find(params[:id])
    # rescue
    #   redirect_to root_url
    # end

end

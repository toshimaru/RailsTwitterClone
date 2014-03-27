class TweetsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  # TODO: test
  def index
    @tweet = current_user.tweets.build
    @feed_items = Tweet.all.paginate(page: params[:page])
    render 'static_pages/home'
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    else
      # TODO:
      #  redirect_to root
      #    show error with `flash`
      #  write test for @feed_items
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @tweet.destroy
    redirect_to root_url
  end

  private

    def tweet_params
      params.require(:tweet).permit(:content)
    end

    def correct_user
      @tweet = current_user.tweets.find_by(id: params[:id])
      redirect_to root_url if @tweet.nil?
    end

    ## yet another `correct_user` imprementation
    # def correct_user
    #   @micropost = current_user.tweets.find(params[:id])
    # rescue
    #   redirect_to root_url
    # end

end

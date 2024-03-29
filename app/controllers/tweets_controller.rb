class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]

  # GET /tweets
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
  end
  # GET /tweets/1
  def show
    authorize @tweet
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  def create
   @tweet = Tweet.new(tweet_params) 
    @tweet.user_id = current_user.id

    if @tweet.save
      if !@tweet.replied_to_id?
        redirect_to tweets_path
      else 
        redirect_to tweet_path(@tweet.replied_to_id)
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tweets/1
  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: "Tweet was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet.destroy
    redirect_to tweets_url, notice: "Tweet was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:body, :replies_count, :likes_count, :user_id, :replied_to_id)
    end
end

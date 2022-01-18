class AuctionsController < ApplicationController

  def index

  end
   
  def new

    @post = Post.find(params[:post_id])

    @auction = Auction.new
  end

end

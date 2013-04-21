class MicropostsController < ApplicationController
  # The filter applies to all (both)
  # of the methods so we don't need any restrictions.
  before_filter :signed_in_user

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = Array.new
      render 'static_pages/home'
    end
  end

  def destroy
    # I had to add this line to get the code to work.
    # Otherwise @micropost wasn't defined and ruby would
    # throw a NoMethodError.
    @micropost = current_user.microposts.find_by_id(params[:id])
    @micropost.destroy
    redirect_to root_url
  end

  private

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
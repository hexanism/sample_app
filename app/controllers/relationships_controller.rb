class RelationshipsController < ApplicationController
  # Guest users should have no interactions
  # with relationships or this controller.
  #
  # If a guest were to access either of the methods,
  # current_user would be nil anyway, and so technically
  # this filter is unnecessary.
  # Better safe than sorry.
  before_filter :signed_in_user

  def create
    # Look up the id of the user that is being followed.
    # @user is NOT the user that clicked the button,
    # it is the user whose page we are on currently.
    @user = User.find(params[:relationship][:followed_id])
    # current_user is the user that clicked the button.
    current_user.follow!(@user)
    # Is this redirect basically just a refresh?
    # If so why can't we just use AJAX or similar?
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    # The id passed here is the id of the relationship.
    # So we retrieve that relationship and then get the followed
    # member of the relationship.
    @user = Relationship.find(params[:id]).followed
    # current_user is unfollowing @user.
    current_user.unfollow!(@user)
    # Same as above...(?)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
class DonationsController < ApplicationController
  before_action :set_tweet, only: [:create]

  def create
    @donation = @tweet.donations.create(donation_params)
    if @donation.save
      # @donation.create_notification_donation!(current_user, @donation.id)
      gets_all_donations
      @donation = Donation.new
      # redirect_to tweet_path(@tweet.id)
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def gets_all_donations
    @donations = @tweet.donations.sum(:amount)
  end

  def donation_params
    params.require(:donation).permit(:amount).merge(user_id: current_user.id)
  end
end

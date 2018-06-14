class HomeController < ApplicationController
  skip_before_action :require_admin_subscriber
  before_action :go_home, only: [:subscribe, :do_subscribe]

  def who
  end

  def subscribe
    @subscriber = Subscriber.new
  end

  def do_subscribe
    @subscriber = Subscriber.new(subscriber_params)

    respond_to do |format|
      if @subscriber.save
        Subscription.add_comic_sub(@subscriber.id)
        Subscriber.send_access_token_email(@subscriber)
        format.html { redirect_to root_url, notice: 'Subscriber was successfully created.' }
      else
        format.html { render :subscribe }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def subscriber_params
    params.require(:subscriber).permit(:firstname, :email)
  end
end

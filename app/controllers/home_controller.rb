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

    if @subscriber.save
      Subscription.add_comic_sub(@subscriber.id)
      Subscriber.send_access_token_email(@subscriber)

      redirect_to root_url, notice: 'Subscriber was successfully created.'
    else
      render_message(:error, :unprocessable_entity, @subscriber.errors.full_messages.join(', '))
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def subscriber_params
    params.require(:subscriber).permit(:firstname, :email)
  end
end

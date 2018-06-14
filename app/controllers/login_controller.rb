class LoginController < ApplicationController
  skip_before_action :require_admin_subscriber

  def show
    redirect_to root_url if logged_in
  end

  def send_magic_link
    user = Subscriber.find_by(email: params[:email])

    if user.present?
      ActivateSubscriptionMailer.do_send_magic_link(user).deliver_now
    end

    flash[:primary] = 'If have subscribed to the newsletter you will receive an email shortly, then just follow the instruction on that email.'
    redirect_to root_url
  end

  def google_auth
    request_hash = request.env["omniauth.auth"]
    if request_hash[:extra][:id_info][:email_verified] && request_hash[:info][:email].present?
      @subscriber = Subscriber.find_by(email: request_hash[:info][:email])

      if @subscriber
        do_login
      else
        @subscriber = Subscriber.new(google_strong_params(request_hash))

        if @subscriber.save
          Subscription.add_comic_sub(@subscriber.id)
          flash[:success] = "Welcome #{@subscriber.firstname} your subscription is now active."
          do_login
        else
          flash[:danger] = 'Subscriber not active.'
          redirect_to root_url
        end
      end
    else
      flash[:danger] = 'Invalid Auth.'
      redirect_to root_url
    end
  end

  def validate_user
    ppr = BCrypt::Password.new(URI.decode(params[:ppr]))

    @subscriber = Subscriber.find_by(token: URI.decode(params[:salt]))

    if @subscriber.present? && ppr == @subscriber.email
      @subscriber.update_attribute(:verified, true)
      flash[:success] = "Welcome #{@subscriber.firstname} !"
      do_login
    else
      flash[:danger] = 'Subscriber not active or invalid.'
      redirect_to root_url
    end
  end

  def destroy
    @current_subscriber = session[:current_subscriber_id] = nil
    reset_session
    redirect_to root_url
  end

  private
  def google_strong_params(request_hash)
    params = ActionController::Parameters.new(
      subscriber: {
        firstname: request_hash[:info][:first_name],
        email: request_hash[:info][:email],
        verified: true
      }
    )

    params.require(:subscriber).permit(:firstname, :email, :verified)
  end

  def do_login
    session[:current_subscriber_id] = @subscriber.id
    redirect_to dashboard_show_url
  end
end
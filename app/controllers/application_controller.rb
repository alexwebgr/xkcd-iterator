class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session
  before_action :require_admin_subscriber

  helper_method :current_subscriber, :logged_in, :admin_subscriber

  def current_subscriber
    @current_subscriber ||= Subscriber.find_by(id: session[:current_subscriber_id])
  end

  def logged_in
    current_subscriber.present?
  end

  def admin_subscriber
    logged_in ? current_subscriber.super : false
  end

  def require_admin_subscriber
    redirect_to root_url unless admin_subscriber
  end

  def go_home
    redirect_to iterator_show_path if logged_in
  end

  def require_login
    unless logged_in
      flash[:primary] = 'You need to be logged in to perform this action.'
      redirect_to root_url
    end
  end
end

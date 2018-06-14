class DashboardController < ApplicationController
  before_action :require_login
  skip_before_action :require_admin_subscriber

  def show
  end

  def remove_from_faves
    current_subscriber.favorites.destroy(params[:favorite_id])

    redirect_back(fallback_location: dashboard_show_path)
  end

  def activate_subscription
    Subscription.add_comic_sub(params[:subscriber_id])

    redirect_back(fallback_location: dashboard_show_path)
  end

  def deactivate_subscription
    Subscription.remove_comic_sub(params[:subscriber_id])

    redirect_back(fallback_location: dashboard_show_path)
  end
end

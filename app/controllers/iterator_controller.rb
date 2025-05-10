class IteratorController < ApplicationController
  before_action :require_login, only: [:add_to_faves, :remove_from_faves]
  skip_before_action :require_admin_subscriber, except: [:update_tree]
  before_action :set_comic, only: [:show, :add_to_faves]

  def show
    if params[:comic_num].nil?
      params[:comic_num]  = Comic.last_num
    end
  end

  def add_to_faves
    Favorite.find_or_create_by({
                                 subscriber_id: current_subscriber.id,
                                 comic_id: @comic.id
                               })

    redirect_back(fallback_location: root_url)
  end

  def remove_from_faves
    current_subscriber.favorites.destroy(params[:favorite_id])

    redirect_back(fallback_location: root_url)
  end

  def update_tree
    Comic.update_tree
    flash[:success] = 'Tree has been updated'

    redirect_to root_url
  end

  private
  def set_comic
    num = params[:comic_num]

    if num.to_i > Comic.last_num || num.blank?
      num = Comic.last_num
    end

    @comic = Comic.by_num(num)
  end
end

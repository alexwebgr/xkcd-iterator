class IteratorController < ApplicationController
  before_action :require_login, only: [:add_to_faves, :remove_from_faves]
  skip_before_action :require_admin_subscriber, except: [:update_tree]
  before_action :set_comic, only: [:show, :add_to_faves]

  def show
    if params[:comic_num].nil?
      params[:comic_num] = Comic.last_num
    end
  end

  def add_to_faves
    comic = Comic.find_by(id: params[:comic_id])
    comics_fave = current_subscriber.favorites.new(comic: comic)

    if comics_fave.save
      render turbo_stream: turbo_stream.update("comic-actions-#{comic.id}",
        partial: 'comic_actions',
        locals: { comic_id: comic.id })
    else
      render_message(:danger, :unprocessable_entity, comics_fave.errors.full_messages.join(', '))
    end
  end

  def remove_from_faves
    current_subscriber.favorites.where(comic_id: params[:comic_id]).destroy_all

    render turbo_stream: turbo_stream.update("comic-actions-#{params[:comic_id]}",
      partial: 'comic_actions',
      locals: { comic_id: params[:comic_id] })
  end

  def update_tree
    ComicImporter.call
    flash[:success] = 'Tree has been updated'

    redirect_to root_url
  end

  private
  def set_comic
    num = params[:comic_num]
    last_num = Comic.last_num

    if num.to_i > last_num || num.blank?
      num = last_num
    end

    @comic = Comic.by_num(num)
  end
end

class PicturesController < ApplicationController

  before_action :ensure_logged_in, except: [:show, :index]
  before_action :new_picture, only: [:new, :create]
  before_action :select_picture, except: [:index, :new, :create]
  before_action :write_picture, only: [:create, :update]
  
  def index
    @pictures = Picture.all

    @most_recent_pictures = Picture.created_after(1.month.ago)
    @month_old = Picture.created_before(1.month.ago)
    @pictures_2018 = Picture.pictures_created_in_year(2018)
  end

  def show
  
  end

  def new

  end

  def create
    if @picture.save
      # if the picture gets saved, generate a get request to "/pictures" (the index)
      redirect_to :root
    else
      # otherwise render new.html.erb
      render new_picture_path
    end
  end

  def edit

  end

  def update
    if @picture.save
      redirect_to picture_path(@picture)
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to :root
  end

  private

  def new_picture
    @picture = Picture.new
  end

  def select_picture
    @picture = Picture.find(params[:id])
  end

  def write_picture
    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
  end
end

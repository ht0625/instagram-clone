class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def index
    @pictures = Picture.all.order(created_at: :desc)
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
  end

  def edit
  end

  def create
    @picture = current_user.pictures.build(picture_params)

    respond_to do |format|
      if @picture.save
        #PictureMailer.picture_mail(@picture).deliver
        format.html { redirect_to pictures_path, notice: '投稿しました' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to pictures_path, notice: '更新しました' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_path, notice: '削除しました' }
      format.json { head :no_content }
    end
  end

  private
  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image,:image_cache, :content)
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def ensure_correct_user
    if current_user.id !=  @picture.user_id
      redirect_to pictures_path,notice: 'アクセスできません'
    end
  end
  def edit_correct_user
    if current_user.id !=  params[:id].to_i
      redirect_to new_user_path,notice: 'アクセスできません'
    end
  end
end

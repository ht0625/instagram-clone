class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture
    mail to: "hiirookii0625@gmail.com", subject: "投稿の確認メール"
  end
end

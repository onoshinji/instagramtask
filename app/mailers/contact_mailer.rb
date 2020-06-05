class ContactMailer < ApplicationMailer
  # ここでは引数としてcontact_mail(contact)で引数の値を受け取っています。
  def contact_mail(contact)
    #@contact = contactとすることでお問い合わせをした人の情報をViewファイルに渡すことができます。
    @contact = contact
    @user = current_user
    mail to: "yjsnpi555@gmail.com", subject: "お問い合わせの確認メール"
  end
end

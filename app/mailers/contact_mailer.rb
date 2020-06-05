class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    #PostsControllerのcreateアクションから引数contactに
    @contact = contact
    # メソッド内で@contact = contactとしているのは@contactをView(contact_mail.html.erb)で使用するため。
    #下記に記述したコードで投稿した本人のアドレスに確認メールをとばすもの。
    mail to: "#{@contact.user.email}", subject: "あなたの記事が投稿されました"
  end
end

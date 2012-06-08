class AdminMailer < ActionMailer::Base
  default to: "reednj77@gmail.com",
          from: "notifications@resume.nickjreed.com"

  def contact(info)
    @contact_info = info
    mail :subject => "New Resume Contact Submission"
  end
end

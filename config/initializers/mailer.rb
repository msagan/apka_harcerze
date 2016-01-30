ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "apka.zhr.com",
  :user_name            => "apkazhr",
  :password             => Rails.application.secrets[:mailer_password],
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "http://apka.zhr.pl/"

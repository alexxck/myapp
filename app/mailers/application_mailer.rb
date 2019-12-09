# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'myappblog1@gmail.com'
  layout 'mailer'
end

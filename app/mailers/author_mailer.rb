# frozen_string_literal: true

class AuthorMailer < ApplicationMailer
  default from: 'myappblog1@gmail.com'

  def registration_confirmation(author)
    @author = author
    mail to: author.email, subject: 'Registration Confirmation on myapp blog'
  end

  def password_reset(author)
    @author = author
    mail to: author.email, subject: 'Password Reset for myapp blog'
  end
end

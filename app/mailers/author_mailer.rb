# frozen_string_literal: true

class AuthorMailer < ApplicationMailer
  default :from => "application_name@domain.com"

  def registration_confirmation(author)
    @author = author
    mail(:to => "#{author.full_name} <#{author.email}", :subject => "confirm your registration on myapp blog")
  end
end
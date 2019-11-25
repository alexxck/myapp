# frozen_string_literal: true

module ApplicationHelper
  def current_author
    if session[:Author_id]
      @current_author ||= Author.find(session[:Author_id])
    else
      @current_author = nil
    end
  end

  def updated(sample)
    true if sample.updated_at.to_s != sample.created_at.to_s
  end
end

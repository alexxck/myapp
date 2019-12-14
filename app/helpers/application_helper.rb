# frozen_string_literal: true

module ApplicationHelper
  def current_author
    current_user
  end

  def updated(sample)
    true if sample.updated_at.to_s != sample.created_at.to_s
  end

  def check_comment_rights(current_user, comment)
    if (current_user.id == comment.author_id && Time.now - comment.created_at < 3600) || (current_user.admin == true)
      true
    end
  end

  def pop_up
    true if cookies[:actions] % 5 == 0
  end
end

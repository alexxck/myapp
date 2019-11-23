module SessionsHelper
  def current_author
    if session[:Author_id]
      @current_author ||= Author.find(session[:Author_id])
    else
      @current_author = nil
    end
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :setting_meta_tags


  private

  def setting_meta_tags
    set_meta_tags :site => Setting.app_name,
      :description => Setting.description,
      :keywords => Setting.keywords,
      :reverse => true
  end


end

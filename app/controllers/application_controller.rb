require 'csv'

class ApplicationController < ActionController::Base
  helper_method :notifications

  def notifications
    @notifications ||= NotificationService.current_notifications(session)
  end
end


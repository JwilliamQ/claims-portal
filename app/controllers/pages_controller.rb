class PagesController < ApplicationController
  # index is a public page
  def index;
  Rails.logger.info "🥸current user: #{current_user&.inspect}"
  end
end

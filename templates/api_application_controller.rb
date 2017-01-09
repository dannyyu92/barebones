class Api::V1::ApplicationController < ActionController::Base
  include ApiDefaults
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery unless: -> { request.format.json? }
end
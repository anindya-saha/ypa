class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  before_filter :set_is_admin
  before_filter :set_user_id

  ############################################################
  # set_                                                     #
  ############################################################
  def set_is_admin
    # need to assign from session variable
    if user_signed_in?
      @is_admin = current_user.admin
    else
      @is_admin = false
    end
  end

  def set_user_id
    if user_signed_in?
      @user_id = current_user.id
    else
      @user_id = nil
    end
  end

  require 'will_paginate/array'
end

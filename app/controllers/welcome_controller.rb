class WelcomeController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end

  def index
    respond_to do |format|
      format.html # show.html.erb
    end
  end
end

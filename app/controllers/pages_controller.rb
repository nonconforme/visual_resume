class PagesController < ApplicationController
  def home
    @page = %w[about contact education experience portfolio skills].include?(params[:page]) ? params[:page] : 'home'
    render @page
  end
  
  def contact
    AdminMailer.contact(params['contact']).deliver
    render :text => 'yes'
  end
end
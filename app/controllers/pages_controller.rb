class PagesController < ApplicationController
  before_filter :validate_page, :only => :home
  
  def home
    render @page
  end
  
  def contact
    AdminMailer.contact(params['contact']).deliver
    render 'contact_submission'
  end
  
  private
  
  def validate_page
    is_page = %w[about contact education experience portfolio skills].include?(params[:page])
    redirect_to :root if params[:page] && !is_page
    @page = is_page ? params[:page] : 'home'
  end
end
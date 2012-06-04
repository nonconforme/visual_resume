class PagesController < ApplicationController
  def home
    @page = %w[about contact education experience portfolio skills].include?(params[:page]) ? params[:page] : 'home'
    respond_to do |format|
      format.html { render @page }
      format.js { render @page }
    end
  end
  
  def contact
    AdminMailer.contact(params['contact']).deliver
    render :text => 'yes'
  end
end
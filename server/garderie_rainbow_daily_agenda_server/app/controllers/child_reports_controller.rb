class ChildReportsController < ApplicationController
  respond_to :json
  
  def create    
    @child_report = ChildReport.new(params[:child_report])
    if @child_report.save
      head :ok
    else
      render :json => @child_report.errors
    end
  end
end

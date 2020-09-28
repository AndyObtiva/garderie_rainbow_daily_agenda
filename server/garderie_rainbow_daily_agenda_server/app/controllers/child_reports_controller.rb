
class ChildReportsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create    
    Rails.logger.info params['child_report']
    
    @child_report = ChildReport.new(child_object: params['child_report'])
    Rails.logger.info @child_report.inspect
    if @child_report.save
      head :ok
    else
      render :json => @child_report.errors
    end
  end

#   private
#     
#   def child_report_params
#     Rails.logger.info params.inspect
#     Rails.logger.info params.require('child_report').inspect
#     params.require('child_report').permit(:child_object)
#   end  
end

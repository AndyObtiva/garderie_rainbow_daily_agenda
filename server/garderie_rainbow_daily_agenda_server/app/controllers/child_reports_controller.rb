
class ChildReportsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    pd child_report_params
    @child_report = ChildReport.new(child_object: child_report_params)
    Rails.logger.info @child_report.inspect
    if @child_report.save
      head :ok
    else
      render :json => @child_report.errors
    end
  end

  private

  def child_report_params
    params.permit(:child_report).require(:child_report)
  end
end

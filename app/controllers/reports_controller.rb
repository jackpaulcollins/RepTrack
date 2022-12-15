class ReportsController < ApplicationController
  include ReportPostConcern
  before_action :authenticate_user!
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /reports
  def index
    @pagy, @reports = pagy(Report.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @reports
  end

  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new

    # Uncomment to authorize with Pundit
    # authorize @report
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params.merge(user_id: current_user.id))

    # Uncomment to authorize with Pundit
    # authorize @report

    respond_to do |format|
      if @report.save
        post_to_slack(@report)
        format.html { redirect_to root_url, notice: "Report was successfully created." }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: "Report was successfully updated." }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @report
  rescue ActiveRecord::RecordNotFound
    redirect_to reports_path
  end

  def ensure_correct_user
    redirect_to reports_path unless @report.user_id == current_user.id
  end

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:user_id, :account_id, :points, :rep_type, :rep_count, :report_date)

    # Uncomment to use Pundit permitted attributes
    # params.require(:report).permit(policy(@report).permitted_attributes)
  end
end

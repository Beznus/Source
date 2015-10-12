class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :edit, :update, :destroy]

  # GET /emails
  # GET /emails.json
  def index
    @emails = Email.all
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
  end

  def reprocess
    @email.associate_company!
    @email.associate_resource!
    @email.match_patterns!
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to company_emails_path(current_user.company)
  end

  def create
    @email = Email.new(
      from: params['sender'],
      recipient: params['recipient'],
      subject: params['subject'],
      body_html: params['body-html'],
      body_plain: params['body-plain']
    )

#    @email.associate_company!
    if @email.company_id.blank?
      render :text => "SPAM"
      return
    end

#    @email.associate_resource!

    if (@email.save!)
      begin
#        @email.match_patterns!
        rescue
      end
      render :text=> "OK"
    else
      render :text => "FAIL"
    end
  end


  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url, notice: 'Email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:company_id, :product_id, :recipient, :sender, :from, :body, :body_plain, :body_html, :created_at, :updated_at, :subject)
    end
end

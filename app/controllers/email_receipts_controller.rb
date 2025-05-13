class EmailReceiptsController < ApplicationController
  before_action :set_email_receipt, only: [:show, :edit, :update, :destroy]

  # GET /email_receipts
  # GET /email_receipts.json
  def index
    @email_receipts = EmailReceipt.all
  end

  # GET /email_receipts/1
  # GET /email_receipts/1.json
  def show
  end

  # GET /email_receipts/new
  def new
    @email_receipt = EmailReceipt.new
  end

  # GET /email_receipts/1/edit
  def edit
  end

  # POST /email_receipts
  # POST /email_receipts.json
  def create
    @email_receipt = EmailReceipt.new(email_receipt_params)

    respond_to do |format|
      if @email_receipt.save
        format.html { redirect_to @email_receipt, notice: 'Email receipt was successfully created.' }
        format.json { render :show, status: :created, location: @email_receipt }
      else
        format.html { render :new }
        format.json { render json: @email_receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_receipts/1
  # PATCH/PUT /email_receipts/1.json
  def update
    respond_to do |format|
      if @email_receipt.update(email_receipt_params)
        format.html { redirect_to @email_receipt, notice: 'Email receipt was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_receipt }
      else
        format.html { render :edit }
        format.json { render json: @email_receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_receipts/1
  # DELETE /email_receipts/1.json
  def destroy
    @email_receipt.destroy
    respond_to do |format|
      format.html { redirect_to email_receipts_url, notice: 'Email receipt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_receipt
      @email_receipt = EmailReceipt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_receipt_params
      params.require(:email_receipt).permit(:subscriber_id, :comic_id, :subscription_id)
    end
end

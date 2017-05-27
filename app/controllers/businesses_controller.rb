class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :update, :destroy]

  # GET /businesses
  def index
    if params[:page]
      page = params[:page][:number]
      per_page = params[:page][:size]
      b = params[:search] ? Business.where("name ilike ?", "%#{params[:search]}%") : Business.all
      @businesses = b.page(params[:page][:number]).per(params[:page][:size])
    else
      per_page = nil
      @businesses = Business.all
    end

    render json: @businesses, meta: { pagination: {
      per_page: per_page,
      total_pages: @businesses.total_pages,
      total_objects: @businesses.total_count }}
  end

  # GET /businesses/1
  def show
    render json: @business
  end

  # POST /businesses
  def create
    @business = Business.new(business_params)

    if @business.save
      render json: @business, status: :created, location: @business
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /businesses/1
  def update
    if @business.update(business_params)
      render json: @business
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end

  # DELETE /businesses/1
  def destroy
    @business.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def business_params
      params.require(:business).permit(:name)
    end
end

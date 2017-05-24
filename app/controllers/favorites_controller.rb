class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:show, :update, :destroy]

  # GET /favorites
  def index
    if params.has_key? :business_id
      f = Favorite.find_by business_id: params[:business_id]
      unless f.nil?
        @favorites = [].push f
      else
        return render json: {data: []}
      end
    else
      @favorites = Favorite.all
    end

    render json: @favorites
  end

  # GET /favorites/1
  def show
    render json: @favorite, include: ['business']
  end

  # POST /favorites
  def create
    @favorite = Favorite.new(favorite_params)

    if @favorite.save
      render json: @favorite, status: :created, location: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /favorites/1
  def update
    if @favorite.update(favorite_params)
      render json: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favorites/1
  def destroy
    @favorite.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def favorite_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end

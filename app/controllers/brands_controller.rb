class BrandsController < ApplicationController
  def index
    brands = load_brands
    render json: brands, status: 200
  end

  def show
    if brand
      render json: brand, status: 200
    else
      render json: {}, status: 404
    end
  end

  def create
    brand = Brand.new(get_params)

    if brand.save
      render json: brand, status: 201
    else
      render json: {}, status: 422
    end
  end

  def update
    brand.update_attributes(get_params)
    if brand.save
      render json: {}, status: 204
    else
      render json: {}, status: 422
    end
  end

  def destroy
    if brand
      brand.destroy
      render json: {}, status: 204
    else
      render json: {}, status: 400
    end
  end

  private

  def brand
    @brand ||= Brand.find(params.fetch :id)
  end

  def load_brands
    if params.has_key?(:ids)
      Brand.where(id: params[:ids])
    else
      Brand.all
    end
  end

  def get_params
    params[:brand].permit(:name)
  end
end

class ProfilesController < ApplicationController
  def index
    profiles = load_profiles
    render json: profiles, status: 200
  end

  def show
    if profile
      render json: profile, status: 200
    else
      render json: {}, status: 404
    end
  end

  def create
    profile = Profile.new(get_params)

    if profile.save
      render json: profile, status: 201
    else
      render json: {}, status: 403
    end
  end

  def update
    profile.update_attributes(get_params)
    if profile.save
      render json: {}, status: 204
    else
      render json: {}, status: 403
    end
  end

  def destroy
    if profile
      profile.destroy
      render json: {}, status: 204
    else
      render json: {}, status: 404
    end
  end

  def add_brand
    if profile and brand
      profile.brands << brand
      render json: {}, status: 204
    else
      render json: {}, status: 403
    end
  end

  def remove_brand
    if profile and brand
      profile.brands.delete(brand)
      render json: {}, status: 204
    else
      render json: {}, status: 403
    end
  end


  private

  def load_profiles
    if params.has_key?(:brand)
      Brand.find(params[:brand].to_i).profiles
    else
      Profile.all
    end
  end

  def profile
    @profile ||= Profile.find(params.fetch :id)
  end

  def get_params
    puts params
    params[:profile].permit(:name)
  end

  def brand
    @brand ||= Brand.find(params.fetch :brand)
  end
end

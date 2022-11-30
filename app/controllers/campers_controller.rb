class CampersController < ApplicationController

    def index
        campers = Camper.all
        render json: campers.to_json(only: [:id, :name, :age])
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper
    rescue ActiveRecord::RecordNotFound
        render_not_found_response
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    private

    def render_not_found_response
        render json: {error: "Camper not found"}, status: :not_found
    end

    def camper_params
        params.permit(:name, :age)
    end

end

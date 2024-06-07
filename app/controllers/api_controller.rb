class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token, except: :docs
  before_action :set_current_user
  before_action :set_model, except: :docs

  def index
    render json: @model_class.all
  end

  def show
    render json: @model_class.find(params[:id])
  end

  def create
    resource = @model_class.new(resource_params)
    if resource.save
      render json: resource, status: :created
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  def update
    resource = @model_class.find(params[:id])
    if resource.update(resource_params)
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  def destroy
    resource = @model_class.find(params[:id])
    resource.destroy
    head :no_content
  end

  def docs
    render plain: Docs.generate
  end

  private

  def set_model
    @model_class = params[:model].classify.constantize
  end

  def resource_params
    params.permit(@model_class.permitted_attributes)
  end

  def set_current_user
    Current.user = request.headers['user'] || 'anonymous'
  end
end

class AppsController < ApplicationController
  def index
    @apps = App.all.order(:name)
  end

  def show
    @app = current_app
  end

  def edit
    @app = current_app
  end

  def job_spec
    @app = current_app
  end

  def deploy
    @app = current_app
  end

  def nomad
    @app = current_app
  end

  def new
    @app = App.new
  end

  def create
    @app = App.new(app_params)

    if @app.save
      flash[:notice] = "App has been created"
      redirect_to app_path(@app)
    else
      render action: :new
    end
  end

  def update
    @app = current_app

    if @app.update_attributes(app_params)
      flash[:notice] = "App has been updated. You will need to deploy again for any changes to take effect."
      redirect_to app_path(@app)
    else
      render action: :edit
    end
  end

  def destroy
    @app = current_app

    if AppDeletion.new(@app).delete! && @app.destroy
      flash[:notice] = "App has been removed from Nomad and deleted"
      redirect_to action: :index
    else
      flash[:error] = "Could not delete app"
      render action: :index
    end
  end

  private

  def app_params
    params.require(:app).permit(
      :name,
      :description,
      :ecr_repository,
      :job_spec,
      :auto_deploy,
      :auto_deploy_branch
    )
  end

  def current_app
    App.find_by(name: params[:id])
  end
end

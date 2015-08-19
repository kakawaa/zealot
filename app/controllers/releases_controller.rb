class ReleasesController < ApplicationController
  def upload
    render json: Release.first.to_json(include: [:app])
  end

  def edit
    @release = Release.find(params[:id])
  end

  def update
    @release = Release.find(params[:id])
    fail ActionController::RoutingError.new('这里没有你找的东西') unless @release

    @release.update!(changelog: params[:changelog])
    redirect_to app_release_path(@release.app.slug, @release.id)
  end
end
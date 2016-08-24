class RedmineIterationsController < ApplicationController
  unloadable
  helper :sort
  include SortHelper
  helper :queries
  include QueriesHelper

  def index
  	sort_init 'version.start_date', 'desc'
  	sort_update %w(projects.name versions.name versions.start_date versions.effective_date)

  	@projects = Project.joins("LEFT JOIN versions on projects.id = versions.project_id and versions.start_date = (select MAX(versions.start_date) from versions where versions.project_id = projects.id)")
  		.where("projects.status =  #{Project::STATUS_ACTIVE} ")
		.order(sort_clause)
  		#.order("projects.name")
  		#.order("versions.start_date desc")
  end
end

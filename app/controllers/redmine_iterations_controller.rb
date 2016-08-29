class RedmineIterationsController < ApplicationController
  unloadable
  helper :sort
  include SortHelper
  helper :queries
  include QueriesHelper

  before_filter :authorize_global

  def index
  	sort_init 'version.start_date', 'desc'
  	sort_update %w(projects.name vers ions.name versions.start_date versions.effective_date)

  	@projects = Project.joins("LEFT JOIN versions on projects.id = versions.project_id and versions.start_date = (select MAX(versions.start_date) from versions where versions.project_id = projects.id)")
  		.where("projects.status =  #{Project::STATUS_ACTIVE} ")
      .where("UCase(versions.name) like 'ITRATION%' or versions.name like 'SPRINT%'")
		.order(sort_clause)
  end
end

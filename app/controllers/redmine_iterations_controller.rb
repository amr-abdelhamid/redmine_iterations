class RedmineIterationsController < ApplicationController
  unloadable
  helper :sort
  include SortHelper
  helper :queries
  include QueriesHelper

  before_filter :authorize_global

  def index
  	sort_init 'version.start_date', 'desc'
  	sort_update %w(projects.name versions.name versions.start_date versions.effective_date)

  	@projects = Project.joins("LEFT JOIN versions on (projects.id = versions.project_id " +
        "and versions.start_date = (select MAX(v.start_date) from versions v where v.project_id = projects.id) " +
        "and (UCASE(versions.name) like 'ITER%' or UCASE(versions.name) like 'SPRINT%'))")
  		.where("projects.status =  #{Project::STATUS_ACTIVE}")
		  .order(sort_clause)

    # #remove unimportant projects
    # @projects.delete_if {|project| project.custom_fields.contain < 3}
    # @projects.each do |project|
    #   if project.custom_fields.include("type")
    #
    #   end
    # end
  end
end

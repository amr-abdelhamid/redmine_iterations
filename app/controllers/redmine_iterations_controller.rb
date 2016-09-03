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

    projects = Project.includes(:versions)
      .where("projects.status =  #{Project::STATUS_ACTIVE}")
      .order(sort_clause)

    @projects_and_last_iteration = Hash.new
    temp_iteration = nil
    projects.each do |temp_project|
      @projects_and_last_iteration[temp_project] = get_last_iteration_for_project(temp_project)
    end

  end

  private

  def get_last_iteration_for_project(project)
    last_iteration = nil
    project.versions.each do |v|
      if(v.name.downcase.include?('iteration') || v.name.downcase.include?('sprint'))
        if(last_iteration == nil || v.start_date > last_iteration.start_date)
          last_iteration = v
        end
      end
    end
    return last_iteration
  end
end

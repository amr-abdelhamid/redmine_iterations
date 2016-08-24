Redmine::Plugin.register :redmine_iterations do
  name 'Redmine Iterations plugin'
  author 'Amr Noaman'
  description 'This plugin introduces simple iterations into Redmine based on the versions model. Version start date is now 
  set by user, a new custom field whether the version represent an iteration or release is added,
  and a new page for iterations status is added.'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  menu :top_menu, :redmine_iterations, { :controller => 'redmine_iterations', :action => 'index' }, :caption => 'Iterations Status'
end

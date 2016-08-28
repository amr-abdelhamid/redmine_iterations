require File.expand_path('../../test_helper', __FILE__)

class RedmineIterationsControllerTest < ActionController::TestCase
	fixtures :users

	def test_index_without_permission
		get :index
		assert_response 302 #not authorized
	end

	def test_index_with_admin
		@request.session[:user_id] = 1 #admin

		get :index
		assert_response :success
		assert_template 'index'
	end

	def test_index_without_permission_should_fail
		user = @request.session[:user_id] = 2
		user.Role.remove_permission! :view_iterations_status

		get :index
		assert_response :success
		assert_template 'index'
	end

	def test_index_with_anonymous_with_permission
		Role.anonymous.add_permission! :view_iterations_status

		get :index
		assert_response :success
		assert_template 'index'
	end

	def test_index_with_anonymous_without_permission_should_fail
		Role.anonymous.remove_permission! :view_iterations_status

		get :index
		assert_response 302
	end
end

require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
	test "POST to create with a file should render total gross revenue" do
		assert_difference("Purchase.count('id')", 4) do
			post :create, :file => fixture_file_upload("example_input.tab")
		end

		assert_redirected_to root_path
		assert_equal flash[:notice], 95.0
	end

	test "POST to create without a file should redirect to form" do
		assert_no_difference("Purchase.count('id')") do
			post :create
		end

		assert_redirected_to root_path
		assert_nil flash[:notice]
	end
end
require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
	STRING = File.read(Rails.root.join("test/fixtures/example_input.tab"))
	CSV_STRING = CSV.parse(STRING, :col_sep => "\t", :headers => true)

	test "Purchase.import should save purchases from a tab-delimited string" do
		assert_difference("Purchase.count('id')", 4) { Purchase.import(STRING) }

		assert_equal Purchase.order("id").map(&:purchaser_name), CSV_STRING.map {|row| row[0]}

		assert_equal Purchase.order("id").map(&:item_description), CSV_STRING.map {|row| row[1]}

		assert_equal Purchase.order("id").map(&:merchant_address), CSV_STRING.map {|row| row[4]}

		assert_equal Purchase.order("id").map(&:merchant_name), CSV_STRING.map {|row| row[5]}

		assert_equal Purchase.sum(:item_price), 30.0

		assert_equal Purchase.sum(:purchase_count), 12
	end

	test "Purchase.import should return the total revenue from purchases saved" do
		assert_equal Purchase.import(STRING), 95.0
	end

	test "Purchase.import should return false if argument is blank" do
		assert_equal Purchase.import(nil), false
		assert_equal Purchase.import(""), false
	end
end
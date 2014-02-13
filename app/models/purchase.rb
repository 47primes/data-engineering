class Purchase < ActiveRecord::Base
	validate :purchaser_name, :presence => true
	validate :item_description, :presence => true
	validate :item_price, :presence => true, :numericality => true
	validate :purchase_count, :presence => true, :numericality => {:integer_only => true}
	validate :merchant_name, :presence => true
	validate :merchant_address, :presence => true

	def self.import(tab_string)
		return false if !tab_string.is_a?(String) || tab_string.empty?
		purchases = []
		total = CSV.parse(tab_string, :col_sep => "\t", :headers => true, :header_converters => lambda {|col| col.gsub(/\s+/,"_")}).reduce(0) do |memo, row|
			purchases << row.to_hash
			memo += row["item_price"].to_f * row["purchase_count"].to_f
		end
		Purchase.create! purchases
		total
	end
end
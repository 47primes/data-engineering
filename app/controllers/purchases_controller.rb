class PurchasesController < ApplicationController

	def create
		redirect_to root_path, :notice => Purchase.import(params[:file].try(:read))
	end

end
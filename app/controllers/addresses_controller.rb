class AddressesController < ApplicationController
  before_action :authenticate_user!
  
  def show
    address = ViaCepService.get_address(params[:cep])
    if address['erro']
      render json: { error: 'Address not found' }, status: :not_found
    else
      render json: address
    end
  end
end

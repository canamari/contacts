class ContactsController < ApplicationController
  before_action :set_contact, only: [:update, :destroy]

  def index
    if params[:query].present?
      @contacts = Contact.search(params[:query], where: { user_id: current_user.id })
    else
      @contacts = current_user.contacts
    end
    render json: @contacts
  end

  def create
    @contact = current_user.contacts.build(contact_params)
    set_coordinates
    if @contact.save
      render json: @contact, status: :ok
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def update
    @contact.assign_attributes(contact_params)
    set_coordinates
    if @contact.save
      render json: @contact, status: :ok
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    render json: { message: 'Contact deleted successfully.' }
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :cpf, :cep, :phone, :address)
  end

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

  def set_coordinates
    coordinates = GoogleMapsService.get_coordinates(@contact.address)
    @contact.latitude = coordinates.nil? ? nil : coordinates['lat'] 
    @contact.longitude = coordinates.nil? ? nil : coordinates['lng']
  end

end

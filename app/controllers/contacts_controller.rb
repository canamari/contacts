class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:query].present?
      @contacts = Contact.search(params[:query]).records.where(user_id: current_user.id)
    else
      @contacts = Contact.where(user_id: current_user.id)
    end
    render json: @contacts
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact, status: :ok
    else
      render json: contact.errors, status: :unprocessable_entity
    end
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact, status: :ok
    else
      render json: contact.errors, status: :unprocessable_entity
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :cpf, :cep, :phone, :address, :latitude, :longitude)
  end
end

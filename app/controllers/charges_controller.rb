module Amount
  def default_amount
    15_00
  end
end

class ChargesController < ApplicationController
  include Amount

  def new
    @amount = default_amount

    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Become a Premium Member today!",
      amount: @amount
    }
  end

  def create
    @amount = default_amount

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Blocipedia Premium Membership for #{customer.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for becoming a Premium Member!"
    redirect_to edit_user_registration_path(current_user)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

end

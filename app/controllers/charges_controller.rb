class ChargesController < ApplicationController
  @amount = Amount.default

  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Become a Premium Member today!",
      amount: @amount
    }
  end

  def create
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
    redirect_to user_path(current_user)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

end

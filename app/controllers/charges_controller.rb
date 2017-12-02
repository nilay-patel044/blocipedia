class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Upgrate to Premium Membership - #{current_user.email}",
      amount: 15_00
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    current_user.stripe_id = customer.id

    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 15_00,
      description: "Upgrade to Premium Membership - #{current_user.email}",
      currency: 'usd'
    )


    flash[:notice] = "Thanks for the payment, #{current_user.email}! You can now create and edit private wikis."
    current_user.role = :premium
    current_user.save!

    redirect_to wikis_path # or wherever

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    if customer.delete
      flash[:notice] = "\"#{current_user.email}\" was downgraded to standard successfully.\nAll associated Wiki's have been marked as PUBLIC."
      current_user.role = :member
      current_user.save!

      wikis = current_user.wikis
      wikis.each do |wiki|
        if wiki.private
          wiki.private = false
          wiki.save!
        end
      end

      redirect_to new_charge_path
    else
      flash.now[:alert] = "There was an error downgrading your account."
      redirect_to new_charge_path
    end
  end
end

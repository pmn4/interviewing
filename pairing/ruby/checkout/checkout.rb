require 'sinatra'

require_relative 'order'

# mongoid, get in here!
class Cart
end

# renders checkout form
post '/carts' do
end

post '/carts/:cart_id/coupons/:coupon_code' do |cart_id, coupon_code|
  cart = Cart.find(cart_id)
  cart.apply_code!(coupon_code)
  cart.to_json
end

post '/carts/:cart_id/promos/:promo_code' do |cart_id, promo_code|
  cart = Cart.find(cart_id)
  cart.apply_code!(promo_code)
  cart.to_json
end

post '/checkout' do
end

delete '/carts/:cart_id' do |cart_id|
end

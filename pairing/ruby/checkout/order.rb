require 'json'

class Order
  attr_reader :order_id
  attr_accessor :user_id, :style_name

  def initialize(attributes = {})
    @order_id = attributes[:order_id]
    @user_id = attributes[:user_id]
    @style_name = attributes[:style_name]
  end

  def invalid?
    user_id.nil? || style_name.nil?
  end

  def save
    @order_id = OrderService.save(user_id, style_name)
    self
  end

  def to_hash
    Hash[instance_variables.map do |iv|
      name = iv.to_s[1..-1].to_sym
      [name, send(name)]
    end]
  end

  def to_json
    to_hash.to_json
  end

  class << self
    def factory(type, attributes)
      if attributes[:promo_code]
        PromoOrder.new attributes
      elsif attributes[:coupon_code]
        CouponOrder.new attributes
      else
        Order.new attributes
      end
    end

    def find(order_id)
      Order.new order_id: order_id
    end
  end
end

class PromoOrder < Order
  attr_accessor :promo_code

  def initialize(attributes = {})
    super

    self.promo_code = attributes[:promo_code]
  end

  def invalid?
    super || promo_code.nil?
  end

  def save
    @order_id = OrderService.save(user_id, style_name, promo_code)
    self
  end
end

class CouponOrder < Order
  attr_accessor :coupon_code

  def initialize(attributes = {})
    super

    self.coupon_code = attributes[:coupon_code]
  end

  def invalid?
    super || coupon_code.nil?
  end

  def save
    @order_id = OrderService.save(user_id, style_name, nil, coupon_code)
    self
  end
end

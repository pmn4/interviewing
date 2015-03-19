require_relative 'spec_helper'

describe 'Checkout App' do
  context 'presenting the form' do
    it 'renders checkout form' do
      get '/checkout'

      expect(last_response).to be_ok
    end

    it 'renders checkout form with promo_code' do
      get '/checkout'

      expect(last_response.body).to include('name="promo_code"')
    end
  end

  context 'placing an order' do
    let(:order_id) { SecureRandom.random_number(100_000) }
    let(:style_name) { SecureRandom.hex }
    let(:promo_code) { SecureRandom.hex }
    let(:coupon_code) { SecureRandom.hex }

    it 'for simple data' do
      expect(OrderService).to receive(:save).with(order_id, style_name, nil, nil).and_return(order_id)

      post '/checkout', {
        order_id: order_id,
        style_name: style_name
      }
    end
  end
end

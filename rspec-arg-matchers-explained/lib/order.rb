class Order
  attr_reader :state, :payment_method, :items, :buyer_email

  def initialize(attrs)
    @state = attrs[:state] || :created
    @payment_method = attrs[:payment_method]
    @items = attrs[:items]
    @buyer_email = attrs[:buyer_email]
    @tax_calculator = tax_calculator
  end

  def checkout
    items_total = items.sum(&:total)
    tax = TaxCalculator.calculate(self)
    process_payment_status = PaymentGateway.process_payment(tax + items_total, gateway_hash)

    if process_payment_status == :success
      @state = :completed
      Mailer.send_mail(:order_success, @buyer_email)
    else
      @state = :payment_failed
    end
  end

  private

  attr_reader :tax_calculator

  def gateway_hash
    hash = {
      email: @buyer_email,
      payment_method: {
        kind: @payment_method.kind,
      }
    }

    case @payment_method.kind
    when "credit"
      hash[:payment_method].merge!({
        number: @payment_method.number,
        ccv: @payment_method.ccv,
        expiry: @payment_method.expiry
      })
    when "ebt"
      hash[:payment_method].merge!({
        account_no: @payment_method.account_no,
        routing_no: @payment_method.routing_no
      })
    end

    hash
  end
end

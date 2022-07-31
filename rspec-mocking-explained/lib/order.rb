class Order
  attr_reader :state, :payment_method, :items, :buyer_email

  def initialize(attrs)
    @state = attrs[:state] || :created
    @payment_method = attrs[:payment_method]
    @items = attrs[:items]
    @buyer_email = attrs[:buyer_email]
    # @tax_calculator = tax_calculator # not used
  end

  def checkout
    if process_payment_status == :success
      @state = :completed
      send_mail
    else
      @state = :payment_failed
    end
  end

  private

  attr_reader :tax_calculator

  def tax
    TaxCalculator.calculate(self)
  end

  def items_total
    items.sum(&:total)
  end

  def process_payment_status
    PaymentGateway.process_payment(tax + items_total, payment_method)
  end

  def send_mail
    Mailer.send_mail(:order_success, buyer_email)
  end
end

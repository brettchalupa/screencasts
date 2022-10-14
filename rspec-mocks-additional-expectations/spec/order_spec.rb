require 'spec_helper'

RSpec.describe Order do
  subject do
    Order.new(
      { state: :created,
        payment_method: payment_method,
        buyer_email: "buyer@example.com",
        items: items }
    )
  end

  let(:payment_method) { double("credit card") }
  let(:items) { [double("item 1", total: 15.0), double("item 2", total: 5.0)] }

  describe "#checkout" do
    before do
      expect(TaxCalculator).to receive(:calculate).with(subject) { 10.0 }
    end

    it "calls out to the payment gateway with the items' totals and tax" do
      expect(PaymentGateway).to receive(:process_payment).with(30.0, payment_method).and_return(:success).ordered

      subject.checkout
    end

    context "when the payment processes successfully" do
      before do
        allow(PaymentGateway).to receive(:process_payment) { :success }
      end

      it "sets the state to completed" do
        subject.checkout

        expect(subject.state).to eql(:completed)
      end

      it "emails the buyer" do
        expect(Mailer).to receive(:send_mail).with(:order_success, "buyer@example.com")

        subject.checkout
      end
    end

    context "when the payment processes unsuccessfully" do
      before do
        allow(PaymentGateway).to receive(:process_payment) { :failure }
      end

      it "sets the state to payment_failed" do
        subject.checkout

        expect(subject.state).to eql(:payment_failed)
      end

      it "does not send the order success email" do
        expect(Mailer).to_not receive(:send_mail)

        subject.checkout
      end
    end

    context "when the payment processing raises an exception" do
      before do
        allow(PaymentGateway).to receive(:process_payment).and_raise(GatewayError, "oh no gateway down!")
      end

      it "does not raise through" do
        expect { subject.checkout }.to_not raise_error
      end

      it "sets the state to payment_failed" do
        subject.checkout

        expect(subject.state).to eql(:payment_failed)
      end
    end
  end
end

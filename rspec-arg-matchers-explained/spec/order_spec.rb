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

  let(:payment_method) { double("credit card", kind: "credit", number: "424242424242", ccv: "123", expiry: "12/24") }
  let(:items) { [double("item 1", total: 15.0), double("item 2", total: 5.0)] }

  describe "#checkout" do
    before do
      expect(TaxCalculator).to receive(:calculate).with(subject) { 10.0 }
    end

    it "calls out to the payment gateway with the items' totals and tax" do
      expect(PaymentGateway).to receive(:process_payment)
        .with(30.0, anything) { :success }.ordered

      subject.checkout
    end

    it "includes the buyer's email in the params" do
      expect(PaymentGateway).to receive(:process_payment)
        .with(kind_of(Float), hash_including({
          email: "buyer@example.com"
        })) { :success }.ordered

      subject.checkout
    end

    context "when the payment_method is a credit_card" do
      # see payment_method above for the double under test

      it "calls out to the payment gateway with the properly formatted payment method" do
        expect(PaymentGateway).to receive(:process_payment)
          .with(kind_of(Float), hash_including({
            payment_method: {
              kind: "credit",
              number: "424242424242",
              ccv: "123",
              expiry: "12/24"
            }
          })) { :success }.ordered

        subject.checkout
      end
    end

    context "when the payment_method is ebt" do
      let(:payment_method) { double("ebt", kind: "ebt", account_no: "123456", routing_no: "98765") }

      it "calls out to the payment gateway with the properly formatted payment method" do
        expect(PaymentGateway).to receive(:process_payment)
          .with(kind_of(Float), hash_including({
            payment_method: {
              kind: "ebt",
              account_no: "123456",
              routing_no: "98765"
            }
          })) { :success }.ordered

        subject.checkout
      end
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
  end
end

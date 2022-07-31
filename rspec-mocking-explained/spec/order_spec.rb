require "spec_helper"
require "ostruct"

RSpec.describe Order do
  subject { Order.new({}) }

  describe :initialize do
    let(:state) { :state }
    let(:payment_method) { :payment_method }
    let(:items) { :items }
    let(:buyer_email) { :buyer_email }

    subject do
      Order.new(
        {
          state: state,
          payment_method: payment_method,
          items: items,
          buyer_email: buyer_email,
        },
      )
    end

    it { expect(subject.state).to eq :state }
    it { expect(subject.payment_method).to eq :payment_method }
    it { expect(subject.items).to eq :items }
    it { expect(subject.buyer_email).to eq :buyer_email }

    context "when state is missing" do
      let(:state) { nil }
      it { expect(subject.state).to eq :created }
    end
  end

  describe :checkout do
    let(:process_payment_status) { :success }
    before do
      allow(subject).to receive(:process_payment_status).and_return process_payment_status
      allow(subject).to receive(:send_mail)
    end
    it do
      subject.checkout
      expect(subject.state).to eq :completed
      expect(subject).to have_received(:send_mail)
    end

    context "not success" do
      let(:process_payment_status) { :not_success }
      it do
        subject.checkout
        expect(subject.state).to eq :payment_failed
        expect(subject).not_to have_received(:send_mail)
      end
    end
  end

  describe :private do
    describe :tax do
      it do
        allow(TaxCalculator).to receive(:calculate)
        subject.send :tax
        expect(TaxCalculator).to have_received(:calculate).with subject
      end
    end

    describe :items_total do
      before do
        allow(subject).to receive(:items) {
          [OpenStruct.new(total: 15.0), OpenStruct.new(total: 5.0)]
        }
      end
      it { expect(subject.send :items_total).to eq 20 }
    end

    describe :process_payment_status do
      before do
        allow(PaymentGateway).to receive(:process_payment)
        allow(subject).to receive(:tax) { 10 }
        allow(subject).to receive(:items_total) { 20 }
        allow(subject).to receive(:payment_method) { :payment_method }
      end

      it do
        subject.send :process_payment_status
        expect(PaymentGateway).to have_received(:process_payment).with(
          10 + 20,
          :payment_method,
        )
      end
    end

    describe :send_mail do
      before do
        allow(Mailer).to receive(:send_mail)
        allow(subject).to receive(:buyer_email) { :buyer_email }
      end

      it do
        subject.send :send_mail
        expect(Mailer).to have_received(:send_mail).with(:order_success, :buyer_email)
      end
    end
  end
end

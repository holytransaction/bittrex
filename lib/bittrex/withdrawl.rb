module Bittrex
  class Withdrawl < BaseBittrex
    attr_reader :id, :currency, :quantity, :address, :authorized,
                :pending, :canceled, :invalid_address,
                :transaction_cost, :transaction_id, :executed_at, :error

    def initialize(attrs = {})
      @id = attrs['PaymentUuid']
      @currency = attrs['Currency']
      @quantity = attrs['Amount']
      @address = attrs['Address']
      @authorized = attrs['Authorized']
      @pending = attrs['PendingPayment']
      @canceled = attrs['Canceled']
      @invalid_address = attrs['Canceled']
      @transaction_cost = attrs['TxCost']
      @transaction_id = attrs['TxId']
      @error = attrs['message']
      @executed_at = Time.parse(attrs['Opened'])
    end

    def self.all
      client.get('account/getwithdrawalhistory').map{|data| new(data) }
    end

    def self.transaction(transaction_id)
      all.detect do |transaction|
        transaction.transaction_id == transaction_id
      end
    end

    def self.by_uuid(uuid)
      all.detect do |transaction|
        transaction.id == uuid
      end
    end
  end
end

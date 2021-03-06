require 'date'
require_relative '../lib/transaction'
require_relative '../lib/statement'

class Account

  attr_reader :balance, :transaction_history

  def initialize(balance = 0.00)
    @balance = balance.to_f
    @transaction_history = []
  end

  def transaction(type, amount, date = Date.today.to_s)
    update_balance(amount, type)
    amount = reformat_to_2dp_string(amount)
    balance = reformat_to_2dp_string(@balance)
    date = reformat_date(date)
    record_transaction(type, balance, amount, date)
  end

  private

  def record_transaction(type, balance, amount, date)
    transaction = Transaction.new(type, balance, amount, date)
    transaction_history.push(transaction)
  end

  def reformat_to_2dp_string(data)
    "#{'%.2f' % data}"
  end

  def reformat_date(date)
    Date.parse(date).strftime("%d/%m/%Y")
  end

  def update_balance(amount, type)
    if type == 'withdraw'
      @balance -= amount
    elsif type == 'deposit'
      @balance += amount
    end
  end
end
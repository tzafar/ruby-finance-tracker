class Stock < ApplicationRecord

  validates :name, :ticker, presence: true

  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.get_price(ticker_symbol)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex[:publishable_token],
      secret_token: Rails.application.credentials.iex[:secret_token],
                                  endpoint: 'https://sandbox.iexapis.com/v1')

    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      nil
    end
  end

end

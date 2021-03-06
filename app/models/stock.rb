class Stock < ApplicationRecord

  validates :name, :ticker, presence: true

  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.look_up(ticker_symbol)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex[:publishable_token],
      secret_token: Rails.application.credentials.iex[:secret_token],
                                  endpoint: 'https://sandbox.iexapis.com/v1')

    begin
      new(ticker: ticker_symbol.upcase, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      nil
    end
  end

  def self.present_in_db(ticker_symbol)
    where(:ticker => ticker_symbol)
  end

end

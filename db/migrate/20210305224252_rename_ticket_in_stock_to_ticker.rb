class RenameTicketInStockToTicker < ActiveRecord::Migration[6.1]
  change_table :stocks do |t|
    t.rename :ticket, :ticker
  end
end

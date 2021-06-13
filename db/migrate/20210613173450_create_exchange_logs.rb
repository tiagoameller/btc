class CreateExchangeLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_logs, primary_key: :updated, id: false do |t|
      t.timestamp :updated
      t.float :usd_rate
      t.float :gbp_rate
      t.float :eur_rate
    end

    add_index :exchange_logs, :updated, unique: true, order: { updated: :desc }
  end
end

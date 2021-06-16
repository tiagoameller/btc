class CreateExchangeLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_logs, primary_key: :updated, id: false do |t|
      t.timestamp :updated
      t.float :usd_rate, default: 0
      t.float :gbp_rate, default: 0
      t.float :eur_rate, default: 0
    end

    add_index :exchange_logs, :updated, unique: true, order: { updated: :desc }
  end
end

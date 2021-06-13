class CreateAverages < ActiveRecord::Migration[6.1]
  def change
    create_table :averages, primary_key: :date_time, id: false do |t|
      t.timestamp :date_time
      t.float :usd_sum
      t.integer :usd_count
      t.float :gbp_sum
      t.integer :gbp_count
      t.float :eur_sum
      t.integer :eur_count
    end

    add_index :averages, :date_time, unique: true
  end
end

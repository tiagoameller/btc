class CreateAverages < ActiveRecord::Migration[6.1]
  def change
    create_table :averages do |t|
      t.integer :kind
      t.string :key
      t.float :usd_sum, default: 0
      t.integer :usd_count, default: 0
      t.float :gbp_sum, default: 0
      t.integer :gbp_count, default: 0
      t.float :eur_sum, default: 0
      t.integer :eur_count, default: 0
    end

    add_index :averages, [:kind, :key], unique: true
  end
end

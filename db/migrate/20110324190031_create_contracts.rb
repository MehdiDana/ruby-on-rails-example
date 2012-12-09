class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.string :state
      t.float :price
      t.datetime :start_at
      t.datetime :end_at
      t.string :policy
      t.text :reason
      t.references :customer

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end

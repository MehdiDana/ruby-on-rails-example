class CreateShipments < ActiveRecord::Migration
  def self.up
    create_table :shipments do |t|
      t.string :state
      t.text :origin
      t.text :destination
      t.text :description
      t.float :weight
      t.float :volume
      t.datetime :slot_start_at
      t.datetime :slot_end_at
      t.references :driver
      t.references :vehicle
      t.references :contract

      t.timestamps
    end
  end

  def self.down
    drop_table :shipments
  end
end

class CreateVehicles < ActiveRecord::Migration
  def self.up
    create_table :vehicles do |t|
      t.string :type
      t.float :volume
      t.float :weight_capacity

      t.timestamps
    end
  end

  def self.down
    drop_table :vehicles
  end
end

class CreateLicenses < ActiveRecord::Migration
  def self.up
    create_table :licenses do |t|
      t.string :type
      t.references :driver

      t.timestamps
    end
  end

  def self.down
    drop_table :licenses
  end
end

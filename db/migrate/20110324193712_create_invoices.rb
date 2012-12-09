class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.integer :reference
      t.float :amout
      t.references :customer
      t.references :contract

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end

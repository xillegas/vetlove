class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.text :symptoms
      t.text :diagnostic
      t.text :treatment
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end

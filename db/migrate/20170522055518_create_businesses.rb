class CreateBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :long
      t.string :start_date
      t.string :end_date
      t.st_point :lonlat, geographic: true
      t.index :lonlat, using: :gist
      t.timestamps
    end
  end
end

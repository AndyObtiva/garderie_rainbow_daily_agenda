class CreateChildReports < ActiveRecord::Migration[5.2]
  def change
    create_table :child_reports do |t|
      t.string :child_object
      t.datetime :email_sent_at

      t.timestamps
    end
  end
end

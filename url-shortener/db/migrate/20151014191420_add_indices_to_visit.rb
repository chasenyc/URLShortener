class AddIndicesToVisit < ActiveRecord::Migration
  def change
    add_index :visits, :visitor_id
    add_index :visits, :short_url_id

  end
end

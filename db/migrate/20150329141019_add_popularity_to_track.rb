class AddPopularityToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :popularity, :integer
  end
end

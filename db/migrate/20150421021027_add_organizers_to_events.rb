class AddOrganizersToEvents < ActiveRecord::Migration
  def change
    add_column :events, :organizers, :integer
  end
end

class AddProjects < ActiveRecord::Migration
  def change
    create_table(:projects) do |t|
      t.column(:name, :string)
      t.column(:description, :string)

      t.timestamps()
    end

    change_table(:employees) do |t|
      t.column(:project_id, :integer)
    end
  end
end

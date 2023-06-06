defmodule TaskApp.Repo.Migrations.AlterTableTodos do
  use Ecto.Migration

  def change do
    alter table(:todos) do
      add :notified, :boolean, default: false
    end
  end
end

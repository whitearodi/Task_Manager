defmodule TaskApp.ObanJob do
  # or :events
  use Oban.Worker, queue: :mailers
  alias TaskApp.Mailer

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id}}) do
    case TaskApp.Tasks.get_todo(id) do
      nil -> {:error, "Task not found"}
      task -> Mailer.notify_task_created(task)
    end

    # use case to check if the task is nil or not then send the email if not return error
    :ok
  end
end

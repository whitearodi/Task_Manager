defmodule TaskApp.Mailer do
  use Swoosh.Mailer, otp_app: :task_app
  import Swoosh.Email

  def notify_task_created(task) do
    new()
    |> to({"user.name", "josepharodi20@gmail.com"})
    |> from({"Dr B Banner", "josepharodi20@gmail.com"})
    |> subject("New Task Created")
    |> text_body("A new task has been created:#{task.title}")
    |> html_body("<h1>A new task has been created:#{task.title}</h1>")
    |> deliver()
  end
end

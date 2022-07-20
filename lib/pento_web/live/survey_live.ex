defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view
  alias Pento.{Catalog, Accounts, Survey}
  alias PentoWeb.DemographicLive.FormComponent

  @impl true
  def mount(_params, %{"user_token" => token} = _session, socket) do
    {:ok, socket |> assign_user(token)}
  end

  @impl true
  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def assign_user(socket, token) do
    # IO.puts("Assign user with socket.private:")
    # IO.inspect(socket.private)
    assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(token) end)
  end

  def handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic created successfully")
    |> assign(:demographic, demographic)
  end
end

defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  alias Pento.Accounts

  def mount(_params, session, socket) do
    socket =
      assign(socket,
        score: 0,
        message: "Guess a number.",
        random_number: :rand.uniform(10),
        user: Accounts.get_user_by_session_token(session["user_token"]),
        session_id: session["live_socket_id"]
      )

    IO.inspect(socket.assigns.random_number)

    {:ok, socket}
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    IO.inspect(data)

    if String.to_integer(guess) == socket.assigns.random_number do
      message = "Correct guess"
      score = socket.assigns.score + 50
      socket = assign(socket, message: message, score: score)

      {:noreply, socket}
    else
      message = "Wrong guess. Try Again"
      score = socket.assigns.score - 1
      socket = assign(socket, message: message, score: score)

      {:noreply, socket}
    end
  end

  def render(assigns) do
    ~H"""
      <h1>Your score: <%= @score %></h1>
      <h2><%= @message %></h2>
        <h2>
          <%= for n <- 1..10 do %>
            <a href="#" phx-click="guess" phx-value-number={n} > <%= n %> </a>
          <% end %>
      </h2>
      <pre>
        <%= @user.email %>
        <%= @session_id %>
      </pre>
    """
  end
end

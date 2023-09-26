defmodule ChartWeb.PageLive.Index do
  use ChartWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:points, [9, 9, 9, 9, 9])

    {:ok, socket}
  end

  @impl true
  def handle_event("change-data", %{"set" => set}, socket) do
    dataset =
      case set do
        "1" -> [1, 2, 3, 4, 5]
        "2" -> [10, 2, 8, 3, 9]
        _ -> [5, 4, 3, 2, 1]
      end

    socket =
      socket
      |> push_event("update_points", %{points: dataset})

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <canvas id="my-chart" phx-hook="ChartJS" data-points={Jason.encode!(@points)}></canvas>
      <div class="flex justify-center gap-4">
        <.button phx-click="change-data" phx-value-set="1">SET 1</.button>
        <.button phx-click="change-data" phx-value-set="2">SET 2</.button>
        <.button phx-click="change-data" phx-value-set="3">SET 3</.button>
      </div>
    </div>
    """
  end
end

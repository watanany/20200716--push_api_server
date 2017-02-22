defmodule Push do
  defmacro __using__(_) do
    quote do
      def base_url do
        Push.base_url(__MODULE__)
      end

      def push(base_url, api_key, options) do
        Push.push(base_url, api_key, options)
      end

      def push(api_key, registration_ids, options) do
        Push.push(base_url, api_key, registration_ids, options)
      end
    end
  end

  def base_url(service_name) do
    case service_name do
      FCM -> "https://fcm.googleapis.com/fcm/send"
      GCM -> "https://gcm-http.googleapis.com/gcm/send"
    end
  end

  def push(base_url, api_key, options) do
    headers = [{"Content-Type", "application/json"},
               {"Authorization", "key=#{api_key}"}]

    Task.async(fn ->
      response = HTTPoison.post(base_url, options, headers)
      case response do
        %{status_code: 200} -> response
        %{status_code: code} -> raise "Response Status Code: #{code}"
      end
    end)
  end

  def push(base_url, api_key, registration_ids, options) do
    options = Map.put(options, :registration_ids, registration_ids)
    push(base_url, api_key, options)
  end
end

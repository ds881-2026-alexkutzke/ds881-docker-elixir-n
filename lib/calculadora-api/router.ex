defmodule CalculadoraApi.Router do
  use Plug.Router

  plug Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason
  plug :match
  plug :dispatch

  post "/calcular" do
    %{"operador" => op, "op1" => v1, "op2" => v2} = conn.body_params

    resultado = case op do
      "soma" -> v1 + v2
      "subtracao" -> v1 - v2
      "multiplicacao" -> v1 * v2
      "divisao" when v2 != 0 -> v1 / v2
      _ -> 0
    end

    {:ok, host} = :inet.gethostname()
    
    body = Jason.encode!(%{
      container_host: to_string(host),
      resultado: resultado
    })

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  match _ do
    send_resp(conn, 404, "Não encontrado")
  end
end

defmodule Potencia do
  @error_msg "Entradas válidas: n y b enteros, con n >= 1 y b >= 2"

  def main do
    n = leer("Ingrese n: ")
    b = leer("Ingrese b: ")


    resultado = es_potencia?(n, b)

    IO.puts("\nResultado final:")
    IO.inspect(resultado)

  end

  def es_potencia?(n, b) when is_integer(n) and is_integer(b) and n >= 1 and b >= 2 do
    verificar(n, b, 0)
  end

  def es_potencia?(_n, _b), do: {:error, @error_msg}

  defp verificar(1, b, nivel) do
    traza(nivel, "es_potencia?(1, #{b}) -> true   (caso base: b^0 = 1)")
    true
  end

  defp verificar(n, b, nivel) do
    traza(nivel, "es_potencia?(#{n}, #{b})")

    resultado =
      if rem(n, b) == 0 do
        verificar(div(n, b), b, nivel + 1)
      else
        false
      end

    traza(nivel, "es_potencia?(#{n}, #{b}) -> #{resultado}")
    resultado
  end

  defp traza(nivel, mensaje) do
    IO.puts(String.duplicate("  ", nivel) <> mensaje)
  end

  defp leer(mensaje) do
    entrada = mensaje |> IO.gets() |> to_string() |> String.trim()

    case Integer.parse(entrada) do
      {numero, ""} -> numero
      _ -> entrada
    end
  end
end

Potencia.main()

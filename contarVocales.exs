defmodule ContarVocales do
  def main do
    Util.imprimir_mensaje("Ingrese una cadena de texto:")
    cadena = Util.leer("", :string)

    case contar_vocales(cadena) do
      {:error, motivo} ->
        Util.imprimir_error("Error: #{motivo}")

      resultado ->
        Util.imprimir_mensaje("El número total de vocales es: #{resultado}")
    end
  end

  def contar_vocales(cadena) when not is_binary(cadena) do
    {:error, "La entrada debe ser una cadena de caracteres"}
  end

  def contar_vocales(cadena) do
    cond do
      es_numero?(cadena) ->
        {:error, "La entrada no puede ser un número"}

      true ->
        cadena
        |> String.graphemes()
        |> contar_rec([])
    end
  end

  defp es_numero?(cadena) do
    case Integer.parse(cadena) do
      {_, ""} ->
        true

      _ ->
        case Float.parse(cadena) do
          {_, ""} -> true
          _ -> false
        end
    end
  end

  defp contar_rec([], _acc), do: 0

  defp contar_rec([head | tail], _acc) do
    letra = String.downcase(head)
    incremento = if letra in ~w(a e i o u á é í ó ú ü), do: 1, else: 0
    incremento + contar_rec(tail, [])
  end
end

ContarVocales.main()


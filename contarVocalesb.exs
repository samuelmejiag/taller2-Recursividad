defmodule ContarVocalesB do
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
        contar_rec(cadena, 0)
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

  defp contar_rec("", acc), do: acc

  # Caso recursivo: extrae el primer carácter UTF-8 y el resto usando binarios nativos
  defp contar_rec(<<c::utf8, resto::binary>>, acc) do
    letra = <<c::utf8>> |> String.downcase()

    nuevo_acc =
      if letra in ~w(a e i o u á é í ó ú ü), do: acc + 1, else: acc

    contar_rec(resto, nuevo_acc)
  end
end

ContarVocalesB.main()

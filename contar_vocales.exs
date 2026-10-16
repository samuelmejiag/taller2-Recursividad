defmodule ContarVocales do


  @error_msg "La entrada debe ser una cadena de caracteres"


  @vocales ~w(a e i o u á é í ó ú ü A E I O U Á É Í Ó Ú Ü)

  def main do
    entrada = leer("Ingrese una cadena de texto: ")

    IO.puts("")
    IO.inspect(entrada, label: "Entrada")
    resultado = contar_vocales(entrada)
    IO.inspect(resultado, label: "Resultado")
  end


  def contar_vocales(cadena) when is_binary(cadena) do
    grafemas = String.graphemes(cadena)
    traza(0, "contar_vocales(#{inspect(cadena)}) -> grafemas: #{inspect(grafemas)}")
    contar(grafemas, 1)
  end


  def contar_vocales(_entrada), do: {:error, @error_msg}

  defp contar([], nivel) do
    traza(nivel, "contar([]) -> 0   (caso base)")
    0
  end


  defp contar([head | tail], nivel) do
    traza(nivel, "contar([#{inspect(head)} | #{inspect(tail)}])")

    {suma, motivo} =
      if es_vocal?(head), do: {1, "es vocal, suma 1"}, else: {0, "no es vocal, suma 0"}

    resultado = suma + contar(tail, nivel + 1)
    traza(nivel, "contar([#{inspect(head)} | ...]) -> #{resultado}   (#{motivo})")
    resultado
  end

  defp es_vocal?(grafema), do: grafema in @vocales

  defp traza(nivel, mensaje), do: IO.puts(String.duplicate("  ", nivel) <> mensaje)

  
  defp leer(mensaje) do
    entrada =
      case IO.gets(mensaje) do
        texto when is_binary(texto) -> String.trim(texto)
        _ -> ""
      end

    case Integer.parse(entrada) do
      {numero, ""} ->
        numero

      _ ->
        case Float.parse(entrada) do
          {numero, ""} -> numero
          _ -> entrada
        end
    end
  end
end

ContarVocales.main()

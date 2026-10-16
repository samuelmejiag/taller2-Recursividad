defmodule ContarVocalesB do

  @error_msg "La entrada debe ser una cadena de caracteres"


  @vocales [
    ?a, ?e, ?i, ?o, ?u, ?á, ?é, ?í, ?ó, ?ú, ?ü,
    ?A, ?E, ?I, ?O, ?U, ?Á, ?É, ?Í, ?Ó, ?Ú, ?Ü
  ]

  def main do
    entrada = leer("Ingrese una cadena de texto: ")

    IO.puts("")
    IO.inspect(entrada, label: "Entrada")
    resultado = contar_vocales(entrada)
    IO.inspect(resultado, label: "Resultado")
  end


  def contar_vocales(cadena) when is_binary(cadena) do
    traza(0, "contar_vocales(#{inspect(cadena)})")
    contar(cadena, 0, 1)
  end


  def contar_vocales(_entrada), do: {:error, @error_msg}


  defp contar("", acum, nivel) do
    traza(nivel, "contar(\"\", #{acum}) -> #{acum}   (caso base)")
    acum
  end

  defp contar(<<c::utf8, resto::binary>>, acum, nivel) when c in @vocales do
    traza(nivel, "contar(#{inspect(<<c::utf8, resto::binary>>)}, #{acum})   #{inspect(<<c::utf8>>)} es vocal")
    contar(resto, acum + 1, nivel + 1)
  end


  defp contar(<<c::utf8, resto::binary>>, acum, nivel) do
    traza(nivel, "contar(#{inspect(<<c::utf8, resto::binary>>)}, #{acum})   #{inspect(<<c::utf8>>)} no es vocal")
    contar(resto, acum, nivel + 1)
  end


  defp contar(<<_byte, resto::binary>>, acum, nivel) do
    contar(resto, acum, nivel + 1)
  end

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

ContarVocalesB.main()

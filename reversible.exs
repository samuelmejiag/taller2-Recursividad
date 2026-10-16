defmodule Reversible do

  @error_msg "La entrada debe ser un entero positivo"

  def main do
    n = leer("Ingrese un número entero positivo: ")

    IO.puts("")
    IO.inspect(n, label: "Entrada")
    resultado = es_reversible?(n)
    IO.inspect(resultado, label: "Resultado")
  end


  def es_reversible?(n) when is_integer(n) and n > 0 do
    traza(0, "es_reversible?", n)

    if rem(n, 10) == 0 do

      traza(1, "termina en 0, el inverso tendría cero a la izquierda -> false", n)
      false
    else
      inverso = invertir(n, 0, 1)
      suma = n + inverso
      traza(1, "suma {n, inverso, n + inverso}", {n, inverso, suma})
      todos_impares?(suma, 1)
    end
  end


  def es_reversible?(_n), do: {:error, @error_msg}


  defp invertir(0, acum, nivel) do
    traza(nivel, "invertir {n, acum} -> inverso (caso base)", {0, acum})
    acum
  end


  defp invertir(n, acum, nivel) do
    traza(nivel, "invertir {n, acum}", {n, acum})
    invertir(div(n, 10), acum * 10 + rem(n, 10), nivel + 1)
  end


  defp todos_impares?(0, nivel) do
    traza(nivel, "todos_impares? {n} -> true (caso base)", 0)
    true
  end


  defp todos_impares?(n, nivel) do
    digito = rem(n, 10)
    traza(nivel, "todos_impares? {n, último dígito}", {n, digito})

    if rem(digito, 2) == 1 do
      resultado = todos_impares?(div(n, 10), nivel + 1)
      traza(nivel, "todos_impares? {n, resultado}", {n, resultado})
      resultado
    else
      traza(nivel, "todos_impares? {n, resultado} (dígito par)", {n, false})
      false
    end
  end

  defp traza(nivel, etiqueta, valor) do
    IO.inspect(valor, label: String.duplicate("  ", nivel) <> etiqueta)
  end


  defp leer(mensaje) do
    entrada = leer_linea(mensaje)

    case Integer.parse(entrada) do
      {numero, ""} -> numero
      _ -> entrada
    end
  end

  defp leer_linea(mensaje) do
    case IO.gets(mensaje) do
      texto when is_binary(texto) -> String.trim(texto)
      _ -> ""
    end
  end
end

Reversible.main()

Code.require_file("util.exs", __DIR__)

defmodule NumeroPerfecto do
  def main do
    Util.imprimir_mensaje("Ingrese un número entero para verificar si es perfecto: ")
    entrada = Util.leer("", :integer)

    case es_perfecto?(entrada) do
      {:error, motivo} ->
        Util.imprimir_error("Error: #{motivo}")

      resultado ->
        Util.imprimir_mensaje("Es #{entrada} un número perfecto?: #{resultado}")
    end

    Util.imprimir_mensaje("\nListando números perfectos menores que 10.000")
    perfectos = listar_perfectos_menores_que(10000)
    Util.imprimir_mensaje("Los números perfectos menores que 10.000 son: #{inspect(perfectos)}")

    Util.imprimir_mensaje("\n=== Ejecutando Traza Real con Indentación ===")
    probar_traza(6)
  end

  def es_perfecto?(n) when not is_integer(n) or n < 1 do
    {:error, "El número debe ser un entero mayor o igual a 1"}
  end

  def es_perfecto?(1), do: false

  def es_perfecto?(n) do
    suma_divisores = sumar_divisores_c(n, 1, 0)
    suma_divisores == n
  end

  defp sumar_divisores_c(n, actual, acc) when actual >= n, do: acc

  defp sumar_divisores_c(n, actual, acc) do
    nuevo_acc = if rem(n, actual) == 0, do: acc + actual, else: acc
    sumar_divisores_c(n, actual + 1, nuevo_acc)
  end

  def probar_traza(n) do
    sumar_divisores_traza(n, 1, 0, 0)
  end

  defp sumar_divisores_traza(n, actual, acc, nivel) when actual >= n do
    IO.puts(
      String.duplicate("  ", nivel) <>
        "sumar_divisores(#{n}, actual: #{actual}, acc: #{acc}) -> Retorna: #{acc}"
    )

    acc
  end

  defp sumar_divisores_traza(n, actual, acc, nivel) do
    IO.puts(
      String.duplicate("  ", nivel) <> "sumar_divisores(#{n}, actual: #{actual}, acc: #{acc})"
    )

    nuevo_acc = if rem(n, actual) == 0, do: acc + actual, else: acc

    resultado = sumar_divisores_traza(n, actual + 1, nuevo_acc, nivel + 1)

    IO.puts(
      String.duplicate("  ", nivel) <>
        "sumar_divisores(#{n}, actual: #{actual}) -> Retorna #{resultado}"
    )

    resultado
  end

  def listar_perfectos_menores_que(limite), do: listar_rec(limite - 1, [])

  defp listar_rec(0, acc), do: acc

  defp listar_rec(n, acc) do
    if match?(true, es_perfecto?(n)) do
      listar_rec(n - 1, [n | acc])
    else
      listar_rec(n - 1, acc)
    end
  end
end

NumeroPerfecto.main()

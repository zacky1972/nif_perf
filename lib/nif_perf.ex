defmodule NifPerf do
  @on_load :load_nifs

  def load_nifs do
    :erlang.load_nif(Application.app_dir(:nif_perf, "priv/libnif"), 0)
  end

  def test(), do: raise "NIF test/0 not implemented"
end

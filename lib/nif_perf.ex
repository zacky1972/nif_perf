defmodule NifPerf do
  @on_load :load_nifs

  def load_nifs do
    :erlang.load_nif(Application.app_dir(:nif_perf, "priv/libnif"), 0)
  end

  def no_op(_list), do: raise "NIF no_op/1 not implemented"

  def get_list_to_null(_list), do: raise "NIF get_list_to_null/1 not implemented"
end

defmodule NifPerfBench do
  use Benchfella

  @list_1000 Enum.to_list(1..1_000)
  @list_10000 Enum.to_list(1..10_000)

  bench "no_op 1000" do
  	NifPerf.no_op(@list_1000)
  end

  bench "no_op 10000" do
  	NifPerf.no_op(@list_10000)
  end

  bench "get_list_to_null 1000" do
  	NifPerf.get_list_to_null(@list_1000)
  end

  bench "get_list_to_null 10000" do
  	NifPerf.get_list_to_null(@list_10000)
  end
end

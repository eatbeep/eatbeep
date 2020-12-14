defmodule Eatbeep.GenerateId do
  def random_id, do: Nanoid.generate(8, "0123456789abcdefghijklmnopqrstuvwxyz")
end

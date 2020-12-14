defmodule Eatbeep.Check.ActorAttributeMatchsRecord do
  @moduledoc false
  use AshPolicyAuthorizer.SimpleCheck

  def actor_attribute_matches_record(opts, opts) do
    {__MODULE__, [opts, opts]}
  end

  @impl true
  def describe(opts) do
    "actor.#{opts[:attribute]} == #{inspect(opts[:value])}"
  end

  @impl true
  def match?(nil, _, _), do: false

  def match?(actor, context, opts) do
    IO.inspect(actor, label: "actor")
    IO.inspect(context, label: "context")
    IO.inspect(opts, label: "opts")
    false
    # Map.fetch(actor, opts[:attribute]) == {:ok, opts[:value]}
  end
end

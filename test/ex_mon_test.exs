defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

alias ExMon.Player

 describe "create_player/4" do
  test "returns a player" do
    expected_response = %Player{
      life: 100,
      name: "Vitor",
      moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}
    }

    assert expected_response == ExMon.create_player("Vitor", :soco, :chute, :cura)
  end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("Vitor", :chute, :soco, :cura)

      messages =
      capture_io(fn ->
        assert ExMon.start_game(player) == :ok
      end)

      assert messages =~ "The game is started!"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Vitor", :chute, :soco, :cura)

        capture_io(fn ->
          ExMon.start_game(player)
        end)

        {:ok, player: player, a: 1, b: 2, c: 3}
          end
    test "when the move is valid, do the move and the computer makes a move", %{player: player} do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)


        assert messages =~ "The Player Attacked the computer dealing"
        assert messages =~ "é a vez do player jogar"
        assert messages =~ "status: :continue"

    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)


        assert messages =~ "Invalid move: wrong."

    end
  end
end

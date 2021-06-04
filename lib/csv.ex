defmodule Csv do
  def read_csv(filename) do
    {status,contents}=File.read(filename)
    case status do
      :ok -> contents
      :error -> "ファイル名が不正です。"
    end
  end

  def make_list(contents) do
    keys=
    String.split(contents,"\r\n")
    |> Enum.at(0)
    values=
    String.split(contents,"\r\n")
    |> List.delete_at(0)

    {keys,values}
  end
end


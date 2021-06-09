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
    |> String.split(",")
    |> Enum.with_index()
    values=
    String.split(contents,"\r\n")
    |> List.delete_at(0)
    |> Enum.map(&String.split(&1,","))

    {keys,values}
  end

  def make_map(keys,values) do
    maps =
    #Enum.map(values,&[{Enum.at(keys,0),Enum.at(&1,0)},{Enum.at(keys,1),Enum.at(&1,1)},{Enum.at(keys,2),Enum.at(&1,2)},{Enum.at(keys,3),Enum.at(&1,3)}])
    Enum.map(values,fn y -> Enum.map(keys,fn {x,n}-> {x,Enum.at(y,n)} end) end)
    Enum.map(maps,&Map.new(&1))
  end

  def main do
    {keys,values}
    =read_csv("CUSTOMER.csv")
    |> make_list()

    make_map(keys,values)
  end

  def simple_CSV do
    Path.expand("/Users/hitoshi/day4/csv/CUSTOMER.csv")
    |> File.stream!
    |> CSV.Decoding.Decoder.decode(headers: true)
    |> Enum.to_list()
    |> Keyword.get_values(:ok)
  end
end

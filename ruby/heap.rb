class Heap
  # コンストラクタ
  def initialize(*input_numbers)
    @heap_length = input_numbers.length
    # heapを作る時は配列インデックスを1オリジンにしたいので、インスタンス変数の配列の最初に"要素数"を格納して明示的にインデックスをずらす
    @numbers = [@heap_length, *input_numbers]
    # ヒープ領域の初期化
    heapify(@heap_length / 2)
  end

  # 実処理
  def main
    # 最初の要素は管理情報なのでインデックス1から表示
    p @numbers[1..]
  end

  private

  # 配列を2分ヒープの構造にする
  def heapify(loop_limit)
    # 最上段のループにたどり着いた時点で全てがソートできているので、明示的に終了
    return if loop_limit == 1

    1.upto(loop_limit) do |index|
      # 自身と子ノードを比較し、配列の中身を入れ替える
      min_heapify(index)
    end
    # 処理ループ数を1減らして再度ヒープの処理を実施する
    heapify(loop_limit - 1)
  end

  # 自分と子ノードを比較し、値を入れ替える
  def min_heapify(current_idx)
    # 子ノードの情報を取得
    child_node_indexes = [current_idx * 2]
    child_node_indexes << (current_idx * 2 + 1) unless current_idx * 2 == @heap_length

    # 子ノードと自身の値を比較して入れ替えを行う
    current_val = @numbers[current_idx]

    child_node_indexes.each do |child_idx|
      child_val = @numbers[child_idx]
      # 現在の値よりも子ノードの値が小さいかチェックして不要な場合は入れ替えない
      next unless child_val < current_val

      # 処理対象のインデックスの値を子ノードの値と入れ替える
      @numbers[current_idx] = child_val
      @numbers[child_idx] = current_val
      current_val = child_val
    end
  end
end

Heap.new(3, 3, 5, 2, 4, 5, 8, 10, 1).main

# 3
# 35
# 2458
# 101
#-> いれかえなし
#
# 3
# 25
# 3458
# 101
#-> いれかえあり
#
# 3
# 25
# 3458
# 101
#-> いれかえなし
#
# 3
# 25
# 1458
# 103
#-> いれかえあり
#
#
# この段階で一番下はそろったので、3段目までループさせる
#
# 2
# 35
# 1458
# 103
#-> いれかえなし
#
# 2
# 15
# 3458
# 103
#-> いれかえあり
#
# この段階で3段目もそろったので、2段目までループさせる
#
# 1
# 25
# 3458
# 103
#-> いれかえあり
#
# この段階で2段目もそろったので、終了
#

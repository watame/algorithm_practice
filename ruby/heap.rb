class Heap
  # コンストラクタ
  def initialize(*input_numbers)
    @numbers = *input_numbers
  end

  # ヒープ領域の初期化
  def initialize_heap
    # ヒープツリーが完成したかを判断するフラグ
    retry_flg = true
    while retry_flg
      # 配列の半分がノードになるので、配列の前半分だけを対象にループすればよい
      (0...@numbers.length / 2).reverse_each do |index|
        child_node_start = (index + 1) * 2 - 1
        child_node_end = child_node_start + 1
        double_leaf_flg = child_node_end < @numbers.length

        # 並び替え対象の配列を作成する
        target_node = [@numbers[index], @numbers[child_node_start]]
        target_node << @numbers[child_node_end] if double_leaf_flg
        # 並び替え後の配列と比較するために配列をコピー
        original_node = target_node.clone

        # 配列をソート
        sort(target_node)
        p index
        p child_node_start
        p child_node_end

        # ソートした値をツリーの値として配置していく
        @numbers[index] = target_node[0]
        @numbers[child_node_start] = target_node[1]
        @numbers[child_node_end] = target_node[2] if double_leaf_flg

        # ツリーのルートノードの並び替えを行った場合はretry_flgを有効化する
        retry_flg = index.zero? && original_node != target_node
      end
    end
  end

  def main
    initialize_heap
    p @numbers
  end

  private

  def sort(target_array)
    (0...(target_array.length - 1)).each do |current_idx|
      next_idx = current_idx + 1
      next unless target_array[next_idx] < target_array[current_idx]

      min = target_array[next_idx]
      compare = target_array[current_idx]
      target_array[current_idx] = min
      target_array[next_idx] = compare
    end
  end
end

Heap.new(3, 3, 5, 1, 4, 5, 8, 10, 1).main

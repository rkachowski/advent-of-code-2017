def diagnonal_order col, row
  row -= 1
  base_row = col + row

  ((base_row - 1) * base_row / 2) + col
end


def next_code num
  (num * 252533) % 33554393
end

def code_for col, row
  times = diagnonal_order col, row

  (1..times-1).inject(20151125){ |n| next_code n }
end


puts code_for( 3083, 2978)

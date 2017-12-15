    VALUES = [873,583]
    FACTORS = [16807,48271]
    DENUM = 2147483647
    
    def part_1
      matches = 0
      values = VALUES.clone
    
      40000000.times do
        values[0] = values[0] * FACTORS[0] % DENUM
        values[1] = values[1] * FACTORS[1] % DENUM
    
        matches += 1 if values[0] & 65535 == values[1] & 65535
      end
    
      puts matches
    end
    
    def part_2
      matches = 0
      values = VALUES.clone
    
      5000000.times do
        values[0] = values[0] * FACTORS[0] % DENUM
        values[1] = values[1] * FACTORS[1] % DENUM
    
        values[0] = values[0] * FACTORS[0] % DENUM until values[0] % 4 == 0
        values[1] = values[1] * FACTORS[1] % DENUM until values[1] % 8 == 0
    
        matches += 1 if values[0] & 65535 == values[1] & 65535
      end
    
      puts matches
    end
    

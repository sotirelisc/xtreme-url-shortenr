def xor_it(first, second)
  first.bytes.zip(second.bytes).map { |a, b| a ^ b }
end

def short_it(base_url, target_url)
  arr_target = target_url.split("")
  arr_base = base_url.split("")
  # Maintain same length in case one is longer than the other
  extra = []
  if arr_base.size > arr_target.size
    diff = arr_base.size - arr_target.size
    arr_target[0..diff-1].each do |obj|
      extra << obj
    end
    arr_target = arr_target + extra
  elsif
    arr_target.size > arr_base.size
    diff = arr_target.size - arr_base.size
    arr_base[0..diff-1].each do |obj|
      extra << obj
    end
    arr_base = arr_base + extra
  end
  # XOR base URL with target URL
  hashed = xor_it(arr_base.to_s, arr_target.to_s)
  # Take last 8 bytes
  last8 = []
  for i in hashed.to_s.bytes.length-8..hashed.to_s.bytes.length-1
    last8 << hashed.to_s.bytes[i]
  end
  # Convert to unsigned int
  uns = last8.inject { |r, n| r << 8 | n }
  # Encode with Base62 (may not be working as expected)
  alphabet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  arr = []
  base = alphabet.length
  while uns > 0 do
    rem = uns % base
    uns = uns / base
    arr << alphabet[rem]
    arr.reverse
  end
  base_url = base_url + "/" + arr.join
end

# Usage
b = gets.chomp
t = gets.chomp
puts short_it(b, t)
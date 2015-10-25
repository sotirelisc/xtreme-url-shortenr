def xor_it(first, second)
  first.bytes.zip(second.bytes).map { |a, b| a ^ b }
end

base_url = gets.chomp
count = gets.chomp.to_i
count.times do |now|
  target_url = gets.chomp
  
  arr_target = target_url.split("")
  arr_base = base_url.split("")
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

  hashed = xor_it(arr_base.to_s, arr_target.to_s)
  last8 = []
  for i in hashed.to_s.bytes.length-8..hashed.to_s.bytes.length-1
    last8 << hashed.to_s.bytes[i]
  end
  uns = last8.inject { |r, n| r << 8 | n }
  alphabet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  arr = []
  base = alphabet.length
  while uns > 0 do
    rem = uns % base
    uns = uns / base
    arr << alphabet[rem]
    arr.reverse
  end
  puts base_url + "/" + arr.join
end
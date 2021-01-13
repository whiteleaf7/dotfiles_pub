(0xf400..0xf67c).each_with_index do |code, index|
  print "%s %s   " % [code.to_s(16), code.chr("UTF-8")]
  if index % 10 == 9
    puts
  end
end

local link = package.path : match("(.-);") : gsub("?%.lua", "noteruntime.txt")

local f = io.open(link, "w")
f : write(os.time())
f : close()
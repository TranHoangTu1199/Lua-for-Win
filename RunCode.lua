local link = package.cpath : match("(.-);") : gsub("?%.dll", "RunCodeFileLink.txt")

local ftext
local f = io.open(link)
ftext = f : read("*a") : match("\"(.-)\"")
f : close()

local fcode, err = loadfile(ftext, ftext)
local rtime = os.clock()
if not fcode then
	os.execute("color c")
	print(err)
	os.execute("echo [0m")
else
	local res, err = pcall(fcode)
	if not res then
		os.execute("color c")
		print(err)
		os.execute("echo [0m")
	end
end

print("\n>>> Code run time:", os.clock() - rtime .. "s.")

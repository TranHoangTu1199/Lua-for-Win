string.ulen = utf8.len
string.codes = utf8.codes
string.codepoint = utf8.codepoint

function string.charlist(s)
	local list = {}
	for p, c in utf8.codes(s) do
		list[p] = {
			code = c;
			pos = p;
			value = utf8.char(c)
		}
	end
	return list
end

function string.chars(s)
	local ci = 0
	return function() 
		local b = s : byte()
		local c
		if b and b < 128 then
			c = s : sub(1, 1)
			s = s : sub(2, #s)
		elseif b and b < 224 then
			c = s : sub(1, 2)
			s = s : sub(3, #s)
		elseif b and b < 240 then
			c = s : sub(1, 3)
			s = s : sub(4, #s)
		elseif b then
			c = s : sub(1, 4)
			s = s : sub(5, #s)
		end
		if c then
			ci = ci + 1
			return ci, c 
		end
	end
end

function string.usub(s, i, j)
	local str = ""
	local cn = s : u_len()
	if i and i <= 0 then i = cn + i elseif not i then i = 1 end
	if j and j <= 0 then j = cn + j elseif not j then j = i end
	for ci, c in s : chars() do
		if ci >= i and ci <= j then
			str = str .. c
		end
	end
	return str
end

local lower_list = {"è","é","ẻ","ẽ","ẹ","ê","ề","ế","ể","ễ","ệ","ỳ","ý","ỷ","ỹ","ỵ","ù","ú","ủ","ũ","ụ","ư","ừ","ứ","ử","ữ","ự","ì","í","ỉ","ĩ","ị","ò","ó","ỏ","õ","ọ","ô","ồ","ố","ổ","ỗ","ộ","ơ","ờ","ớ","ở","ỡ","ợ","à","á","ả","ã","ạ","ă","ằ","ắ","ẳ","ẵ","ặ","â","ầ","ấ","ẩ","ẫ","ậ","đ"}      
local upper_list = {'È','É','Ẻ','Ẽ','Ẹ','Ê','Ề','Ế','Ể','Ễ','Ệ','Ỳ','Ý','Ỷ','Ỹ','Ỵ','Ù','Ú','Ủ','Ũ','Ụ','Ư','Ừ','Ứ','Ử','Ữ','Ự','Ì','Í','Ỉ','Ĩ','Ị','Ò','Ó','Ỏ','Õ','Ọ','Ô','Ồ','Ố','Ổ','Ỗ','Ộ','Ơ','Ờ','Ớ','Ở','Ỡ','Ợ','À','Á','Ả','Ã','Ạ','Ă','Ằ','Ắ','Ẳ','Ẵ','Ặ','Â','Ầ','Ấ','Ẩ','Ẫ','Ậ','Đ'} 
local lower2upper = {}
local upper2lower = {}
for i = 1, #lower_list do
	lower2upper[lower_list[i]] = upper_list[i]
	upper2lower[upper_list[i]] = lower_list[i]
end

local oldlw = string.lower
function string.lower(s)
	local str = ""
	for p, c in utf8.codes(s) do
		str = str .. (upper2lower[utf8.char(c)] or oldlw(utf8.char(c)))
	end
	return str
end

local oldup = string.upper
function string.upper(s)
	local str = ""
	for p, c in utf8.codes(s) do
		str = str .. (lower2upper[utf8.char(c)] or oldup(utf8.char(c)))
	end
	return str
end

return string
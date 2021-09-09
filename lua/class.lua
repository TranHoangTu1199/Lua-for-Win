local function copy(sefl)
	local newtb = {}
	for k, v in pairs(sefl) do
		newtb[k] = v
	end
	return newtb
end

function class(strtb)
	local sefl = copy(table)
	if type(strtb) == "string" then
		for _, t in utf8.codes(strtb) do
			sefl : insert(utf8.char(t))
		end
	elseif type(strtb) == "table" then
		for i, v in ipairs(strtb) do
			sefl[i] = v
		end
		for k, v in pairs(strtb) do
			sefl[k] = v
		end
	end
	-- copy
	sefl.copy = copy
	-- add
	function sefl : add(atb, k)
		local list
		if type(atb) == "string" then list = class(atb) k = "index" else list = atb end
		if not k or (k and k == "index") then
			for i, v in ipairs(list) do
				sefl : insert(v)
			end
		elseif k == "key" then
			for k, v in pairs(list) do
				if tonumber(k) == nil then
					sefl[k] = v
				end
			end
		end
		return sefl
	end
	-- append
	function sefl : insert(...)
		table.insert(sefl, ...)
		sefl.n = sefl : maxn()
		sefl.str = sefl : sub()
		sefl.upper = sefl.str : upper()
		sefl.lower = sefl.str : lower()
		return sefl
	end
	-- do class
	function sefl : do_class(fntb, i, j)
		for z = (i or 1), (j or sefl : maxn()) do
			if type(fntb) == "table" then
				sefl[z] = fntb[sefl[z]]
			elseif type(fntb) == "function" then
				sefl[z] = fntb(sefl[z])
			end
		end
		return sefl
	end
	-- cut
	function sefl : cut(tbi, tbj, ctb) 
		local ntb = (ctb or Class({}))
		for i = tbi, tbj do
			ntb : insert(sefl[tbi])
			sefl : remove(tbi)
		end
		sefl.n = sefl : maxn()
		sefl.str = sefl : sub()
		sefl.upper = sefl.str : upper()
		sefl.lower = sefl.str : lower()
		return ntb
	end
	-- random
	function sefl : rand() return sefl[random(1, sefl : maxn())] end
	-- strip class
	function sefl : del(tbi, tbj)
		if tbj then
			for i = tbi, tbj do
				sefl : remove(tbi)
			end
		else
			sefl : remove(tbi)
		end
		sefl.n = sefl : maxn()
		sefl.str = sefl : sub()
		sefl.upper = sefl.str : upper()
		sefl.lower = sefl.str : lower()
		return sefl
	end
	-- class to string
	function sefl : sub(i, j, mode) 
		local apply = ""
		for z, v in ipairs(sefl) do
			if z >= (i or 1) and z <= (j or sefl : maxn()) then
				apply = apply .. tostring(v) .. (z < (j or sefl : maxn()) and (mode or "") or "")
			end
		end
		return apply
	end
	-- reverse class
	function sefl : rev()
		local ntb = sefl : copy() 
		for i = 1, sefl : maxn() do 
			ntb[i] = sefl[sefl : maxn() - i + 1] 
		end  
		sefl = ntb : copy()
		sefl.str = sefl : sub()
		sefl.upper = sefl.str : upper()
		sefl.lower = sefl.str : lower()
		return sefl
	end
	-- load class
	function sefl : load()
		local i = 0
		return function()
			i = i + 1
			local list = {
				str = tostring(sefl[i]);
				code = utf8.codepoint(tostring(sefl[i]));
				type = type(sefl[i]);
				vl = sefl[i]
			}
			if sefl[i] then return i, list end
		end
	end
	-- maxn class
	function sefl : maxn()
		return #sefl
	end
	sefl.n = sefl : maxn()
	sefl.str = sefl : sub()
	sefl.upper = sefl.str : upper()
	sefl.lower = sefl.str : lower()
	-- return class
	return sefl
end

return class
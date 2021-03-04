local M = {}

M.SW = 960
M.SH = 540

M.tablelength = function (T)
	local count = 0
	for k,v in pairs(T) do
		if v then
			count = count + 1 
		end 
	end
	return count
end

return M
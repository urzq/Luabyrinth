local stack = {}
stack.__index = stack

function newStack()
	local s = {
		_et = {}
	}

	return setmetatable(s, stack)
end

function stack:push(val)
	table.insert(self._et, val)
end

function stack:pop()
	val = self._et[#self._et]
	table.remove(self._et) -- remove last value
	return val
end

function stack:empty()
	return #self._et == 0
end


Stack = {}

function Stack:create()

  local t = { 
    _et = {} 
  }

  function t:push(val)
      table.insert(self._et, val)
  end

  function t:pop()
      val = self._et[#self._et]
      table.remove(self._et) -- remove last value
      return val
  end

  function t:empty()
    return #self._et == 0
  end

  return t
end
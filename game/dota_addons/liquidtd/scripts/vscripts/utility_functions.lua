function GetRandomTableElement( table )
  if #table == 0 then return nil end
  local nRandomIndex = RandomInt( 1, #table )
  local randomElement = table[ nRandomIndex ]
  return randomElement
end

function TableContainsValue( t, value )
  for _, v in pairs( t ) do
    if v == value then
      return true
    end
  end

  return false
end

function TableCount( t )
  local n = 0
  for _ in pairs( t ) do
    n = n + 1
  end
  return n
end

function DeepTableCompare(t1,t2,ignore_mt)
  local ty1 = type(t1)
  local ty2 = type(t2)
  if ty1 ~= ty2 then return false end
  -- non-table types can be directly compared
  if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
  -- as well as tables which have the metamethod __eq
  local mt = getmetatable(t1)
  if not ignore_mt and mt and mt.__eq then return t1 == t2 end
  for k1,v1 in pairs(t1) do
    local v2 = t2[k1]
    if v2 == nil or not DeepTableCompare(v1,v2) then return false end
  end
  for k2,v2 in pairs(t2) do
    local v1 = t1[k2]
    if v1 == nil or not DeepTableCompare(v1,v2) then return false end
  end
  return true
end

function GetTableMax(t)
  local max
  for _,v in pairs(t) do
    if not max then max = v end
    max = math.max(max,v)
  end
  return max
end
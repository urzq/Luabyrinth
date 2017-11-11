local labyrinth = {}
labyrinth.__index = labyrinth

function newLabyrinth(width, height)
    local l = {
        tiles = {}
    }

    for x=1, width do
        l.tiles[x] = {}

        for y=1, height do
            l.tiles[x][y] = 
            {
                isWall = true,
                color = {r=60, g=100, b=100}
            }
        end
    end

    return setmetatable(l, labyrinth)
end

function labyrinth:generatePaths()
    local stack = newStack()
    local curr = {x=2, y=2}

    self:makeFloor({r=200, g=70, b=0}, curr.x, curr.y)
    stack:push(curr)

    while not stack:empty() do
        local neighbors = self:getNeighbors(curr.x, curr.y)

        if #neighbors > 0 then
            local adj, nxt = pickRandomNeighbors(neighbors)
          
            local color = self:getNextColor(curr.x, curr.y)
            self:makeFloor(color, adj.x, adj.y)
            self:makeFloor(color, nxt.x, nxt.y)

            stack:push(curr)
            curr = nxt
        else
            curr = stack:pop()
        end
    end
end

function labyrinth:getNeighbors(x, y)
    local neighbors = {}

    if y+2 <= #self.tiles[1] and self.tiles[x][y+2].isWall then 
        table.insert(neighbors, {{x=x, y=y+1}, {x=x, y=y+2}})
    end
    
    if x+2 <= #self.tiles and self.tiles[x+2][y].isWall then 
        table.insert(neighbors, {{x=x+1, y=y}, {x=x+2, y=y}})
    end

    if y-2 > 1 and self.tiles[x][y-2].isWall then 
        table.insert(neighbors, {{x=x, y=y-1}, {x=x, y=y-2}})
    end

    if x-2 > 1 and self.tiles[x-2][y].isWall then 
        table.insert(neighbors, {{x=x-1, y=y}, {x=x-2, y=y}})
    end

    return neighbors
end

function pickRandomNeighbors(neighbors) 
    local i = math.random(1, #neighbors)
    return neighbors[i][1], neighbors[i][2]
end

function labyrinth:getNextColor(x, y)
    local color = self.tiles[x][y].color
    
    return {
        r = color.r,
        g = color.g +1,
        b = color.b
    }
end

function labyrinth:makeFloor(color, x, y)
    self.tiles[x][y].color = color
    self.tiles[x][y].isWall = false
end
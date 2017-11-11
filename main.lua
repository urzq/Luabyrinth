-- print goes to sublime output
io.stdout:setvbuf("no")

require "Stack"
require "Labyrinth"

local labyrinth = false
local L_W = 43
local L_H = 23
local spriteSize = 16

function love.load()
	math.randomseed(os.time())
	generateLabyrinth()
end

function love.keyreleased(key)
	if key == "escape" then
    	love.event.quit()
   	else
		generateLabyrinth()
	end
end

function love.mousepressed(x, y, button)
	generateLabyrinth()
end

function love.wheelmoved(x, y)
    if y > 0 then
        spriteSize = spriteSize + 1
    elseif y < 0 then
        spriteSize = spriteSize - 1
    end
end

function love.update(dt)
end

function love.draw()
	for x, _ in ipairs(labyrinth.tiles) do
		for y, _ in ipairs(labyrinth.tiles[1]) do
			color = labyrinth.tiles[x][y].color
			love.graphics.setColor(color.r, color.g, color.b)
			love.graphics.rectangle("fill", x * spriteSize, y * spriteSize, spriteSize, spriteSize )
		end
	end
end

function generateLabyrinth()
	labyrinth = newLabyrinth(L_W, L_H)
	labyrinth:generatePaths()
end
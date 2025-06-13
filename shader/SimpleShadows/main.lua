--
-- Example program: Render sprites with simple shadows from a light source.
--
local LG = love.graphics

local images = {
	sprites = LG.newImage("sprites.png"),
	light   = LG.newImage("light.png"),
}
images.sprites:setFilter("nearest")

local quads = {
	player = LG.newQuad(00,00, 32,32, images.sprites),
	tree   = LG.newQuad(32,00, 32,32, images.sprites),
	sign   = LG.newQuad(00,32, 32,32, images.sprites),
}



local entities = {}

local player = {id=#entities, quad=quads.player, x=220,y=200, flip=false}
table.insert(entities, player)

local rand = love.math.random
for i = 1, 30 do  table.insert(entities, {id=#entities, quad=quads.tree, x=rand(400),y=rand(300), flip=false})  end
for i = 1, 4  do  table.insert(entities, {id=#entities, quad=quads.sign, x=rand(400),y=rand(300), flip=false})  end

local lightSource = {x=0, y=0}



function love.update(dt)
	local moveX = 0
	local moveY = 0

	if love.keyboard.isDown"left"  then  moveX = moveX - 1  end
	if love.keyboard.isDown"right" then  moveX = moveX + 1  end
	if love.keyboard.isDown"up"    then  moveY = moveY - 1  end
	if love.keyboard.isDown"down"  then  moveY = moveY + 1  end

	player.x = player.x + 1.5*50*moveX*dt
	player.y = player.y +     50*moveY*dt
	if moveX ~= 0 then  player.flip = (moveX < 0)  end

	local rotation = .3 * love.timer.getTime()
	lightSource.x  = 200 + 1.5*60*math.cos(rotation)
	lightSource.y  = 150 +     60*math.sin(rotation)
end



local function clamp(v, min, max)
	return math.max(math.min(v, max), min)
end

local function drawEntity(e, shearing, scaleY)
	local scaleX   = e.flip and -1 or 1
	local _,_, w,h = e.quad:getViewport()
	LG.draw(images.sprites, e.quad, e.x,e.y, 0, scaleX,scaleY, w/2,h, shearing*scaleX,0)
end

function love.draw()
	table.sort(entities, function(a, b)
		if a.y ~= b.y then  return a.y < b.y  end
		return a.id < b.id
	end)
	LG.scale(2)

	-- Ground.
	LG.clear(0, 0, 0)

	-- Light (on ground).
	local w,h = images.light:getDimensions()
	LG.setColor(.3, .6, .3) ; LG.draw(images.light, lightSource.x,lightSource.y, 0, 1.5*15,15, w/2,h/2)
	LG.setColor(1, 1, 1)    ; LG.draw(images.light, lightSource.x,lightSource.y, 0, 1.5*1,1,   w/2,h/2)

	-- Entity shadows.
	for _, e in ipairs(entities) do
		local dx       = lightSource.x - e.x
		local dy       = lightSource.y - e.y
		local distance = math.sqrt(dx^2 + dy^2) / 50
		local angle    = math.atan2(dy, dx)

		local shearing = distance * math.cos(angle)
		local scaleY   = distance * math.sin(angle)

		LG.setColor(0, 0, 0)
		drawEntity(e, shearing, scaleY)
	end

	-- Entities.
	for _, e in ipairs(entities) do
		local dx       = lightSource.x - e.x
		local dy       = lightSource.y - e.y
		local distance = math.sqrt((dx/1.5)^2 + (dy)^2)

		local lightDistance = clamp(1 - distance / 400, 0, 1) -- Darker if farther away.
		local lightFacing   = clamp(1 + dy       / 20 , 0, 1) -- Darker if facing away.
		local light         = lightDistance * lightFacing

		LG.setColor(light, light, light)
		drawEntity(e, 0, 1)
	end

	-- Info.
	LG.origin()
	LG.setColor(1, 1, 1)
	LG.print("Press arrow keys to move", 3,1)
end



function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end



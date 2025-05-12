

WINDOW_WIDTH = 500
WINDOW_HEIGHT =500


function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
    image = love.graphics.newImage("sword_item.png") -- Replace with your image
    image_width = image:getWidth()
    image_height = image:getHeight()
  
    -- Define the control points of the Bézier curve
    local points = {
      100, 300, -- P0 (x, y)
      200, 100, -- P1 (x, y)
      400, 100, -- P2 (x, y)
      500, 300  -- P3 (x, y)
    }
  
    control_points = {}
    for i = 1, #points, 2 do
      table.insert(control_points, {x = points[i], y = points[i+1]})
    end
  
    bezier_curve = love.math.newBezierCurve(unpack(points))
    num_images = 20 -- Number of images to draw along the curve
  end
  
  -- Function to evaluate a point on the cubic Bézier curve (using the object's evaluate)
  function getCurvePoint(curve, t)
    local point = curve:evaluate(t)
    return point.x, point.y
  end
  
  -- Function to evaluate the tangent vector of the cubic Bézier curve (analytical)
  function getCurveTangentAngle(t, p0, p1, p2, p3)
    local dx = 3*(1-t)^2 * (p1.x - p0.x) + 6*(1-t) * t * (p2.x - p1.x) + 3*t^2 * (p3.x - p2.x)
    local dy = 3*(1-t)^2 * (p1.y - p0.y) + 6*(1-t) * t * (p2.y - p1.y) + 3*t^2 * (p3.y - p2.y)
    return math.atan2(dy, dx)
  end
  
  function love.draw()
    -- Draw the Bézier curve (approximation for visualization)
    love.graphics.setColor(0.5, 0.5, 0.5)
    local num_segments = 100
    local last_x, last_y = getCurvePoint(bezier_curve, 0)
    for i = 1, num_segments do
      local t = i / num_segments
      local current_x, current_y = getCurvePoint(bezier_curve, t)
      love.graphics.line(last_x, last_y, current_x, current_y)
      last_x, last_y = current_x, current_y
    end
    love.graphics.setColor(1, 1, 1)
  
    -- Draw the images along the Bézier curve
    for i = 0, num_images do
      local t = i / num_images
      local x, y = getCurvePoint(bezier_curve, t)
      local angle = getCurveTangentAngle(t, control_points[1], control_points[2], control_points[3], control_points[4])
  
      -- Center the image when rotating
      local origin_x = image_width / 2
      local origin_y = image_height / 2
  
      love.graphics.draw(image, x, y, angle, 1, 1, origin_x, origin_y)
    end
  end
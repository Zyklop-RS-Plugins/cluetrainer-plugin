-- path_shapes.lua
local MutableMesh        = require("zyklib/MutableMesh")
local api_util           = require("zyklib/api_util")
local TerrainHighlight   = require("zyklib/highlights/TerrainHighlight")
local tilecoordinates    = require("cluetrainer/math/math").tilecoordinates
local array              = require("zyklib/array")
local HighlightGroup     = require("zyklib/highlights/HighlightGroup")
local TileArea           = require("cluetrainer/math/math").tilearea
local LocHighlight       = require("zyklib/highlights/LocHighlight")
local NpcHighlight       = require("zyklib/highlights/NpcHighlight")

local path_shapes           = {}

local OverlayConstants = {
    AREA_OVERLAY_HEIGHT = 64,
    ARROW_HEAD_LENGTH = 150,
    FLOOR_OVERLAY_VERTICAL_OFFSET = 60,
    TILE_MARKER_VERTICAL_OFFSET = 80,
    TILE_MARKER_BORDER = 40,
}
path_shapes.OverlayConstants = OverlayConstants

-- The usual dig highlight: the spot and the tiles around it.
local DIG_AREA_SIZE      = { x = 3, y = 3 }
-- For clues whose dig spot must be hit exactly.
local SINGLE_TILE_SIZE   = { x = 1, y = 1 }

---@class AbilityColors
---@field [any] ColourRGBA
local ABILITY_COLORS = {
    surge = api_util.color_rgba(0, 0x91, 0xf2, 255),
    escape = api_util.color_rgba(0x56, 0xba, 0x0f, 255),
    barge = api_util.color_rgba(0xa9, 0x71, 0x04, 255),
    dive = api_util.color_rgba(0xe7, 0xd8, 0x2c, 255),
}

---@class COLORS
---@field [any] ColourRGBA
local COLORS         = {
    run = api_util.color_rgba(180, 180, 180, 255),
    redclicked_run = api_util.color_rgba(255, 0, 0, 255),
    teleport = api_util.color_rgba(255, 0, 255, 255),
    transport = api_util.color_rgba(0, 255, 200, 255),
    powerburst = api_util.color_rgba(255, 215, 0, 255),
    redclick = api_util.color_rgba(255, 50, 50, 255),
    ability = api_util.color_rgba(255, 255, 255, 255),
    freeform = api_util.color_rgba(0, 255, 200, 255),
    cosmetic = api_util.color_rgba(0, 0, 0, 0),
    orientation = api_util.color_rgba(0, 0, 0, 0),
}


---
---@param tile_coordinates TileCoordinates#
---@param sample ("sw"|"nw"|"ne"|"se"|"center")?
---@return CoordFine
local function convert(tile_coordinates, sample, inset)
    sample = sample or "center"
    inset = inset or 0

    local FINE_CORNER_OFFSETS = {
        sw = { x = 1 + inset, z = 1 + inset },
        nw = { x = 1 + inset, z = 510 - inset },
        ne = { x = 510 - inset, z = 510 - inset },
        se = { x = 510 - inset, z = 1 + inset },
        center = { x = 255, z = 255 },
    }

    local offset = FINE_CORNER_OFFSETS[sample]

    return CoordFine.new(
        tile_coordinates.level,
        tile_coordinates.x * 512 + offset.x,
        tile_coordinates.y * 512 + offset.z
    )
end


---Resolves the terrain height for a given CoordFine
---@param coords CoordFine
---@return Vector3
local function resolve(coords)
    local height, success = World.GetGroundHeight(coords.level, coords.x, coords.z, HeightOffsetType.GROUND_DECOR)

    if not success then
        return Vector3.new(coords.x, coords.y, coords.z)
    end

    return Vector3.new(coords.x, height, coords.z)
end

local function lift(point, level)
    return { x = point.x, y = point.y, level = level }
end

---
---@param dir Vector2
---@return Vector2
function path_shapes.squareCrossSectionVector(dir)
    local magnitude = math.max(math.abs(dir.x), math.abs(dir.y))
    if magnitude == 0 then
        return { x = 0, y = 0 }
    end

    return Vector2.new(
        dir.x / magnitude,
        dir.y / magnitude
    )
end

---Compute a convex upper hull of a set of given points across terrain.
---@param points Vector3[]
---@return table
local function upperHull(points)
    if #points <= 2 then
        local copy = {}
        for i, point in ipairs(points) do
            copy[i] = point
        end
        return copy
    end

    local hull = {}

    local function slope(i, j)
        return (points[j].y - points[i].y) / (j - i)
    end

    for i = 1, #points do
        hull[#hull + 1] = i

        while #hull >= 3 do
            local n = #hull
            local a = hull[n - 2]
            local b = hull[n - 1]
            local c = hull[n]

            if slope(a, b) < slope(b, c) then
                table.remove(hull, n - 1)
            else
                break
            end
        end
    end

    local result = {}
    for _, index in ipairs(hull) do
        result[#result + 1] = points[index]
    end
    return result
end

---@param factor number
---@param v Vector3
---@return Vector3
local function scale3(factor, v)
    return Vector3.new(v.x * factor, v.y * factor, v.z * factor)
end

---@param factor number
---@param v Vector2
---@return Vector2
local function scale2(factor, v)
    return Vector2.new(v.x * factor, v.y * factor)
end

---@param coords CoordFine
---@return Vector2
local function coords_as_vector(coords)
    return Vector2.new(coords.x, coords.z)
end

---@param vector Vector2
---@param level 0|1|2|3
---@return CoordFine
local function vector_as_coord(vector, level)
    return CoordFine.new(level, vector.x, vector.y)
end

---comment
---@param from_tile TileCoordinates
---@param to_tile TileCoordinates
---@param thickness integer
---@param showArrow boolean
---@param startTileSize integer
---@param endTileSize integer
---@param useUpperHull boolean
---@return zyklib.MutableMesh
local function drawLine(from_tile, to_tile, thickness, showArrow, startTileSize, endTileSize, useUpperHull)
    local builder = MutableMesh.new()

    local a = coords_as_vector(convert(from_tile))
    local b = coords_as_vector(convert(to_tile))

    local direction = (b - a)

    direction = scale2(1 / direction.length, direction)

    local crossSection = path_shapes.squareCrossSectionVector(direction)

    local modifiedStart = a + scale2(0.5 * startTileSize, crossSection)
    local modifiedEnd = b - scale2(0.5 * endTileSize, crossSection) +
        (showArrow and scale2(-OverlayConstants.ARROW_HEAD_LENGTH, direction) or Vector2.new(0, 0))

    local length = (modifiedEnd - modifiedStart).length

    if length < 0.001 then
        return builder
    end

    local perpendicular = Vector2.new(-direction.y, direction.x)

    local segmentCount = math.max(1, math.ceil(length / 128))
    local controlPoints = {}

    for segment = 0, segmentCount do
        local t = segment / segmentCount
        local point = (scale2(1 - t, modifiedStart) + scale2(t, modifiedEnd)):Floor()

        controlPoints[#controlPoints + 1] = resolve(vector_as_coord(point, from_tile.level))
    end

    if useUpperHull then
        controlPoints = upperHull(controlPoints)
    end

    local vertexPairs = {}
    for _, point in ipairs(controlPoints) do
        local v1 = builder:createVertex(point + scale3(thickness, Vector3.new(-perpendicular.x, 0, -perpendicular.y)))

        local v2 = builder:createVertex(point + scale3(thickness, Vector3.new(perpendicular.x, 0, perpendicular.y)))

        vertexPairs[#vertexPairs + 1] = { v1, v2 }
    end

    for i = 2, #vertexPairs do
        local previous = vertexPairs[i - 1]
        local current = vertexPairs[i]
        builder:quad(previous[1], current[1], current[2], previous[2])
    end

    if showArrow then
        local arrowWidth = thickness * 3
        local base1 = modifiedEnd + scale2(arrowWidth, perpendicular)
        local base2 = modifiedEnd + scale2(-arrowWidth, perpendicular)
        local tip = modifiedEnd + scale2(OverlayConstants.ARROW_HEAD_LENGTH, direction)

        local v0 = builder:createVertex(resolve(vector_as_coord(base1, to_tile.level)))
        local v1 = builder:createVertex(resolve(vector_as_coord(base2, to_tile.level)))
        local v2 = builder:createVertex(resolve(vector_as_coord(tip, to_tile.level)))

        builder:triangle(v0, v1, v2)
    end

    -- offset entire line to the target height above the terrain
    builder:translate(Vector3.new(0, OverlayConstants.FLOOR_OVERLAY_VERTICAL_OFFSET, 0))

    return builder
end

---Draw a tile marker at the given tile
---@param tile TileCoordinates The tile to draw on
---@param inset number Distance of the tile marker from the tile edge in fine coordinates (0-250). Default is 0.
---@return zyklib.MutableMesh
local function drawTileMarker(tile, inset)
    inset = inset or 0
    local mesh = MutableMesh.new()

    local outer00 = mesh:createVertex(resolve(convert(tile, "sw", inset)))
    local outer01 = mesh:createVertex(resolve(convert(tile, "nw", inset)))
    local outer11 = mesh:createVertex(resolve(convert(tile, "ne", inset)))
    local outer10 = mesh:createVertex(resolve(convert(tile, "se", inset)))

    local inner00 = mesh:createVertex(resolve(convert(tile, "sw", inset + OverlayConstants.TILE_MARKER_BORDER)))
    local inner01 = mesh:createVertex(resolve(convert(tile, "nw", inset + OverlayConstants.TILE_MARKER_BORDER)))
    local inner11 = mesh:createVertex(resolve(convert(tile, "ne", inset + OverlayConstants.TILE_MARKER_BORDER)))
    local inner10 = mesh:createVertex(resolve(convert(tile, "se", inset + OverlayConstants.TILE_MARKER_BORDER)))

    mesh:quad(outer00, outer01, inner01, inner00)
    mesh:quad(outer01, outer11, inner11, inner01)
    mesh:quad(outer11, outer10, inner10, inner11)
    mesh:quad(outer10, outer00, inner00, inner10)

    mesh:translate(Vector3.new(0, OverlayConstants.TILE_MARKER_VERTICAL_OFFSET, 0))

    return mesh
end

---@param tile_area TileArea
---@return zyklib.MutableMesh
function path_shapes.drawTileAreaOutlines(tile_area)
    tile_area = TileArea.ensure_mutable(tile_area)

    local mesh = MutableMesh.new()

    ---@type zyklib.MutableMesh.VertexRef[]
    local vertex_cache = {}

    local function get_corner_vertex(xi, yi)
        local key = yi * (tile_area:getSize().x + 1) + xi
        if not vertex_cache[key] then
            vertex_cache[key] = mesh:createVertex(resolve(CoordFine.new(
                tile_area.origin.level,
                512 * (tile_area.origin.x + xi),
                512 * (tile_area.origin.y + yi))
            ))
        end
        return vertex_cache[key]
    end

    for xi = 0, tile_area:getSize().x - 1, 1 do
        local x = tile_area.origin.x + xi

        for yi = 0, tile_area:getSize().y - 1, 1 do
            local y = tile_area.origin.y + yi

            ---@type TileCoordinates
            local tile = { x = x, y = y, level = tile_area.origin.level }

            local is_in = tile_area:query(tile)

            if is_in then
                local north = tile_area:query({ x = x, y = y + 1, level = tile_area.origin.level })
                local south = tile_area:query({ x = x, y = y - 1, level = tile_area.origin.level })
                local east = tile_area:query({ x = x + 1, y = y, level = tile_area.origin.level })
                local west = tile_area:query({ x = x - 1, y = y, level = tile_area.origin.level })

                if not south then
                    mesh:line(get_corner_vertex(xi, yi), get_corner_vertex(xi + 1, yi))
                end
                if not east then
                    mesh:line(get_corner_vertex(xi + 1, yi), get_corner_vertex(xi + 1, yi + 1))
                end
                if not west then
                    mesh:line(get_corner_vertex(xi, yi), get_corner_vertex(xi, yi + 1))
                end
                if not north then
                    mesh:line(get_corner_vertex(xi, yi + 1), get_corner_vertex(xi + 1, yi + 1))
                end
            end
        end
    end

    return mesh
end

---@param tile_area TileArea
---@return zyklib.MutableMesh
function path_shapes.drawTileAreaFill(tile_area)
    tile_area = TileArea.ensure_mutable(tile_area)

    local mesh = MutableMesh.new()

    ---@type zyklib.MutableMesh.VertexRef[]
    local vertex_cache = {}

    local function get_corner_vertex(xi, yi)
        local key = yi * (tile_area:getSize().x + 1) + xi
        if not vertex_cache[key] then
            vertex_cache[key] = mesh:createVertex(resolve(CoordFine.new(
                tile_area.origin.level,
                512 * (tile_area.origin.x + xi),
                512 * (tile_area.origin.y + yi))
            ))
        end
        return vertex_cache[key]
    end

    for xi = 0, tile_area:getSize().x - 1, 1 do
        local x = tile_area.origin.x + xi

        for yi = 0, tile_area:getSize().y - 1, 1 do
            local y = tile_area.origin.y + yi

            ---@type TileCoordinates
            local tile = { x = x, y = y, level = tile_area.origin.level }

            local is_in = tile_area:query(tile)

            if is_in then
                local south_west = get_corner_vertex(xi, yi)
                local south_east = get_corner_vertex(xi + 1, yi)
                local north_east = get_corner_vertex(xi + 1, yi + 1)
                local north_west = get_corner_vertex(xi, yi + 1)

                mesh:quad(south_west, south_east, north_east, north_west)
            end
        end
    end

    return mesh
end

---Draw a tile area with outlines and fill
---@param tile_area TileArea
---@param outline_color ColourRGBA? Colour of the outline. Default is 0xFFFFFFFF (white).
---@param fill_color ColourRGBA? Color of the fill. Default is 0xFFFFFF80 (semi-transparent white).
---@return zyklib.MutableMesh
function path_shapes.drawTileArea(tile_area, outline_color, fill_color)
    tile_area = TileArea.ensure_mutable(tile_area)

    local mesh = MutableMesh.new()
    mesh:add(path_shapes.drawTileAreaOutlines(tile_area):recolor(outline_color or 0xFFFFFFFF))
    mesh:add(path_shapes.drawTileAreaFill(tile_area):recolor(fill_color or 0xFFFFFF80))

    return mesh
end

---@alias path_shapes.StepContext {i: integer, context_path: Path}

local StepContext = {}

---@param context path_shapes.StepContext
---@return Path.Step?
function StepContext.previous(context)
    if context.i > 1 then
        return context.context_path[context.i - 1]
    else
        return nil
    end
end

---@param tile_coordinates TileCoordinates[]
---@return Rect
local function bounds_from_tile_coordinates(tile_coordinates)
    return api_util.map_square_rect_from_tiles(array.map(tile_coordinates,
        tilecoordinates.toCoordGrid))
end

---A highlight of a tile area on the ground, such as a dig spot or an emote area. Not activated yet.
---@param tile_area TileArea
---@param outline_color ColourRGBA? See `drawTileArea`
---@param fill_color ColourRGBA? See `drawTileArea`
---@param height number? Height above the ground. Default is `OverlayConstants.AREA_OVERLAY_HEIGHT`.
---@return zyklib.TerrainHighlight
function path_shapes.areaHighlight(tile_area, outline_color, fill_color, height)
    height = height or OverlayConstants.AREA_OVERLAY_HEIGHT
    local origin, size = tile_area.origin, TileArea.ensure_mutable(tile_area):getSize()
    local corner = { x = origin.x + size.x - 1, y = origin.y + size.y - 1, level = origin.level }

    return TerrainHighlight.new(bounds_from_tile_coordinates({ origin, corner }), function()
        return path_shapes.drawTileArea(tile_area, outline_color, fill_color)
            :translate(Vector3.new(0, height, 0))
            :shapeData()
    end)
end

---The usual highlight of a dig spot. Not activated yet.
---@param spot TileCoordinates
---@param single_tile boolean? Only the spot's tile instead of the dig area.
---@return zyklib.TerrainHighlight
function path_shapes.digHighlight(spot, single_tile)
    return path_shapes.areaHighlight(TileArea.centered_on(spot, single_tile and SINGLE_TILE_SIZE or DIG_AREA_SIZE))
end

-- Size of an object highlight relative to the object itself.
local LOC_HIGHLIGHT_SCALE = 1.05

---The usual highlight of an object to interact with, such as a container to search or a hidey-hole: a box around
---each object that matches the filter, cyan unless `colour_of` gives another colour. Not activated yet.
---@param filter LocListFilterSettings
---@param colour_of (fun(loc: LocEntity): ColourRGBA)? The colour of each object's box. Default is cyan.
---@return zyklib.LocHighlight
function path_shapes.locHighlight(filter, colour_of)
    local cube = MutableMesh.new()
        :add(MutableMesh.cube():faces_only():recolor(0xFFFFFF80))
        :add(MutableMesh.cube():lines_only():recolor(0xFFFFFFFF))
        :shapeData()

    return LocHighlight.new(filter, function(loc)
        -- Width and length at most the object's own tiles (512 units each), so an object placed diagonally,
        -- such as the crates of clues 84, 153 and 158, isn't drawn larger than the same object placed straight.
        local d = loc.aabb.dimensions
        local size = Vector3.new(math.min(d.x, loc.width * 512), d.y, math.min(d.z, loc.length * 512))
        return {
            shapeData = cube,
            translation = loc.aabb.centre - Vector3.new(LOC_HIGHLIGHT_SCALE / 2) * size,
            scale = Vector3.new(LOC_HIGHLIGHT_SCALE) * size,
            colour = colour_of and colour_of(loc) or 0x00FFFFA0
        }
    end)
end

---@param step Path.Step?
---@return boolean
local function ends_with_tile_marker(step)
    if step == nil then return false end

    if step.type == "ability" then
        return step.ability == "dive" and not step.is_far_dive
    elseif step.type == "run" then
        return true
    end

    return false
end

---@param step Path.Step
---@param context path_shapes.StepContext
---@return zyklib.Highlight
function path_shapes.buildStepMesh(step, context)
    local LINE_THICKNESS = 30
    local MARKER_INSET = 20
    local MARKER_SIZE = 512 - 2 * MARKER_INSET
    local previous = StepContext.previous(context)
    local currentTileMarkerSize = ends_with_tile_marker(previous) and MARKER_SIZE or 0

    if step.type == "ability" then
        return TerrainHighlight.new(
            bounds_from_tile_coordinates({ step.from, step.to }),
            function()
                local builder = MutableMesh.new()

                local color = ABILITY_COLORS[step.ability]
                local drawTargetTile = step.ability == "dive" and not step.is_far_dive

                builder:add(drawLine(
                    step.from,
                    step.to,
                    LINE_THICKNESS,
                    true,
                    currentTileMarkerSize,
                    drawTargetTile and MARKER_SIZE or 0,
                    true
                ):recolor(color))

                if drawTargetTile then
                    builder:add(drawTileMarker(step.to, MARKER_INSET):recolor(color))
                end

                return builder:shapeData()
            end
        )
    elseif step.type == "run" then
        return TerrainHighlight.new(
            bounds_from_tile_coordinates(step.waypoints),
            function()
                local builder = MutableMesh.new()

                if #step.waypoints >= 2 then
                    local previousIsRedClick = previous ~= nil and previous.type == "redclick"
                    local previousTargetsNpc = previous ~= nil
                        and previous.type == "redclick"
                        and previous.target ~= nil
                        and previous.target.kind == "npc"

                    local lineColor = previousTargetsNpc and COLORS.redclicked_run or COLORS.run
                    local tileColor = previousIsRedClick and COLORS.redclicked_run or COLORS.run

                    for j = 1, #step.waypoints - 1 do
                        local isLast = j == #step.waypoints - 1
                        builder:add(drawLine(
                            step.waypoints[j],
                            step.waypoints[j + 1],
                            LINE_THICKNESS,
                            isLast,
                            j == 1 and currentTileMarkerSize or 0,
                            isLast and MARKER_SIZE or 0,
                            false
                        ):recolor(lineColor))
                    end

                    builder:add(drawTileMarker(step.waypoints[#step.waypoints], MARKER_INSET):recolor(tileColor))
                    currentTileMarkerSize = MARKER_SIZE
                end

                return builder:shapeData()
            end
        )
    elseif step.type == "teleport" then
    elseif step.type == "transport" then
    elseif step.type == "powerburst" then
    elseif step.type == "redclick" then
        local cube = MutableMesh.new()
            :add(MutableMesh.cube():faces_only():recolor(0xFFFFFF80))
            :add(MutableMesh.cube():lines_only():recolor(0xFFFFFFFF))
            :shapeData()

        if step.target.kind == "npc" then
            NpcHighlight.new(function(npc)
                    return npc.displayName == step.target.name
                end,
                function(npc)
                    return {
                        shapeData = cube,
                        translation = npc.aabb:GetCorner(BoxCornerType.LEFT_BOTTOM_NEAR) -
                            Vector3.new(0.1) * npc.aabb.dimensions,
                        scale = Vector3.new(1.2) * npc.aabb.dimensions
                    }
                end
            )
        elseif step.target.kind == "static" then
            local LOC_SCALE = 1.05

            return LocHighlight.new({
                    name = step.target.name,
                    coordGrid = tilecoordinates.toCoordGrid(step.where),
                    range = 2
                },
                function(loc)
                    return {
                        shapeData = cube,
                        translation = loc.aabb:GetCorner(BoxCornerType.LEFT_BOTTOM_NEAR) -
                            Vector3.new((LOC_SCALE - 1) / 2) * loc.aabb.dimensions,
                        scale = Vector3.new(LOC_SCALE) * loc.aabb.dimensions,
                        colour = 0x00FFFFA0
                    }
                end
            )
        end
    elseif step.type == "orientation"
        or step.type == "freeform"
        or step.type == "cosmetic"
    then
        -- No geometry.
    end

    -- If we reach this point, the step type has no highlight geometry. Return an empty highlight.
    return HighlightGroup.new({})
end

---All steps of a path on the ground as one highlight, e.g. to show a route faded. Not activated yet.
---@param path Path.Step[]
---@return zyklib.HighlightGroup
function path_shapes.pathHighlight(path)
    return HighlightGroup.new(array.map(path, function(step, i)
        return path_shapes.buildStepMesh(step, { context_path = path, i = i })
    end))
end

return path_shapes

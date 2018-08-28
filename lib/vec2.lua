local ffi = require "ffi"

---------------------------------------------------------------

ffi.cdef[[
	struct __attribute__(( aligned(16) )) ggvec2_ct { __attribute__(( packed )) double x, y; };
]]

---------------------------------------------------------------

local vec2, vec2_mt

local scream_in_agony = error
local sqrt, acos, cos, sin = math.sqrt, math.acos, math.cos, math.sin

vec2_mt = {
	__add = function(v1, v2)
		return vec2(v1.x + v2.x, v1.y + v2.y)
	end,
	
	__sub = function(v1, v2)
		return vec2(v1.x - v2.x, v1.y - v2.y)
	end,
	
	__mul = function(v1, v2)
		if type(v2) == "number" or not v2:isVector() then
			return vec2(v1.x * v2, v1.y * v2)
		elseif v2:isVector() then
			return v1.x * v2.x + v1.y * v2.y
		end
	end,
	
	__div = function(v1, n)
		if type(n) == "number" or not n:isVector() then
			return vec2(v1.x / n, v1.y / n)
		else
			scream_in_agony("Vector divisors must be numbers!")
		end
	end,
	
	__len = function(self)
		return sqrt(self.x^2 + self.y^2)
	end,
	
	__tostring = function(self)
		return "(" .. tostring(self.x) .. ", " .. tostring(self.y) .. ")"
	end,
	
	__eq = function(v1, v2)
		return tostring(v1) == tostring(v2)
	end,
	
	__unm = function(self)
		return vec2(-self.x, -self.y)
	end,
	
	__index = {
		len = function(self)
			return #self
		end,
		
		angle_diff = function(v1, v2)
			return acos((v1 * v2) / (v1:len() * v2:len()))
		end,
		
		isVector = function()
			return true
		end,
	},
}

vec2 = ffi.metatype("struct ggvec2_ct", vec2_mt)

---------------------------------------------------------------

return vec2

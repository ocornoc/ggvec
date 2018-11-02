local ffi = require "ffi"

---------------------------------------------------------------

ffi.cdef[[
	struct __attribute__(( aligned(16) )) ggvec4_ct { __attribute__(( packed )) float x, y, z, w; };
]]

---------------------------------------------------------------

local vec4, vec4_mt

local scream_in_agony = error
local sqrt, acos, cos, sin = math.sqrt, math.acos, math.cos, math.sin

vec4_mt = {
	__add = function(v1, v2)
		return vec4(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z, v1.w + v2.w)
	end,
	
	__sub = function(v1, v2)
		return vec4(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z, v1.w - v2.w)
	end,
	
	__mul = function(v1, v2)
		if type(v2) == "number" or not v2.isVec4 then
			return vec4(v1.x * v2, v1.y * v2, v1.z * v2, v1.w * v2)
		elseif v2.isVec4 then
			return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z + v1.w * v2.w
		end
	end,
	
	__div = function(v1, n)
		if type(n) == "number" or not n.isVec4 then
			return vec4(v1.x / n, v1.y / n, v1.z / n, v1.w / n)
		else
			scream_in_agony("Vector divisors must be numbers!")
		end
	end,
	
	__len = function(self)
		return sqrt(self.x^2 + self.y^2 + self.z^2 + self.w^2)
	end,
	
	__tostring = function(self)
		return "(" .. tostring(self.x) .. ", " .. tostring(self.y) .. ", " .. tostring(self.z) .. ", " .. tostring(self.w) .. ")"
	end,
	
	__eq = function(v1, v2)
		return tostring(v1) == tostring(v2)
	end,
	
	__unm = function(self)
		return vec4(-self.x, -self.y, -self.z, -self.w)
	end,
	
	__index = {
		len = function(self)
			return #self
		end,
		
		angle_diff = function(v1, v2)
			return acos((v1 * v2) / (v1:len() * v2:len()))
		end,
		
		isVec  = true,
		isVec4 = true,
	},
}

vec4 = ffi.metatype("struct ggvec4_ct", vec4_mt)

---------------------------------------------------------------

return vec4

local ffi = require "ffi"

---------------------------------------------------------------

ffi.cdef[[
	struct __attribute__(( aligned(16) )) ggvec3_ct { __attribute__(( packed )) float x, y, z; };
]]

---------------------------------------------------------------

local vec3, vec3_mt

local scream_in_agony = error
local sqrt, acos, cos, sin = math.sqrt, math.acos, math.cos, math.sin

vec3_mt = {
	__add = function(v1, v2)
		return vec3(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)
	end,
	
	__sub = function(v1, v2)
		return vec3(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)
	end,
	
	__mul = function(v1, v2)
		if type(v2) == "number" or not v2.isVec3 then
			return vec3(v1.x * v2, v1.y * v2, v1.z * v2)
		elseif v2.isVec3 then
			return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
		end
	end,
	
	__div = function(v1, n)
		if type(n) == "number" or not n.isVec3 then
			return vec3(v1.x / n, v1.y / n, v1.z / n)
		else
			scream_in_agony("Vector divisors must be numbers!")
		end
	end,
	
	__len = function(self)
		return sqrt(self.x^2 + self.y^2 + self.z^2)
	end,
	
	__tostring = function(self)
		return "(" .. tostring(self.x) .. ", " .. tostring(self.y) .. ", " .. tostring(self.z) .. ")"
	end,
	
	__eq = function(v1, v2)
		return tostring(v1) == tostring(v2)
	end,
	
	__unm = function(self)
		return vec3(-self.x, -self.y, -self.z)
	end,
	
	__index = {
		len = function(self)
			return #self
		end,
		
		angle_diff = function(v1, v2)
			return acos((v1 * v2) / (v1:len() * v2:len()))
		end,
		
		cross = function(v1, v2)
			return vec3((v1.y * v2.z) - (v1.z * v2.y), (v1.z * v2.x) - (v1.x * v2.z), (v1.x * v2.y) - (v1.y * v2.x))
		end,
		
		isVec  = true,
		isVec3 = true,
	},
}

vec3 = ffi.metatype("struct ggvec3_ct", vec3_mt)

---------------------------------------------------------------

return vec3

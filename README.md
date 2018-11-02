# ggvec

ggvec is a LuaJIT 2D, 3D, and 4D vector library.


## Technical Types

These are the C types used to internally represent the vectors.

| Vector type | C type     |
|-------------|------------|
| 4D vectors  |`struct {double x, y, z, w;}` |
| 3D vectors  |`struct {double x, y, z;}` |
| 2D vectors  |`struct {double x, y;}` |

All vectors are 16-byte aligned and all members are packed.

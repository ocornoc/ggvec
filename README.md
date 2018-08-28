# ggvec

ggvec is a LuaJIT 2D, 3D, and 4D vector library.


## Technical Types

These are the C types used to internally represent the vectors.

| Vector type | C type     |
|-------------|------------|
| 4D vectors  |`struct {float x, y, z, w;}` |
| 3D vectors  |`struct {float x, y, z;}` |
| 2D vectors  |`struct {double x, y;}` |

4D and 3D vectors are only floats so that they can easily fit inside XMM registers. All vectors are 16-byte aligned and all members are packed.

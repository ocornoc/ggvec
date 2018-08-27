# ggvec

ggvec is a LuaJIT 2D, 3D, and 4D vector library. It has support for all platforms supporting the `float` and `double` C types, though conditionally can take advantage of SSE and SSE2 on x86_64.


## Technical Types

These are the C types used to internally represent the vectors.

| Vector type | C type     |
|-------------|------------|
| 4D vectors  |`struct {double x, y, z, w;}` |
| 3D vectors  |`struct {double x, y, z;}` |
| 2D vectors  |`struct {double x, y;}` |

## Speedup Targets

SIMD speedup can be used on Windows, OSX, and Linux on architectures x86 and AMD64. You have to manually enable it, though. It is also experimental, and isn't guaranteed to be faster, more efficient, etc. than the regular LuaJIT FFI interface, nor is it guaranteed to even work. Bugs should be expected using it.

If hardware speedup is attempted on unsupported architectures or operating systems, then an error is raised.

## SSE Technical Types

These are the C types used the internally represent the SSE vectors.

| Vector type | C type     |
|-------------|------------|
| 4D vectors  |`float __attribute__(( vector_size(16), aligned(16), packed ))` |
| 3D vectors  | 4D vectors with the fourth number zero. |
| 2D vectors  | 3D vectors with the third number zero. |

## SSE2 Technical Types

These are the C types used the internally represent the SSE2 vectors.

| Vector type | C type     |
|-------------|------------|
| 4D vectors  |`float __attribute__(( vector_size(16), aligned(16), packed ))` |
| 3D vectors  | 4D vectors with the fourth number zero. |
| 2D vectors  |`double __attribute__(( vector_size(16), aligned(16), packed ))` |
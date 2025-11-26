#ifndef FORCEINLINE
  #if defined(_MSC_VER)
    #define FORCEINLINE __forceinline
  #elif defined(__GNUC__) || defined(__clang__)
    #define FORCEINLINE inline __attribute__((always_inline))
  #else
    #define FORCEINLINE inline
  #endif
#endif

// The following includes are required
// Little modifications may be necessary. They are initially copied using:
// imgm modules:copy --gm

#include <YYRunnerInterface.h>
#include <Ref.h>
#include <YYRValue.h>
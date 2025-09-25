#ifndef FORCEINLINE
  #if defined(_MSC_VER)
    #define FORCEINLINE __forceinline
  #elif defined(__GNUC__) || defined(__clang__)
    #define FORCEINLINE inline __attribute__((always_inline))
  #else
    #define FORCEINLINE inline
  #endif
#endif

#include <YYRunnerInterface.h>
#include <Ref.h>
#include <YYRValue.h>
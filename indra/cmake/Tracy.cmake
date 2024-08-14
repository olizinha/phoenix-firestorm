# -*- cmake -*-
include(Prebuilt)

include_guard()
add_library( ll::tracy INTERFACE IMPORTED )

option(USE_TRACY "Use Tracy profiler." OFF)

if (USE_TRACY)
  option(USE_TRACY_ON_DEMAND "Use Tracy profiler." ON)
  option(USE_TRACY_LOCAL_ONLY "Use Tracy profiler." OFF)

  use_prebuilt_binary(tracy)

  target_include_directories( ll::tracy SYSTEM INTERFACE ${LIBS_PREBUILT_DIR}/include/tracy)

  target_compile_definitions(ll::tracy INTERFACE -DTRACY_ENABLE=1 -DTRACY_ONLY_IPV4=1)

  if (USE_TRACY_ON_DEMAND)
    target_compile_definitions(ll::tracy INTERFACE -DTRACY_ON_DEMAND=1)
  endif ()

  if (USE_TRACY_LOCAL_ONLY)
    target_compile_definitions(ll::tracy INTERFACE -DTRACY_NO_BROADCAST=1 -DTRACY_ONLY_LOCALHOST=1)
  endif ()

  # See: indra/llcommon/llprofiler.h
  add_compile_definitions(LL_PROFILER_CONFIGURATION=3)
endif (USE_TRACY)


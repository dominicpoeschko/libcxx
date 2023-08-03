set(
  LIBCXX_SOURCE_FILES
  src/charconv.cpp
  src/ryu/d2fixed.cpp
  src/ryu/d2s.cpp
  src/ryu/f2s.cpp
)

list(TRANSFORM LIBCXX_SOURCE_FILES PREPEND "${CMAKE_CURRENT_LIST_DIR}/")

set_source_files_properties(
  ${LIBCXX_SOURCE_FILES} PROPERTIES COMPILE_FLAGS
  "-D_LIBCPP_BUILDING_LIBRARY \
    -Wno-reserved-id-macro \
    -Wno-atomic-alignment \
    -Wno-tautological-type-limit-compare \
    -Wno-double-promotion \
    -Wno-unused-parameter \
    -Wno-sign-conversion \
    -Wno-ctad-maybe-unsupported \
    -Wno-covered-switch-default"
)

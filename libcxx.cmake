set(LIBCXX_SOURCE_FILES
    src/algorithm.cpp
    # src/any.cpp
    # src/atomic.cpp
    # src/barrier.cpp
    # src/bind.cpp
    src/call_once.cpp
    src/charconv.cpp
    # src/chrono.cpp
    # src/condition_variable.cpp
    # src/condition_variable_destructor.cpp
    # src/error_category.cpp
    # src/exception.cpp
    # src/expected.cpp
    # src/experimental/chrono_exception.cpp
    # src/experimental/keep.cpp
    # src/experimental/log_hardening_failure.cpp
    # src/experimental/time_zone.cpp
    # src/experimental/tzdb.cpp
    # src/experimental/tzdb_list.cpp
    # src/filesystem/directory_entry.cpp
    # src/filesystem/directory_iterator.cpp
    # src/filesystem/filesystem_clock.cpp
    # src/filesystem/filesystem_error.cpp
    # src/filesystem/int128_builtins.cpp
    # src/filesystem/operations.cpp
    # src/filesystem/path.cpp
    # src/fstream.cpp
    # src/functional.cpp
    # src/future.cpp
    src/hash.cpp
    # src/ios.cpp
    # src/ios.instantiations.cpp
    # src/iostream.cpp
    # src/locale.cpp
    src/memory.cpp
    # src/memory_resource.cpp
    # src/mutex.cpp
    # src/mutex_destructor.cpp
    src/new.cpp
    src/new_handler.cpp
    src/new_helpers.cpp
    # src/optional.cpp
    # src/ostream.cpp
    # src/print.cpp
    # src/pstl/libdispatch.cpp
    # src/random.cpp
    # src/random_shuffle.cpp
    # src/regex.cpp
    src/ryu/d2fixed.cpp
    src/ryu/d2s.cpp
    src/ryu/f2s.cpp
    # src/shared_mutex.cpp
    # src/stdexcept.cpp
    src/string.cpp
    # src/strstream.cpp
    # src/support/ibm/mbsnrtowcs.cpp
    # src/support/ibm/wcsnrtombs.cpp
    # src/support/ibm/xlocale_zos.cpp
    # src/support/win32/compiler_rt_shims.cpp
    # src/support/win32/locale_win32.cpp
    # src/support/win32/support.cpp
    # src/support/win32/thread_win32.cpp
    # src/system_error.cpp
    # src/text_encoding.cpp
    # src/thread.cpp
    # src/typeinfo.cpp
    # src/valarray.cpp
    # src/variant.cpp
    # src/vector.cpp
    # src/verbose_abort.cpp
    )

# The headers and the library always come from the same port, so the oldest headers the library serves are its own
# release: the LLVM major of UPSTREAM (written by tools/llvm_port/libcport), and no compatibility symbols for older ones.
set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS ${CMAKE_CURRENT_LIST_DIR}/UPSTREAM)
file(STRINGS ${CMAKE_CURRENT_LIST_DIR}/UPSTREAM libcxx_upstream LIMIT_COUNT 1)
if(NOT libcxx_upstream MATCHES "^llvmorg-([0-9]+)\\.")
    message(FATAL_ERROR "lib/libcxx/UPSTREAM: no llvmorg-<major>. tag in '${libcxx_upstream}'")
endif()

set(libcxx_flags
    -ffreestanding
    -D_LIBCPP_BUILDING_LIBRARY
    -D_LIBCPP_AVAILABILITY_MINIMUM_HEADER_VERSION=${CMAKE_MATCH_1})

# libc++ compiles with the compiler's default warnings (Kvasir's warning list is the image's own, kvasir::warnings);
# two of them fire in upstream code. clang: libc++ 23's _LIBCPP_BEGIN/END_NAMESPACE_STD push an ABI-annotation
# attribute region, and in the library's own sources (not system headers there) clang reports the region's unused
# attributes where it ends. gcc: the always_inline helpers of src/include/to_chars_floating_point.h are not declared
# inline.
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    list(APPEND libcxx_flags -Wno-attributes)
else()
    list(APPEND libcxx_flags -Wno-ignored-attributes -Wno-pragma-clang-attribute)
endif()

# charconv.cpp needs llvm-libc's header-only shared/ tree; -idirafter keeps
# llvm-libc's libc headers from shadowing newlib's.
if(NOT "${CLIB}" STREQUAL "llvm")
    list(APPEND libcxx_flags -idirafter${CMAKE_CURRENT_LIST_DIR}/../libc/include
         -idirafter${CMAKE_CURRENT_LIST_DIR}/../libc -DLIBC_NAMESPACE=__llvm_libc)
endif()

list(JOIN libcxx_flags " " LIBCXX_FLAGS)

list(TRANSFORM LIBCXX_SOURCE_FILES PREPEND "${CMAKE_CURRENT_LIST_DIR}/")

set_source_files_properties(${LIBCXX_SOURCE_FILES} PROPERTIES COMPILE_FLAGS "${LIBCXX_FLAGS}")

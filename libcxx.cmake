set(LIBCXX_SOURCE_FILES
    # src/algorithm.cpp
    # src/any.cpp
    # src/atomic.cpp
    # src/barrier.cpp
    # src/bind.cpp
    # src/call_once.cpp
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
    # src/hash.cpp
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
    # src/thread.cpp
    # src/typeinfo.cpp
    # src/valarray.cpp
    # src/variant.cpp
    # src/vector.cpp
    # src/verbose_abort.cpp
    )

set(libcxx_flags
    -D_LIBCPP_BUILDING_LIBRARY
    -Wno-reserved-id-macro
    -Wno-atomic-alignment
    -Wno-tautological-type-limit-compare
    -Wno-double-promotion
    -Wno-unused-parameter
    -Wno-sign-conversion
    -Wno-unsafe-buffer-usage
    -Wno-ctad-maybe-unsupported
    -Wno-covered-switch-default
    -Wno-missing-noreturn)

list(JOIN libcxx_flags " " LIBCXX_FLAGS)

list(TRANSFORM LIBCXX_SOURCE_FILES PREPEND "${CMAKE_CURRENT_LIST_DIR}/")

set_source_files_properties(${LIBCXX_SOURCE_FILES} PROPERTIES COMPILE_FLAGS "${LIBCXX_FLAGS}")

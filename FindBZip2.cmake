# - Find Bzip2
# Find the BZip2 compression library and includes
#
#  BZIP2_INCLUDE_DIRS - where to find bzlib.h, etc.
#  BZIP2_LIBRARIES   - List of libraries when using BZip2.
#  BZIP2_FOUND       - True if BZip2 found.

IF(BZIP2_USE_STATIC)
  MESSAGE(STATUS "BZIP2_USE_STATIC: ON")
ELSE()
  MESSAGE(STATUS "BZIP2_USE_STATIC: OFF")
ENDIF(BZIP2_USE_STATIC)

SET(_BZIP2_PATHS PATHS "[HKEY_LOCAL_MACHINE\\SOFTWARE\\GnuWin32\\Bzip2;InstallPath]")

FIND_PATH(BZIP2_INCLUDE_DIRS bzlib.h ${_BZIP2_PATHS} PATH_SUFFIXES include)

IF(BZIP2_USE_STATIC)
  FIND_LIBRARY(BZIP2_LIBRARIES NAMES libbz2.a libbzip2.a ${_BZIP2_PATHS} PATH_SUFFIXES lib)
ELSE()
  FIND_LIBRARY(BZIP2_LIBRARIES NAMES bz2 bzip2 ${_BZIP2_PATHS} PATH_SUFFIXES lib)
ENDIF(BZIP2_USE_STATIC)

IF(BZIP2_INCLUDE_DIRS AND EXISTS "${BZIP2_INCLUDE_DIRS}/bzlib.h")
  FILE(STRINGS "${BZIP2_INCLUDE_DIRS}/bzlib.h" BZLIB_H REGEX "bzip2/libbzip2 version [0-9]+\\.[^ ]+ of [0-9]+ ")
  STRING(REGEX REPLACE ".* bzip2/libbzip2 version ([0-9]+\\.[^ ]+) of [0-9]+ .*" "\\1" BZIP2_VERSION_STRING "${BZLIB_H}")
ENDIF()

# handle the QUIETLY and REQUIRED arguments and set BZip2_FOUND to TRUE if
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(BZip2
                                  REQUIRED_VARS BZIP2_LIBRARIES BZIP2_INCLUDE_DIRS
                                  VERSION_VAR BZIP2_VERSION_STRING)

IF(BZIP2_FOUND)
  INCLUDE(CheckLibraryExists)
  CHECK_LIBRARY_EXISTS("${BZIP2_LIBRARIES}" BZ2_bzCompressInit "" BZIP2_NEED_PREFIX)
ENDIF()

MARK_AS_ADVANCED(BZIP2_INCLUDE_DIR)

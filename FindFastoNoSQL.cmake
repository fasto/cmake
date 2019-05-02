# FindFastoNoSQL.cmake - Try to find the fastonosql libraries
# Once done this will define
#
#  FASTONOSQL_FOUND - System has fastonosql
#  FASTONOSQL_INCLUDE_DIRS - The fastonosql include directory
#  FASTONOSQL_LIBRARIES - The libraries needed to use fastonosql
#  FASTONOSQL_VERSION_STRING - the version of fastonosql found (since CMake 2.8.8)

FIND_PATH(FASTONOSQL_INCLUDE_DIRS NAMES fastonosql/config.h
 HINTS /usr /usr/local /opt PATH_SUFFIXES include
)

FIND_LIBRARY(FASTONOSQL_CORE_LIBRARY NAMES fastonosql_core
 HINTS /usr /usr/local /opt
)

FIND_LIBRARY(FASTONOSQL_CORE_PRO_LIBRARY NAMES fastonosql_core_pro
 HINTS /usr /usr/local /opt
)

SET(FASTONOSQL_LIBRARIES ${FASTONOSQL_LIBRARIES} ${FASTONOSQL_CORE_LIBRARY} ${FASTONOSQL_CORE_PRO_LIBRARY})

IF(FASTONOSQL_INCLUDE_DIRS AND EXISTS "${FASTONOSQL_INCLUDE_DIRS}/config.h")
  FILE(STRINGS "${FASTONOSQL_INCLUDE_DIRS}/config.h" FASTONOSQL_CONFIG_H REGEX "^#define FASTONOSQL_VERSION_STRING \"[^\"]*\"$")
  STRING(REGEX REPLACE "^.*FASTONOSQL_VERSION_STRING \"(.*)\"" "\\1" FASTONOSQL_VERSION_STRING "${FASTONOSQL_CONFIG_H}")
ENDIF(FASTONOSQL_INCLUDE_DIRS AND EXISTS "${FASTONOSQL_INCLUDE_DIRS}/config.h")

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(fastonosql REQUIRED_VARS FASTONOSQL_LIBRARIES FASTONOSQL_INCLUDE_DIRS VERSION_VAR FASTONOSQL_VERSION_STRING)
MARK_AS_ADVANCED(FASTONOSQL_INCLUDE_DIRS FASTONOSQL_LIBRARIES)
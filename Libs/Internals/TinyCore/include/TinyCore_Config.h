
#pragma once

#ifndef BUILD_SHARED_CORE
#define TINYCORE_API
#endif

#if defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__)
#define PLATFORM_NAME "windows" // Windows
#define WIN32_LEAN_AND_MEAN
#define WIN_32_EXTRA_LEAN
#ifdef BUILD_SHARED_CORE
#undef TINYCORE_API
#ifdef TINYCORE_LIB_EXPORTS
#define TINYCORE_API __declspec(dllexport)
#else
#define TINYCORE_API __declspec(dllimport)
#endif
#endif
#ifdef _WIN64
// define something for Windows (64-bit only)
#else
// define something for Windows (32-bit only)
#endif
#elif defined(__CYGWIN__)
#define PLATFORM_NAME "windows"               // Windows
#elif defined(__APPLE__) && defined(__MACH__) // Apple OSX and iOS (Darwin)
#define PLATFORM_NAME "APPLE"
#include <TargetConditionals.h>
#if TARGET_IPHONE_SIMULATOR
// iOS, tvOS, or watchOS Simulator
#elif TARGET_OS_MACCATALYST
// Mac's Catalyst (ports iOS API into Mac, like UIKit).
#elif TARGET_OS_IPHONE
// iOS, tvOS, or watchOS device
#elif TARGET_OS_MAC
// Other kinds of Apple platforms
#else
#error "Unknown Apple platform"
#endif
#elif defined(__ANDROID__)
#define PLATFORM_NAME "android" // Android
#elif defined(__linux__)
#define PLATFORM_NAME                                                          \
  "linux" // Debian, Ubuntu, Gentoo, Fedora, openSUSE, RedHat, Centos and other
// linux
#elif defined(__unix__) || !defined(__APPLE__) && defined(__MACH__)
#include <sys/param.h>
#if defined(BSD)
#define PLATFORM_NAME "bsd" // FreeBSD, NetBSD, OpenBSD, DragonFly BSD
#endif
#elif defined(__hpux)
#define PLATFORM_NAME "hp-ux" // HP-UX
#elif defined(_AIX)
#define PLATFORM_NAME "aix" // IBM AIX
#elif defined(__sun) && defined(__SVR4)
#define PLATFORM_NAME "solaris" // Oracle Solaris, Open Indiana
#elif defined(_POSIX_VERSION)
// POSIX
#else
#define PLATFORM_NAME NULL
#endif
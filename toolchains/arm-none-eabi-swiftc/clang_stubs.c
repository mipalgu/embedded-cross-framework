//
//  clang_stubs.c
//  embedded-cross-framework
//
//  Created by Rene Hexel on 22/4/2023.
//  Copyright © 2023 Rene Hexel.  All rights reserved.
//

/// Do-nothing _init() function to satisfy the linker.
/// - Note: This function is weakly linked and can be overridden elsewhere.
__attribute__((weak)) void _init(void) {}

/// Do-nothing _fini() function to satisfy the linker.
/// - Note: This function is weakly linked and can be overridden elsewhere.
__attribute__((weak)) void _fini(void) {}

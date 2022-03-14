// SPDX-License-Identifier: Apache-2.0
// Copyright 2022 - 2022 Pionix GmbH and Contributors to EVerest
#include "ExampleReader.hpp"

namespace module {

void ExampleReader::init() {
    invoke_init(*p_example_reader_submodule);
}


void ExampleReader::ready() {
    invoke_ready(*p_example_reader_submodule);
}

} // namespace module

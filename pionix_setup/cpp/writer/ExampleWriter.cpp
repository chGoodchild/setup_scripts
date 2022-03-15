// SPDX-License-Identifier: Apache-2.0
// Copyright 2022 - 2022 Pionix GmbH and Contributors to EVerest
#include "ExampleWriter.hpp"

namespace module {

void ExampleWriter::init() {
    invoke_init(*p_example_writer_submodule);
}

void ExampleWriter::ready() {
    invoke_ready(*p_example_writer_submodule);
}

} // namespace module

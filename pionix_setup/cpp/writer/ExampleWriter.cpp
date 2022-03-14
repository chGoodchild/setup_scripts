// SPDX-License-Identifier: Apache-2.0
// Copyright 2022 - 2022 Pionix GmbH and Contributors to EVerest
#include "ExampleWriter.hpp"

namespace module {

void ExampleWriter::init() {
    invoke_init(*p_example_reader_submodule);
}

void ExampleReader::handle_set_tx_prescaler(int& tx_prescaler) {

}

void ExampleWriter::ready() {
    invoke_ready(*p_example_reader_submodule);
}

} // namespace module

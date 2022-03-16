
// SPDX-License-Identifier: Apache-2.0
// Copyright 2022 - 2022 Pionix GmbH and Contributors to EVerest

#include "example_readerImpl.hpp"

namespace module {
namespace example_reader_submodule {

void example_readerImpl::init() {

    // just report and send value back
    mod->r_example_writer_connection->subscribe_writer_published_var([this](int received_value){
        EVLOG(info) << "Incoming tx_prescaler: " << received_value;
        mod->r_example_writer_connection->call_set_tx_prescaler(received_value);
    });

}

void example_readerImpl::ready() {
}

} // namespace example_reader_submodule
} // namespace module
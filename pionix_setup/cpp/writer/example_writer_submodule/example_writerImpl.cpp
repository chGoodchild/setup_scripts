// SPDX-License-Identifier: Apache-2.0
// Copyright 2022 - 2022 Pionix GmbH and Contributors to EVerest

#include "example_writerImpl.hpp"

namespace module {
namespace example_writer_submodule {

void example_writerImpl::init() {

}

void example_writerImpl::ready() {
    this->writer_loop_thread = std::thread( [this] { run_writer_loop(); } );
}

void example_writerImpl::run_writer_loop() {
    EVLOG(debug) << "Starting writer loop";
    int counter = 1;

    // module main thread loop
    while (true) {
        EVLOG(debug) << "run_writer_loop: " << counter;
        // do something
        publish_writer_published_var(4 + (counter++ % 16));

        // suspend until next interval start
        std::this_thread::sleep_for(std::chrono::milliseconds(config.example_writer_tx_interval_ms * _tx_prescaler));
    }
}

void example_writerImpl::handle_set_tx_prescaler(int& tx_prescaler){
    // your code for cmd set_tx_prescaler goes here
    if (tx_prescaler > 0) {
        _tx_prescaler = (tx_prescaler % 16) + 4;
    }
    else {
        _tx_prescaler = 1;
    }
};

} // namespace example_writer_submodule
} // namespace module

// SPDX-License-Identifier: Apache-2.0
// Copyright Pionix GmbH and Contributors to EVerest
#ifndef EXAMPLE_WRITER_SUBMODULE_EXAMPLE_WRITER_IMPL_HPP
#define EXAMPLE_WRITER_SUBMODULE_EXAMPLE_WRITER_IMPL_HPP

//
// AUTO GENERATED - MARKED REGIONS WILL BE KEPT
// template version 0.0.2
//

#include <generated/example_writer/Implementation.hpp>

#include "../ExampleWriter.hpp"

// ev@75ac1216-19eb-4182-a85c-820f1fc2c091:v1
// insert your custom include headers here
#include <utils/thread.hpp>
// ev@75ac1216-19eb-4182-a85c-820f1fc2c091:v1

namespace module {
namespace example_writer_submodule {

struct Conf {
    int example_writer_tx_interval_ms;
};

class example_writerImpl : public example_writerImplBase {
public:
    example_writerImpl() = delete;
    example_writerImpl(Everest::ModuleAdapter* ev, const Everest::PtrContainer<ExampleWriter>& mod,
                                     Conf& config) :
        example_writerImplBase(ev, "example_writer_submodule"), mod(mod), config(config){};

    // ev@8ea32d28-373f-4c90-ae5e-b4fcc74e2a61:v1
    // insert your public definitions here
    void run_writer_loop();
    // ev@8ea32d28-373f-4c90-ae5e-b4fcc74e2a61:v1

protected:
    // command handler functions (virtual)
    virtual void handle_set_tx_prescaler(int& tx_prescaler) override;

    // ev@d2d1847a-7b88-41dd-ad07-92785f06f5c4:v1
    // insert your protected definitions here
    // ev@d2d1847a-7b88-41dd-ad07-92785f06f5c4:v1

private:
    const Everest::PtrContainer<ExampleWriter>& mod;
    const Conf& config;

    virtual void init() override;
    virtual void ready() override;

    // ev@3370e4dd-95f4-47a9-aaec-ea76f34a66c9:v1
    // insert your private definitions here
    int _tx_prescaler = 1;
    Everest::Thread writer_loop_thread;
    // ev@3370e4dd-95f4-47a9-aaec-ea76f34a66c9:v1
};

// ev@3d7da0ad-02c2-493d-9920-0bbbd56b9876:v1
// insert other definitions here
// ev@3d7da0ad-02c2-493d-9920-0bbbd56b9876:v1

} // namespace example_writer_submodule
} // namespace module

#endif // EXAMPLE_WRITER_SUBMODULE_EXAMPLE_WRITER_IMPL_HPP

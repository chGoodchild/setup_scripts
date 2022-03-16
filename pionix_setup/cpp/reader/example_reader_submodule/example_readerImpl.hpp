// SPDX-License-Identifier: Apache-2.0
// Copyright Pionix GmbH and Contributors to EVerest
#ifndef EXAMPLE_READER_SUBMODULE_EXAMPLE_READER_IMPL_HPP
#define EXAMPLE_READER_SUBMODULE_EXAMPLE_READER_IMPL_HPP

//
// AUTO GENERATED - MARKED REGIONS WILL BE KEPT
// template version 0.0.2
//

#include <generated/example_reader/Implementation.hpp>

#include "../ExampleReader.hpp"

// ev@75ac1216-19eb-4182-a85c-820f1fc2c091:v1
// insert your custom include headers here
// ev@75ac1216-19eb-4182-a85c-820f1fc2c091:v1

namespace module {
namespace example_reader_submodule {

struct Conf {};

class example_readerImpl : public example_readerImplBase {
public:
    example_readerImpl() = delete;
    example_readerImpl(Everest::ModuleAdapter* ev, const Everest::PtrContainer<ExampleReader>& mod,
                                     Conf& config) :
        example_readerImplBase(ev, "example_reader_submodule"), mod(mod), config(config){};

    // ev@8ea32d28-373f-4c90-ae5e-b4fcc74e2a61:v1
    // insert your public definitions here
    // ev@8ea32d28-373f-4c90-ae5e-b4fcc74e2a61:v1

protected:
    // no commands defined for this interface

    // ev@d2d1847a-7b88-41dd-ad07-92785f06f5c4:v1
    // insert your protected definitions here
    // ev@d2d1847a-7b88-41dd-ad07-92785f06f5c4:v1

private:
    const Everest::PtrContainer<ExampleReader>& mod;
    const Conf& config;

    virtual void init() override;
    virtual void ready() override;

    // ev@3370e4dd-95f4-47a9-aaec-ea76f34a66c9:v1
    // insert your private definitions here
    // ev@3370e4dd-95f4-47a9-aaec-ea76f34a66c9:v1
};

// ev@3d7da0ad-02c2-493d-9920-0bbbd56b9876:v1
// insert other definitions here
// ev@3d7da0ad-02c2-493d-9920-0bbbd56b9876:v1

} // namespace example_reader_submodule
} // namespace module

#endif // EXAMPLE_READER_SUBMODULE_EXAMPLE_READER_IMPL_HPP
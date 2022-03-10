// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 - 2021 Pionix GmbH and Contributors to EVerest
const { evlog, boot_module } = require('everestjs');

let message_A = "Example writer msg: ";
let number_A = 1;
let local_tx_prescaler = 4;
let counter = 0;

async function sendMessages(mod) {
    if(counter == local_tx_prescaler) {
        mod.provides.example_writer_submodule.publish.writer_published_string(message_A + (number_A++).toString());
        mod.provides.example_writer_submodule.publish.writer_published_var(2 + number_A % 60);
        counter = 0;
    }
    else {
        counter += 1;
    }
}

boot_module(async ({ setup, config }) => {
    // init
    evlog.info("Booting JsExampleWriter...");

    // API cmd to use by all other modules
    setup.provides.example_writer_submodule.register.set_tx_prescaler((mod, args) => {
        if(args === undefined) {
            return;
        }
        if((args.tx_prescaler >= 4) && (args.tx_prescaler <= 20)){
            local_tx_prescaler = args.tx_prescaler;

            evlog.info(`JsExampleWriter: Set writer interval prescaler to '${local_tx_prescaler}' resulting in an interval of '${local_tx_prescaler * config.impl.example_writer_submodule.example_writer_tx_interval_ms}'ms...`);
            return "Success";
        }
        else {
            evlog.error(`JsExampleWriter: New prescaler out of range: '${args.tx_prescaler}'!!!`);
            return "Error_OutOfRange";
        }
    });
}).then((mod) => {
    // output loop
    setInterval(sendMessages, mod.config.impl.example_writer_submodule.example_writer_tx_interval_ms, mod);
});
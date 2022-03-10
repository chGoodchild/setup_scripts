// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 - 2021 Pionix GmbH and Contributors to EVerest
const { evlog, boot_module } = require('everestjs');

let previous_message = "none";

boot_module(async ({ setup, info, config }) => {
    // init
    evlog.info("Booting JsExampleReader...");

    // setup "onReceive" actions
    setup.uses.example_writer_connection.subscribe.writer_published_string((mod, args)=>{
        mod.received_message = args;
        evlog.info(`JsExampleReader received message: '${mod.received_message}'`);
    });

    setup.uses.example_writer_connection.subscribe.writer_published_var((mod, args)=>{
        mod.received_integer = args;
        evlog.info(`JsExampleReader received variable value: '${mod.received_integer}'`);

        let msg = {
            tx_prescaler: (4 + (mod.received_integer % 16))
        };
        mod.uses.example_writer_connection.call.set_tx_prescaler(msg);
    });
}).then((mod) => {
    // empty main loop
});
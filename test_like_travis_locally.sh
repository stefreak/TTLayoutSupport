#!/bin/bash

xctool build-tests

xctool run-tests -test-sdk iphonesimulator7.1
xctool run-tests -test-sdk iphonesimulator8.1

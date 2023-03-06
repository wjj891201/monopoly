<?php

namespace xwaddress;

use xwaddress\Address\AddressInterface;

class AddressFactory
{
    public static function create(string $symbol, string $network, string $address): AddressInterface
    {
        $class  = '\xwaddress\Address\Asset\\' . ucfirst(strtolower($symbol));
        if (! class_exists($class)) {
            throw new \OutOfBoundsException("Address class: {$class} could not found.");
        }

        return new $class($symbol, $network, $address);
    }
}

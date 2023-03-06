<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Xem as XemValidator;

class Xem extends AbstractAddress
{
    protected $validators = [
        Network::XEM => XemValidator::class,
    ];
}

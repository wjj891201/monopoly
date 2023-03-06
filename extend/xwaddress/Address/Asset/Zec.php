<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Zec as ZecValidator;

class Zec extends AbstractAddress
{
    protected $validators = [
        Network::ZEC => ZecValidator::class,
    ];
}

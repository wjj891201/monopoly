<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Xrp as XrpValidator;

class Xrp extends AbstractAddress
{
    protected $validators = [
        Network::XRP => XrpValidator::class,
    ];
}

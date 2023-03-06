<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Ada as AdaValidator;

class Ada extends AbstractAddress
{
    protected $validators = [
        Network::ADA => AdaValidator::class,
    ];
}

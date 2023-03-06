<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Dash as DashValidator;

class Dash extends AbstractAddress
{
    protected $validators = [
        Network::DASH => DashValidator::class,
    ];
}

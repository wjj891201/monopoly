<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Bch as BchValidator;

class Bch extends AbstractAddress
{
    protected $validators = [
        Network::BCH => BchValidator::class,
    ];
}

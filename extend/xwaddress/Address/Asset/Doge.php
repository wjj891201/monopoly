<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Doge as DogeValidator;

class Doge extends AbstractAddress
{
    protected $validators = [
        Network::DOGE => DogeValidator::class,
    ];
}

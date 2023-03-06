<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Ltc as LtcValidator;

class Ltc extends AbstractAddress
{
    protected $validators = [
        Network::LTC => LtcValidator::class,
    ];
}

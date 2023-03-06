<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\TRC20 as TrxValidator;

class Btt extends AbstractAddress
{
    protected $networkAlias = [
        self::BTT => Network::TRC20,
        self::TRX => Network::TRC20,
    ];

    protected $validators = [
        Network::TRC20 => TrxValidator::class,
    ];
}

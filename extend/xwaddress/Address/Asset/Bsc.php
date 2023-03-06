<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\ERC20 as EthValidator;

class Bsc extends AbstractAddress
{
    protected $networkAlias = [
        self::BSC => Network::BEP20,
    ];

    protected $validators = [
        Network::BEP20 => EthValidator::class,
    ];
}

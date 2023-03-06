<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\ERC20 as EthValidator;

class Link extends AbstractAddress
{
    protected $networkAlias = [
        self::LINK => Network::ERC20,
        self::ETH => Network::ERC20
    ];

    protected $validators = [
        Network::ERC20 => EthValidator::class,
    ];
}

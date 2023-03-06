<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\AddressInterface;
use xwaddress\Address\Network;
use \xwaddress\Address\Validator\ERC20 as EthValidator;

class Mkr extends AbstractAddress
{
    protected $networkAlias = [
        self::MKR => Network::ERC20,
        self::ETH => Network::ERC20
    ];

    protected $validators = [
        Network::ERC20 => EthValidator::class,
    ];
}

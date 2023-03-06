<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\ERC20 as EthValidator;
use xwaddress\Address\Validator\OMNI as UsdtValidator;
use xwaddress\Address\Validator\TRC20 as TrxValidator;

class Usdt extends AbstractAddress
{
    protected $networkAlias = [
        self::USDT => Network::OMNI,
        self::ETH => Network::ERC20,
        self::TRX => Network::TRC20,
        self::BSC => Network::BEP20,
    ];

    protected $validators = [
        Network::ERC20 => EthValidator::class,
        Network::BEP20 => EthValidator::class,
        Network::OMNI => UsdtValidator::class,
        Network::TRC20 => TrxValidator::class
    ];
}

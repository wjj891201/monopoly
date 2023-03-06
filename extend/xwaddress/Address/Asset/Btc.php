<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use \xwaddress\Address\Validator\Btc as BtcValidator;

class Btc extends AbstractAddress
{
    protected $validators = [
        Network::BTC => BtcValidator::class
    ];
}

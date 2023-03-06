<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Btg as BtgValidator;

class Btg extends AbstractAddress
{
    protected $validators = [
        Network::BTG => BtgValidator::class,
    ];
}

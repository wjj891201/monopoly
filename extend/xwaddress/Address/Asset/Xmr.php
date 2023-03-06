<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Xmr as XmrValidator;

class Xmr extends AbstractAddress
{
    protected $validators = [
        Network::XMR => XmrValidator::class,
    ];
}

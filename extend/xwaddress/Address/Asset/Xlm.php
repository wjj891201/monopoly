<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Xlm as XlmValidator;

class Xlm extends AbstractAddress
{
    protected $validators = [
        Network::XLM => XlmValidator::class,
    ];
}

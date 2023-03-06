<?php

namespace xwaddress\Address\Asset;

use xwaddress\Address\AbstractAddress;
use xwaddress\Address\Network;
use xwaddress\Address\Validator\Eos as EosValidator;

class Eos extends AbstractAddress
{
    protected $validators = [
        Network::EOS => EosValidator::class,
    ];
}

<?php

namespace xwaddress\Address\Validator;

class OMNI extends AbstractBase58
{
    protected $base58PrefixToHexVersion = [
        '1' => '00',
        '3' => '05'
    ];
}

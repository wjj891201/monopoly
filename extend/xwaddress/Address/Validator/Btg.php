<?php

namespace xwaddress\Address\Validator;

class Btg extends AbstractBase58
{
    protected $base58PrefixToHexVersion = [
        'prod' => [
            'G' => '26', // G**
            'A' => '17', // A**
        ]
    ];
}

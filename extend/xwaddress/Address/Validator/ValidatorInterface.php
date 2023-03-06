<?php

namespace xwaddress\Address\Validator;

use xwaddress\Address\AddressInterface;

interface ValidatorInterface
{
    public function __construct(AddressInterface $address);

    public function validate(): bool;
}

<?php

namespace app\service;


use think\captcha\Captcha as BaseCaptcha;
use think\facade\Cache;
use think\Response;

class CaptchaService extends BaseCaptcha
{
    public $key = '';

    protected function generate(): array
    {
        $data = parent::generate();
        Cache::set('captcha_' . $this->key, $data['key'], 3600);
        return $data;
    }

    public function check(string $code, string $key = ''): bool
    {
        $this->key = $key;
        $cache_code = Cache::get('captcha_' . $this->key);
        if (!$cache_code) {
            return false;
        }


        $code = mb_strtolower($code, 'UTF-8');

        $res = password_verify($code, $cache_code);

        if ($res) {
            Cache::delete('captcha_' . $this->key);
        }
        return true;
    }

    public function create(string $config = null, bool $api = false, string $key = ''): Response
    {
        $this->key = $key;
        return parent::create($config, $api);
    }
}
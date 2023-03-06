<?php

namespace app\facade;


use think\Facade;
use Endroid\QrCode\Color\Color;
use Endroid\QrCode\Encoding\Encoding;
use Endroid\QrCode\ErrorCorrectionLevel\ErrorCorrectionLevelLow;
use Endroid\QrCode\QrCode;
use Endroid\QrCode\Label\Label;
use Endroid\QrCode\Logo\Logo;
use Endroid\QrCode\RoundBlockSizeMode\RoundBlockSizeModeMargin;
use Endroid\QrCode\Writer\PngWriter;
use think\facade\Config;

class QrCodeFacade extends Facade
{


    /**
     * 生成二维码
     * @param string $url
     * @return string
     */
    public static function createCode(string $url, int $storeID)
    {
        $writer = new PngWriter();
        $qrCode = QrCode::create($url)//跳转的url地址
        ->setEncoding(new Encoding('UTF-8'))    //设置编码格式
        ->setErrorCorrectionLevel(new ErrorCorrectionLevelLow())    //设置纠错级别为低
        ->setSize(300)      //大小
        ->setMargin(10)     //边距
        ->setRoundBlockSizeMode(new RoundBlockSizeModeMargin())     //设置圆轮大小边距
        ->setForegroundColor(new Color(0, 0, 0))        //前景色
        ->setBackgroundColor(new Color(255, 255, 255));       //背景色
//        $logo = Logo::create('static/haha.jpg')             //logo的照片路径
//        ->setResizeToWidth(20);                 //logo的大小
//        $label = Label::create('测试扫码')      //二维码下面的文字
//        ->setTextColor(new Color(0, 0, 0)); //文字的颜色
        $result = $writer->write($qrCode, null, null);
        header('Content-Type: ' . $result->getMimeType());
        $result->getString();

        $qrcode = 'store_' . $storeID . '.png';
        //二维码目录
        $rootPath = Config::get('qrcode.root_dir');
        $filePath = Config::get('qrcode.cache_dir');

        $result->saveToFile($rootPath.'/'.$filePath . '/' . $qrcode);


        $domain = Config::get('filesystem.url');

        return $domain . '/' . $filePath . '/' . $qrcode;
    }

}
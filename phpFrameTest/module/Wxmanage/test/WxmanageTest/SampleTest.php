<?php
/**
 * Zend Framework (http://framework.zend.com/)
 *
 * @link      http://github.com/zendframework/ZendSkeletonModule for the canonical source repository
 * @copyright Copyright (c) 2005-2014 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace WxmanageTest;
use WxmanageTest\Framework\TestCase;

require 'Framework/TestCase.php';
class SampleTest extends TestCase
{
	public function testSetLocator()
	{
	}

    public function testSample()
    {
        self::$locator = 'Zend\Di\LocatorInterface';
        $this->assertInstanceOf('Zend\Di\LocatorInterface', $this->getLocator());
    }
}

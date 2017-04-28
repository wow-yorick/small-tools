<?php
/**
 * Zend Framework (http://framework.zend.com/)
 *
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2014 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace ApplicationTest\Controller;

use Zend\Test\PHPUnit\Controller\AbstractHttpControllerTestCase;

class NewsControllerTest extends AbstractHttpControllerTestCase
{
	protected $traceError = true;

	public function setUp() {
		$this->setApplicationConfig(
			include dirname(dirname(dirname(dirname(dirname(__DIR__))))).'/config/application.config.php'	
		);
		parent::setUp();
	}

	public function testIndexActionCanBeAccessed()
	{
		$this->dispatch('/application');
		$this->assertResponseStatusCode(200);
	 
		$this->assertModuleName('Application');
		$this->assertControllerName('Application\Controller\Index');
		$this->assertControllerClass('IndexController');
		$this->assertMatchedRouteName('application');
	}
}

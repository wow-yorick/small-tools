<?php
/**
 * Zend Framework (http://framework.zend.com/)
 *
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2014 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Application\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Application\Model\NewsTable;

class NewsController extends AbstractActionController
{
	protected $adminTable;

	public function __construct(){
	}

    public function indexAction()
    {
		echo "test controller";
		exit;
    }

	public function listAction() {
		$paginator = $this->getAdminTable()->fetchAll();

		$view = new ViewModel();
		$view->setTemplate("application/news/list.phtml");
		$view->setVariable('paginator',$paginator);
		return $view;
	}

	public function editAction() {
		echo 234;
		exit;
	}

	private function getAdminTable() {
		if(!$this->adminTable){
			$sm = $this->getServiceLocator();
			$this->adminTable = $sm->get('Application\Model\NewsTable');
		}

		return $this->adminTable;
	}
}

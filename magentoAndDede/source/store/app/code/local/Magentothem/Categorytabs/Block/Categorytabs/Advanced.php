<?php
class Magentothem_Categorytabs_Block_Categorytabs_Advanced extends Mage_Catalog_Block_Product_Abstract
{
   protected function _construct()
   { 
    // if($this->getConfig('enabled') != 1) return false;
	   parent::_construct();
   }
   
    protected function _beforeToHtml(){
        return parent::_beforeToHtml();
    }
    public function getTitle(){
        return $this->getData('title');
    }
    
   //public function getDescription() {
   //     return $this->getData('des');
   // }
	
	
   public function getIdentify() {
	    return $this->getData('identify');
    }
	
    public function getProductsCount()
    {
        return $this->getData('products_count');
    }
	
	public function getProductsOnRow() {
	    return $this->getData('product_on_row');
    }
	public function getConfig($att) {
		$config = Mage::getStoreConfig('categorytabs');
		if (isset($config['categorytabs_config']) ) {
			$value = $config['categorytabs_config'][$att];
			return $value;
		} else {
			throw new Exception($att.' value not set');
		}
	}
	
	function getProductCate($id = NULL) {
        $storeId = Mage::app()->getStore()->getId();
        $_category = Mage::getModel('catalog/category')->load($id);
        $product = Mage::getModel('catalog/product');
        $json_products = array();
        //load the category's products as a collection
        $_productCollection = $product->getCollection()
                ->addAttributeToSelect('*')
                ->addCategoryFilter($_category)
			->addMinimalPrice()
			->addUrlRewrite()
			->addTaxPercents()			
			->addStoreFilter();
				Mage::getSingleton('catalog/product_status')->addVisibleFilterToCollection($_productCollection);
				Mage::getSingleton('catalog/product_visibility')->addVisibleInCatalogFilterToCollection($_productCollection);
		$productLimits = $this->getProductsCount();
		if(!$productLimits) $productLimits = 10;
		$_productCollection->setPageSize($productLimits);
        $_productCollection->load();
		return $_productCollection;
		
    }
}

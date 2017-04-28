<?php
function autoload($classname){
	$classpath = dirname(__DIR__).'/src/'.$classname.'.php';
	if(file_exists($classpath)){
		require_once($classpath);
	}
	else{
		echo 'class file'.$classpath.'not found!';
	}
}

autoload('Game');

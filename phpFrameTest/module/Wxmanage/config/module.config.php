<?php
return array(
	'router' => array(
        'routes' => array(
            // The following is a route to simplify getting started creating
            // new controllers and actions without needing to create a new
            // module. Simply drop new controllers in, and you can access them
            // using the path /application/:controller/:action
            'wxmanage' => array(
                'type'    => 'Literal',
                'options' => array(
                    'route'    => '/wxmanage',
                    'defaults' => array(
                        '__NAMESPACE__' => 'Wxmanage\Controller',
                        'controller'    => 'Index',
                        'action'        => 'index',
                    ),
                ),
                'may_terminate' => true,
                'child_routes' => array(
                    'default' => array(
                        'type'    => 'Segment',
                        'options' => array(
                            'route'    => '/[:controller[/:action]]',
                            'constraints' => array(
                                'controller' => '[a-zA-Z][a-zA-Z0-9_-]*',
                                'action'     => '[a-zA-Z][a-zA-Z0-9_-]*',
                            ),
                            'defaults' => array(
                            ),
                        ),
                    ),
                ),
            ),
        ),
    ),
	'controllers' => array(
        'invokables' => array(
            'Wxmanage\Controller\Index' => 'Wxmanage\Controller\IndexController',
        ),
	),
	'view_manager' => array(
        'strategies' => array(
            'ViewJsonStrategy',
        ),
    ),
);

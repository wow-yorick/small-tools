<?php
namespace Application\Model;

class News {

    public $id;

    public $username;

    public $fullname;

    public $password;

    public function exchangeArray($data){

        $this->id              = (isset($data['id'])) ? $data['id'] : null;

        $this->username              = (isset($data['username'])) ? $data['username'] : null;

        $this->fullname       = (isset($data['fullname'])) ? $data['fullname'] : null;

        $this->password        = (isset($data['password'])) ? $data['password'] : null;

    }

    public function getArrayCopy(){

        return get_object_vars($this);

	}

}

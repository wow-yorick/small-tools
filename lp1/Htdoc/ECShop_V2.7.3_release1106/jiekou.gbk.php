<?php
/*
����: ECShop_V2.7.3_release1106 �������½�����ӿ�
ʱ��: 2013/9/25 17:13:02
����: ��������(QQ: 345738904)
����: �μ����� PS: ǿ�ҽ����޸�Ĭ�Ͻӿ�����!!!
ʹ��: �����ļ�������վ��Ŀ¼��, ���·��ʾ��: D:\Htdoc\ECShop_V2.7.3_UTF8_release1106\jiekou.php

�����ֶ�: title
�����ֶ�: file
Ĭ��ʹ���ֶ�: title  content author add_time
��ʹ�������ֶ���Ϣ, ��ο�����ʾ������

ʾ������
$_POST = array(
	'title' => '��������-'. date('Y-m-d H:i:s'), //����
	'article_cat' => 2, //���·���ID
	'article_type' => 1, //������Ҫ�� 0��ͨ 1�ö�
	'is_open' => '1', //�Ƿ���ʾ 0����ʾ 1��ʾ
	'author' => '��������', //��������
	'author_email' => 'qingwanyushi@gmail.com', //����email
	'keywords' => '�ؼ���1,�ؼ���2,�ؼ���3', //SEO-�ؼ���
	'content' => '������������-'. date('Y-m-d H:i:s'), //��������
	'file_url' => 'http://baidu.com/demo.jpg', //�ļ���ַ
	'link_url' => 'http://locoy.com/', //�ⲿ����
	'description' => 'SEO-����', //��ҳ����
	'add_time' => '2013/9/25 16:55:08', //���ʱ��
);

���������˵���ȡ��ַʾ��: http://your-domain.com/jiekou.php?cattree=true
*/
header('Content-type:text/html;charset=GBK');

//!!! �ӿ�������֤,�ڴ��޸Ľӿ����� !!!
if($_REQUEST['password'] != 'thisisnotpwd') jiekou_msg(0, '�ӿ��������!');

define('IN_ECS', true);

require(dirname(__FILE__) . '/includes/init.php');
require_once(ROOT_PATH . 'includes/cls_image.php');

//��ȡ���������˵�
if(!empty($_REQUEST['cattree'])) get_cat_tree();

/* �����ϴ����ļ����� */
$allow_file_types = '|GIF|JPG|PNG|BMP|SWF|DOC|XLS|PPT|MID|WAV|ZIP|RAR|PDF|CHM|RM|TXT|';

if(!isset($_POST['title']) || $_POST['title'] === '') jiekou_msg(0, '���±��ⲻ��Ϊ��!');
if(!isset($_POST['content']) || $_POST['content'] === '') jiekou_msg(0, '�������ݲ���Ϊ��!');

$_POST['is_open'] = 1; //�Ƿ���ʾ

/*����Ƿ��ظ�*/
$is_exist = $db->getone("select * from ". $ecs->table('article') ." where title ='". $_POST['title'] ."' and cat_id = '". $_POST['article_cat'] ."'");
if ($is_exist)
{
	jiekou_msg(0, '�Ѵ��ڵ����±���: '. stripslashes($_POST['title']));
}

/* ȡ���ļ���ַ */
$file_url = '';
if ((isset($_FILES['file']['error']) && $_FILES['file']['error'] == 0) || (!isset($_FILES['file']['error']) && isset($_FILES['file']['tmp_name']) && $_FILES['file']['tmp_name'] != 'none'))
{
    // ����ļ���ʽ
    if (!check_file_type($_FILES['file']['tmp_name'], $_FILES['file']['name'], $allow_file_types))
    {
    	jiekou_msg(0, '������ĸ�������!');
    }

    // �����ļ�
    $res = upload_article_file($_FILES['file']);
    if ($res != false)
    {
        $file_url = $res;
    }
}

if ($file_url == '')
{
    $file_url = $_POST['file_url'];
}

/* �������´򿪷�ʽ */
if ($file_url == '')
{
    $open_type = 0;
}
else
{
    $open_type = $_POST['content'] == '' ? 1 : 2;
}

/*��������*/
$add_time = !empty($_POST['add_time']) ? strtotime($_POST['add_time']) : gmtime();

if (empty($_POST['cat_id']))
{
    $_POST['cat_id'] = 0;
}
$sql = "INSERT INTO ".$ecs->table('article')."(title, cat_id, article_type, is_open, author, ".
            "author_email, keywords, content, add_time, file_url, open_type, link, description) ".
        "VALUES ('$_POST[title]', '$_POST[article_cat]', '$_POST[article_type]', '$_POST[is_open]', ".
            "'$_POST[author]', '$_POST[author_email]', '$_POST[keywords]', '$_POST[content]', ".
            "'$add_time', '$file_url', '$open_type', '$_POST[link_url]', '$_POST[description]')";
$db->query($sql);

clear_cache_files(); // �����صĻ����ļ�

jiekou_msg(1, '�������!');

//�ϴ��ļ�
function upload_article_file($upload)
{
    if (!make_dir("./" . DATA_DIR . "/article"))
    {
        /* ����Ŀ¼ʧ�� */
        return false;
    }

    $filename = cls_image::random_filename() . substr($upload['name'], strpos($upload['name'], '.'));
    $path     = ROOT_PATH. DATA_DIR . "/article/" . $filename;

    if (move_upload_file($upload['tmp_name'], $path))
    {
        return DATA_DIR . "/article/" . $filename;
    }
    else
    {
        return false;
    }
}

//��ȡ���������˵�
function get_cat_tree() {
	exit('<select>'. article_cat_list() .'</select>');
}

//�ӿ���ʾ��Ϣ
function jiekou_msg($is_success, $notice) {
	$msg = '';
	if($is_success) {
		$msg .= '�ɹ�! ';
	} else {
		$msg .= 	'ʧ��! ';
	}
	$msg .= $notice;
	exit($msg);
}
?>
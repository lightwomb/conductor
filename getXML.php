<?php
    header('Content-type: application/xml');
    echo file_get_contents('http://ws.audioscrobbler.com/2.0/user/loBoobOscill8r/topartists.xml?period=3month');
    //echo file_get_contents($_GET['file']);
?>
<?php if(basename(__file__) == 'fields.php') exit; ?>
<?xml version="1.0" encoding="utf-8"?>
<xml><Fields><field><alias>subject</alias><name>Subject</name><func>notempty</func><is>subject</is></field><field><alias>name</alias><name>Name</name><message>This field can't stay empty</message><func>notempty</func><is>name</is></field><field><alias>email</alias><name>Email</name><message>Enter with a valid email!</message><func>email</func><is>email</is></field><field><alias>message</alias><name>Message</name><message>This field can't stay empty</message><func>notempty</func><is>custom</is></field></Fields></xml>
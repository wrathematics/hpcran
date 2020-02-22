<?php

function authorized_users_lookup($db, $acct)
{
  $query = "SELECT COUNT(*) AS count FROM users WHERE account=:acct";
  $prepared = $db->prepare($query);
  $prepared->bindValue(':acct', $acct, SQLITE3_TEXT);
  $res = $prepared->execute();
  
  $ct = $res->fetchArray()['count'];
  return ($ct > 0);
}

?>

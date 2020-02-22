<?php

function authorized_users_lookup($db, $acct)
{
  $query = "SELECT COUNT(*) AS count FROM users WHERE account=";
  $res = $db->query($query . "'" . $acct . "'");
  $ct = $res->fetchArray()['count'];
  return ($ct > 0);
}

?>

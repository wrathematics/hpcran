<?php

function authorized_users_lookup($db, $email)
{
  $query = "SELECT COUNT(*) AS count FROM users WHERE account=";
  $res = $db->query($query . "'" . $email . "'");
  $ct = $res->fetchArray()['count'];
  return ($ct > 0);
}

?>

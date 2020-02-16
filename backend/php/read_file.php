<?php

function read_file($fn)
{
  $f = fopen($fn, "r") or die("can't open file for reading");
  $fs = filesize($fn);
  if ($fs == 0 || $fs == 1)
    die("invalid input file");
  
  $ret = fread($f, $fs-1);
  fclose($f);
  return $ret;
}

?>

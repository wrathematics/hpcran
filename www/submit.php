<?php
$uploaddir = '/tmp/';

function get_pkg_email($pkg)
{
  #$cmd = 
}

function is_email_in_ghemails($pkg_sub_email, $ghemails)
{
  for ($i=0; $i<count($ghemails); $i++)
  {
    if ($pkg_sub_email == $ghemails[$i]->{"email"})
      return True;
  }

  return False;
}



if ($_SERVER["REQUEST_METHOD"] == "POST")
{
  if(isset($_FILES["package"]) && $_FILES["package"]["error"] == 0)
  {
    $allowed = array("jpg" => "image/jpg", "jpeg" => "image/jpeg", "gif" => "image/gif", "png" => "image/png");
    $filename = $_FILES["package"]["name"];
    $filetype = $_FILES["package"]["type"];
    $filesize = $_FILES["package"]["size"];
    
    $ext = pathinfo($filename, PATHINFO_EXTENSION);
    if (!array_key_exists($ext, $allowed))
      die("ERROR: Please select a valid file format.");
    
    $maxsize = 10 * 1000 * 1000;
    if ($filesize > $maxsize)
      die("ERROR: File size is larger than the allowed limit.");
    
    // Verify MYME type of the file
    if(in_array($filetype, $allowed))
    {
      if(file_exists($uploaddir . $filename))
        echo "ERROR: " . $filename . " already in staging area";
      else
      {
        move_uploaded_file($_FILES["package"]["tmp_name"], $uploaddir . $filename);
        echo "Package uploaded successfully.";
        echo "<br>File name: " . $filename;
        echo "<br>File size: " . $filesize;
      } 
    }
    else
      echo "ERROR: There was a problem uploading your file. Please try again."; 
  }
  else
    echo "ERROR: " . $_FILES["package"]["error"];
}
?>

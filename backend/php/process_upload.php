<?php
$uploaddir = '/tmp/';

session_start();

# heavily modified from https://www.tutorialrepublic.com/php-tutorial/php-file-upload.php
if ($_SERVER["REQUEST_METHOD"] == "POST")
{
  if (isset($_FILES["package"]) && $_FILES["package"]["error"] == 0)
  {
    $allowed = array("gz" => "application/gzip");
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
    if (in_array($filetype, $allowed))
    {
      if (file_exists($uploaddir . $filename))
        die("ERROR: " . $filename . " already in staging area");
      else
      {
        move_uploaded_file($_FILES["package"]["tmp_name"], $uploaddir . $filename);
        echo "Package uploaded successfully.";
        echo "<br>File name: " . $filename;
        echo "<br>File size: " . $filesize;
        
        $rcmd = "Rscript -e 'args = commandArgs(trailingOnly=TRUE);
        hpcran::add_package(\"" . $uploaddir . $filename . "\", root=\"/hpcran/\", emails=args)'";
        
        for ($i=0; $i<count($_SESSION['ghemails']); $i++)
        {
          if ($_SESSION['ghemails'][$i]->{"verified"})
            $rcmd = $rcmd . " " . $_SESSION['ghemails'][$i]->{"email"};
        }

        $rcmd = $rcmd . " 2>&1";
        
        echo "<br><br>";
        $errmsg = system($rcmd);
      }
    }
    else
      die("ERROR: There was a problem uploading your file. Please try again.");
  }
  else
    die("ERROR: " . $_FILES["package"]["error"]);
}

?>

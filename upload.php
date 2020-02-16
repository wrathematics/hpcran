<!DOCTYPE html>
<html>
<body>

<h1>Rules</h1>

Last updated 2/16/2020, wrathematics.

<h3>General</h3>
<ol>
  <li>You must login with your GitHub account (link below) and authenticate the OAuth app.</li>
  <ul>
    <li>The app reads your username and all emails, including private ones.</li>
    <li>None of your email information is stored long term. It is only used for authentication.</li>
    <li>None of your information is shared with any other party.</li>
  </ul>
  <li>Your GitHub account must be manually approved to upload packages. If you are interested in publishing packages on hpcran, please contact the administrator.</li>
  <li>At least one <b>verified</b> email address on your GitHub account must match the maintainer email in package submission.</li>
  <li>Uploaded packages must have been built with <code>R CMD build</code>, and as such should be valid <code>.tar.gz</code> source files.</li>
</ol>

<h3>Updates</h3>
<ol>
  <li>The updated package version must be greater than the previously published version.</li>
  <li>Your <b>verified</b> GitHub email address must match the maintainer email address in the previously published package.</li>
  <li>The maintainer email address in the package update must match the maintainer email address in the previously published version of the package.</li>
  <li>If you need to change your maintainer email address on your package(s), please contact the administrator.</li>
</ol>

Violation of any of the rules will lead to an error in the upload process.
Anti-social circumventing of the rules may result in a ban from uploading packages
to hpcran.



<h1>Package Upload</h1>

<?php
include "/hpcran/upload/php/login.php";
?>

</body>
</html>

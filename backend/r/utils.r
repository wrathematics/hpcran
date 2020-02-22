extract_description = function(package, root)
{
  p = sub(x=package, pattern="_.*", replacement="")
  f = paste0(root, "/cran/src/contrib/", package)
  df = paste0(p, "/DESCRIPTION")
  
  cmd = paste("tar --strip-components=1 -zxf", f, "-C /tmp", df)
  system(cmd)
  desc = read.dcf("/tmp/DESCRIPTION")
  file.remove("/tmp/DESCRIPTION")
  
  desc[1, ]
}


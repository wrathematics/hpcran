get_package_files = function(root)
{
  cranroot = paste0(root, "/src/contrib/")
  dir(cranroot, pattern=".tar.gz", full.names=TRUE)
}



get_package_list = function(root)
{
  readRDS(paste0(root, "/src/contrib/PACKAGES.rds"))
}



extract_description_from_tgz = function(file)
{
  package_name = pkgname(file)
  descfile = paste0(package_name, "/DESCRIPTION")
  
  cmd = paste("tar --strip-components=1 -zxf", file, "-C /tmp", descfile)
  system(cmd)
  desc = read.dcf("/tmp/DESCRIPTION")
  file.remove("/tmp/DESCRIPTION")
  
  desc[1, ]
}



get_package_email = function(file)
{
  desc = extract_description_from_tgz(file)
  maintainer = desc["Maintainer"]
  email = gsub(maintainer, pattern="(.*<|>)", replacement="")
  names(email) = NULL
  email
}

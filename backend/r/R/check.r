check_for_file = function(file, files, package_name, should_have)
{
  test = (length(grep(files, pattern=paste0(package_name, "/", file))) > 0)
  if ((should_have && !test) || (!should_have && test))
    stop("invalid R package archive. Did you create this with 'R CMD build' ?")
}

check_package = function(pkg)
{
  if (!grepl(pkg, pattern="[.]tar[.]gz$"))
    stop("invalid R package archive. Did you create this with 'R CMD build' ?")
  
  package_name = pkgname(pkg)
  
  cmd = paste('tar --exclude="*/*/*" -tf', pkg)
  files = system(cmd, intern=TRUE)
  
  check_for_file("DESCRIPTION", files, package_name, should_have=TRUE)
  check_for_file("NAMESPACE", files, package_name, should_have=TRUE)
  check_for_file(".git", files, package_name, should_have=FALSE)
  check_for_file(".Rbuildignore", files, package_name, should_have=FALSE)
  
  invisible(TRUE)
}



check_email = function(maintainer, emails)
{
  for (email in emails)
  {
    if (email == maintainer)
      return(invisible(TRUE))
  }
  
  stop("Maintainer email address in published package does not match any verified email addresses on this GitHub account")
}



check_version = function(pkg, packages)
{
  ver_old = package_version(packages[pkgname(pkg), "Version"])
  ver_new = pkgver(pkg)
  if (ver_new <= ver_old)
    stop(paste0("submitted package version=", ver_new, " is not greater than existing=", ver_old))
  
  invisible(TRUE)
}

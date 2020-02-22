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

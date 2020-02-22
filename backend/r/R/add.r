add_package_internals = function(pkg, root="/hpcran/", emails=NULL)
{
  packages = readRDS(paste0(root, "/src/contrib/PACKAGES.rds"))
  package_name = pkgname(pkg)
  
  maintainer = get_package_email(pkg)
  check_email(maintainer, emails)
  
  if (package_name %in% packages[, 1])
  {
    pkg_old = paste0(root, "/src/contrib/", package_name, "_", packages[package_name, "Version"], ".tar.gz")
    maintainer_old = get_package_email(pkg_old)
    if (maintainer != maintainer_old)
      stop("Maintainer addresses from existing and uploaded packages do not match")
    
    check_version(pkg, packages)
    
    archive = paste0(root, "/src/contrib/Archive/", pkgname(pkg), "/", basename(pkg_old))
    file.move(from=pkg_old, to=archive)
  }
  else
    dir.create(paste0(root, "/src/contrib/Archive/", pkgname(pkg)))
  
  
  file.move(from=pkg, to=paste0(root, "/src/contrib/", basename(pkg)))
  update_ranfiles(root=root)
  update_all_html(root=root)
  
  invisible(TRUE)
}



#' add_package
#' 
#' Add/update package to the archive.
#' 
#' @param pkg File path of package in staging area.
#' @param root hpcran root path
#' @param emails list of verified emails
#' 
#' @export
add_package = function(pkg, root="/hpcran/", emails=NULL)
{
  v = tryCatch(add_package_internals(pkg, root, emails), error=identity)
  if (inherits(v, "simpleError"))
  {
    file.remove(pkg)
    msg = paste("ERROR: ", v$message, "\n")
  }
  else
    msg = "Package was successfully processed and is on hpcran now."

  cat(msg)
}

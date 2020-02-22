#' regenerate
#' 
#' Regenerate the package html, RAN-files, and archive paths.
#' 
#' @param root hpcran root path
#' 
#' @export
regenerate = function(root="/hpcran/")
{
  # create archive directories
  packages = get_package_files(root)
  for (pkg in packages)
  {
    archive = paste0(root, "/src/contrib/Archive/", pkgname(pkg))
    if (!dir.exists(archive))
      dir.create(archive)
  }
  
  # update everything
  update_ranfiles(root=root)
  update_all_html(root=root)

  invisible(TRUE)
}

update_ranfiles = function(root="/hpcran/")
{
  cranroot = paste0(root, "/src/contrib")
  tools::write_PACKAGES(cranroot, type="source")
  
  invisible(TRUE)
}



update_all_html = function(root="/hpcran/")
{
  packages = get_package_files(root)
  descs = lapply(packages, extract_description_from_tgz)
  
  generate_packages_page(root=root, descs=descs)
  generate_package_pages(root=root, descs=descs)
  
  invisible(TRUE)
}

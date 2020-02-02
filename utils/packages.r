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



mat_to_html_table = function(x)
{
  cat("<table style=\"width:100%\">\n")
  
  if (!is.null(colnames(x)))
  {
    cat("  <tr>\n")
    for (j in 1:ncol(x))
      cat("    <th>", colnames(x)[j], "</th>\n")
    cat("  </tr>\n")
  }
  
  for (i in 1:nrow(x))
  {
    cat("  <tr>\n")
    for (j in 1:ncol(x))
      cat("    <th>", x[i, j], "</th>\n")
    cat("  </tr>\n")
  }
  cat("</table>\n")
}



packages_table = function(descs)
{
  tbl = matrix("", length(descs), 3)
  colnames(tbl) = c("Package", "Title", "Tags")
  
  for (i in 1:nrow(tbl))
  {
    pkg = descs[[i]]["Package"]
    tbl[i, 1] = paste0("<a href=\"packages/", pkg, ".html\">", pkg, "</a>")
    tbl[i, 2] = descs[[i]]["Title"]
    tags = descs[[i]]["HPCRAN"]
    tbl[i, 3] = ifelse(is.na(tags), "", tags)
  }
  
  mat_to_html_table(tbl)
}



package_table = function(i, descs)
{
  append = function(tbl, field)
  {
    x = descs[[i]][field]
    names(x) = NULL
    if (!is.na(x))
      rbind(tbl, c(field, x))
    else
      tbl
  }
  
  tbl = matrix("", 0, 2)
  
  tbl = append(tbl, "Version")
  tbl = append(tbl, "Depends")
  tbl = append(tbl, "Imports")
  tbl = append(tbl, "Author")
  tbl = append(tbl, "Maintainer")
  tbl = append(tbl, "BugReports")
  tbl = append(tbl, "License")
  tbl = append(tbl, "URL")
  tbl = append(tbl, "NeedsCompilation")
  tbl = append(tbl, "SystemRequirements")
  
  mat_to_html_table(tbl)
}



generate_packages_page = function(root, descs)
{
  pre = readLines(paste0(root, "www/utils/pre.html"))
  hdr = "<h1>Available HPCRAN Packages</h1>\n"
  tbl = capture.output(packages_table(descs))
  pst = readLines(paste0(root, "www/utils/post.html"))
  
  f = paste0(root, "/www/packages.html")
  cat("<!--Automatically generated. Do not edit by hand-->\n\n", file=f, append=FALSE)
  cat(paste(pre, collapse="\n"), file=f, append=TRUE)
  cat(paste(hdr, collapse="\n"), file=f, append=TRUE)
  cat(paste(tbl, collapse="\n"), file=f, append=TRUE)
  cat(paste(pst, collapse="\n"), file=f, append=TRUE)
}



generate_package_pages = function(root, descs)
{
  dir = paste0(root, "/www/packages")
  if (!dir.exists(dir))
    dir.create(dir)
  
  for (i in 1:length(descs))
  {
    pkg = descs[[i]]["Package"]
    
    pre = readLines(paste0(root, "www/utils/pre.html"))
    hdr = paste0("<h2>", pkg, ": ", descs[[i]]["Title"], "</h2>\n", descs[[i]]["Description"], "\n\n")
    tbl = capture.output(package_table(i, descs))
    pst = readLines(paste0(root, "www/utils/post.html"))
    
    f = paste0(root, "/www/packages/", pkg, ".html")
    cat("<!--Automatically generated. Do not edit by hand-->\n\n", file=f, append=FALSE)
    cat(paste(pre, collapse="\n"), file=f, append=TRUE)
    cat(paste(hdr, collapse="\n"), file=f, append=TRUE)
    cat(paste(tbl, collapse="\n"), file=f, append=TRUE)
    cat(paste(pst, collapse="\n"), file=f, append=TRUE)
  }
}



update_package_html = function(root)
{
  packages = dir(paste0(root, "/cran/src/contrib/"), pattern=".tar.gz")
  descs = lapply(packages, extract_description, root=root)
  
  generate_packages_page(root=root, descs=descs)
  generate_package_pages(root=root, descs=descs)
}



update_package_html("/hpcran/")

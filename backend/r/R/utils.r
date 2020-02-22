file.move = function(from, to)
{
  file.copy(from=from, to=to)
  file.remove(from)
}



pkgname = function(file)
{
  sub(x=basename(file), pattern="_.*", replacement="")
}



pkgver = function(file)
{
  ver = gsub(basename(file), pattern="(.*_|.tar.gz)", replacement="")
  package_version(ver)
}

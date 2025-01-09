import java

overlay[local]
pragma[nomagic]
predicate discardableLocation(string file, @location l) {
  not hasOverlay() and
  file = getRawFileForLoc(l) and
  not (exists(@file f | hasLocation(f, l)))
}

pragma[nomagic]
discard predicate discardLocation(@location l) {
  exists(string file | discardableLocation(file, l) and discardFile(file))
}

private predicate foo(Location l) {
  locations_default(l, _, _, _, _, _)
}
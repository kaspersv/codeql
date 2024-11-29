import java

pragma[nomagic]
predicate hasOverlay() { externalData(_, "/github/codeql/overlay-experiment", 0, "overlay") }

string getRawFile(Element el) { el.getLocation().hasLocationInfo(result, _, _, _, _) }

string getRawFileForLoc(Location l) { l.hasLocationInfo(result, _, _, _, _) }

pragma[nomagic]
predicate discardFile(string file) {
  hasOverlay() and
  exists(Expr e | exists(e.getEnclosingCallable()) and file = getRawFile(e))
}

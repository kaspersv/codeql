import java

pragma[noinline]
predicate hasOverlay() { externalData(_, "/github/codeql/overlay-experiment", 0, "overlay") }

string getRawFile(Element el) { el.getLocation().hasLocationInfo(result, _, _, _, _) }

pragma[noinline] predicate discardable(string file, Element el) {
  not hasOverlay() and
  file = [getRawFile(el.(Expr)), getRawFile(el.(Stmt)), getRawFile(el.(LocalScopeVariable))]
}

pragma[noinline] predicate discard(string file) {
  hasOverlay() and
  exists(Expr e | exists(e.getEnclosingCallable()) and file = getRawFile(e))
}

pragma[nomagic] recompute
predicate discardElement(Element el) {
  exists(string file | discardable(file, el) and discard(file))
}

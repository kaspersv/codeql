import java

overlay[local]
pragma[nomagic]
predicate discardableExpr(string file, @expr e) {
  not hasOverlay() and
  file = getRawFile(e)
}

pragma[nomagic]
discard predicate discardExpr(@expr e) {
  exists(string file | discardableExpr(file, e) and discardFile(file))
}

private predicate foo(Expr e) {
  exprs(e, _, _, _, _)
}
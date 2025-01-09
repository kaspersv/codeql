import java

overlay[local]
pragma[nomagic]
predicate discardableStmt(string file, @stmt s) {
  not hasOverlay() and
  file = getRawFile(s)
}

pragma[nomagic]
discard predicate discardStmt(@stmt s) {
  exists(string file | discardableStmt(file, s) and discardFile(file))
}

private predicate foo(Stmt s) {
  stmts(s, _, _, _, _)
}
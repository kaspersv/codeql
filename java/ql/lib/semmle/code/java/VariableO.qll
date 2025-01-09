import java

overlay[local]
pragma[nomagic]
predicate discardableLocalVarDecl(string file, @localvar l) {
  not hasOverlay() and
  file = getRawFile(l)
}

pragma[nomagic]
discard predicate discardLocalVarDecl(@localvar l) {
  exists(string file | discardableLocalVarDecl(file, l) and discardFile(file))
}

private predicate foo(LocalVariableDecl v) {
  localvars(v, _, _, _)
}
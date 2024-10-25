import java
import semmle.code.java.dataflow.DataFlow

pragma[noinline] predicate discardNode(DataFlow::Node node) {
    discardElement(node.asExpr())
    or
    discardElement(node.(DataFlow::PostUpdateNode).getPreUpdateNode().asExpr())
    // TODO: add more cases
}